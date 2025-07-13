import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/common_widgets/button_widgets.dart';
import '../../../../core/common_widgets/loader_widget.dart';
import '../../../../core/common_widgets/parent_widget.dart';
import '../../../../core/common_widgets/snackbar_widget.dart';
import '../../../../core/constants/path_constants.dart';
import '../../../../core/constants/strings/app_strings.dart';
import '../../../../core/constants/strings/validation_messages.dart';
import '../../../../core/services/image_serivce.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../feed/domain/entities/post_entity.dart';
import '../bloc/create_post_bloc.dart';

class CreatePostScreen extends StatefulWidget {
  final String sourceScreen;
  const CreatePostScreen({super.key, this.sourceScreen = AppStrings.feed});
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  late CreatePostBloc createPostBloc;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  File? _imagePath;

  @override
  void initState() {
    createPostBloc = BlocProvider.of<CreatePostBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
      context: context,
      childWidget: postUI(),
      hasHeader: true,
      hasBackBtn: true,
      appbarTitle: AppStrings.createPostTitle,
    );
  }

  Widget postUI() {
    return BlocConsumer<CreatePostBloc, CreatePostState>(
        listener: (context, state) {
      if (state is CreatePostLoading) {
        LoaderWidget().show(context);
      } else if (state is CreatePostSuccess) {
        LoaderWidget().hide();
        if (ScaffoldMessenger.of(context).mounted) {
          SnackBarWidget(
            context: context,
            message: state.message,
            messageType: AppStrings.success,
          ).show();
        }

        Future.delayed(Duration(milliseconds: 300), () {
          context.go(
            PathConstants.dashboardScreen,
            extra: {AppStrings.refreshFeed: true},
          );
        });
      } else if (state is CreatePostFailure) {
        LoaderWidget().hide();
        if (ScaffoldMessenger.of(context).mounted) {
          SnackBarWidget(
            context: context,
            message: state.error,
            messageType: AppStrings.failure,
          ).show();
        }
      }
    }, builder: (context, state) {
      return _createPostUI();
    });
  }

  Widget _createPostUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: AppStrings.postTitle,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => AppValidators.emptyValidator(value!)
                    ? AppValidationMessages.requiredField
                    : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: AppStrings.postDescription,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 16),
              ButtonWidgets.elevatedButtonWithIcon(
                  AppStrings.addImage, _pickImage, Icons.image),
              SizedBox(height: 16),
              _imagePath != null
                  ? SizedBox(
                      height: 200,
                      child: Image.file(
                        _imagePath!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 24),
              ButtonWidgets.elevatedButton(
                AppStrings.publish,
                _createPost,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createPost() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      PostEntity newPost = PostEntity(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _titleController.text,
          content: _contentController.text.isNotEmpty
              ? _contentController.text
              : null,
          imagePath: _imagePath != null
              ? await ImageService.saveImagePermanently(_imagePath!)
              : '',
          timestamp: DateTime.now());
      createPostBloc.add(CreatePost(newPost));
    }
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() => _imagePath = File(image.path));
      }
    } catch (e) {
      SnackBarWidget(
              context: context,
              message: AppValidationMessages.errorPickImage,
              messageType: AppStrings.failure)
          .show();
    }
  }
}
