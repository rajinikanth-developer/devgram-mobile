import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common_widgets/fab_widget.dart';
import '../../../../core/common_widgets/parent_widget.dart';
import '../../../../core/common_widgets/post_card_widget.dart';
import '../../../../core/common_widgets/text_widget.dart';
import '../../../../core/constants/strings/app_strings.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../feed/data/models/post_model.dart';
import '../../../feed/domain/entities/post_entity.dart';
import '../bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileScreen> {
  late ProfileBloc profileBloc;

  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(LoadUserData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
      context: context,
      childWidget: profileWidget(),
      hasHeader: true,
      appbarTitle: AppStrings.profileScreenTitle,
      floatingActionButton: FABWidget.getFAB(context),
    );
  }

  Widget profileWidget() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is LoadingUserData) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserDataLoaded) {
          return _buildUserProfile(state.userData, state.userPosts);
        } else if (state is UserDataLoadingFailed) {
          return Center(child: Text(state.error));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildUserProfile(UserModel currentUser, List<PostModel> userPosts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: currentUser.name, fontSize: 24, isBold: true),
              TextWidget(text: currentUser.email, fontSize: 14)
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextWidget(
              text: '${AppStrings.myPosts} (${userPosts.length})',
              fontSize: 18,
              isBold: true),
        ),
        userPosts.isEmpty ? _buildNoPostsSection() : SizedBox.shrink(),
        Expanded(
          child: ListView.builder(
            itemCount: userPosts.length,
            itemBuilder: (context, index) {
              final post = userPosts[index];
              // Convert PostModel to PostEntity before passing to PostCard
              return PostCard(
                  post: PostEntity.fromModel(post),
                  currentUserId: currentUser.id);
            },
          ),
        ),
      ],
    );
  }
}

Widget _buildNoPostsSection() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const Icon(Icons.post_add, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          TextWidget(
            text: AppStrings.noPosts,
            isBold: true,
            fontSize: 18,
          ),
          const SizedBox(height: 8),
          TextWidget(
            text: AppStrings.noPostsDesc,
          ),
        ],
      ),
    ),
  );
}
