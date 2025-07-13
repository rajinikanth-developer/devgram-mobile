part of 'create_post_bloc.dart';

sealed class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object> get props => [];
}

final class CreatePostInitial extends CreatePostState {}

class CreatePostLoading extends CreatePostState {
  const CreatePostLoading();
}

class CreatePostSuccess extends CreatePostState {
  final String message;
  const CreatePostSuccess(this.message);
}

class CreatePostFailure extends CreatePostState {
  final String error;
  const CreatePostFailure(this.error);
}
