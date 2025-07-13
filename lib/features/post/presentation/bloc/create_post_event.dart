part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

class CreatePost extends CreatePostEvent {
  PostEntity post;
  CreatePost(this.post);

  @override
  List<Object> get props => [post];
}
