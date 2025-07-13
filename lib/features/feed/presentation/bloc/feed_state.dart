part of 'feed_bloc.dart';

sealed class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

final class FeedInitial extends FeedState {}

class LoadingPosts extends FeedState {
  const LoadingPosts();
}

class LoadedPosts extends FeedState {
  final List<PostEntity> posts;

  const LoadedPosts({required this.posts});

  @override
  List<Object> get props => [posts];
}

class ErrorLoadingPosts extends FeedState {
  const ErrorLoadingPosts(this.error);
  final String error;
}
