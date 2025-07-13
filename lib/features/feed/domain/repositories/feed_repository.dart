import '../entities/post_entity.dart';

abstract class FeedRepository {
  Future<List<PostEntity>> getAllPosts();
  Future<void> publishPost(PostEntity post);
  Future<void> refreshPosts();
  Future<void> likePost(PostEntity post);
  Future<List<PostEntity>> getUserPostsById();
}
