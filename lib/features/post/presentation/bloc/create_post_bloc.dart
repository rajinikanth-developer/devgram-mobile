import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/constants/strings/validation_messages.dart';
import '../../../feed/domain/entities/post_entity.dart';
import '../../domain/usecases/create_post_usecase.dart';
part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final CreatePostUsecase createPostUsecase;
  CreatePostBloc({required this.createPostUsecase})
      : super(CreatePostInitial()) {
    on<CreatePost>(_createPost);
  }

  void _createPost(CreatePost event, Emitter<CreatePostState> emit) async {
    emit(CreatePostLoading());
    try {
      final post = await createPostUsecase(event.post);
      emit(CreatePostSuccess(AppValidationMessages.postPublished));
    } catch (e) {
      emit(CreatePostFailure(e.toString()));
    }
  }
}
