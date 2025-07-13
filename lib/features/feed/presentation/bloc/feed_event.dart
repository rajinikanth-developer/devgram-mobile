part of 'feed_bloc.dart';

sealed class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class FetchAllPosts extends FeedEvent {
  const FetchAllPosts();
}

class RefreshPosts extends FeedEvent {
  const RefreshPosts();
}

class LikedPost extends FeedEvent {
  final PostEntity post;

  const LikedPost(this.post);

  @override
  List<Object> get props => [post];
}
