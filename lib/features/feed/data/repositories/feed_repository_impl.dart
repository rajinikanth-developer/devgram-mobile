import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasources/feed_local_ds.dart';
import '../models/post_model.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedLocalDataSource localDataSource;

  FeedRepositoryImpl({required this.localDataSource});

  @override
  Future<List<PostEntity>> getAllPosts() async {
    final posts = await localDataSource.getAllPosts();
    return posts.map((model) => _mapModelToEntity(model)).toList();
  }

  @override
  Future<void> likePost(PostEntity post) async {
    await localDataSource.likePost(post);
  }

  @override
  Future<void> publishPost(PostEntity post) async {
    await localDataSource.publishPost(post);
  }

  @override
  Future<void> refreshPosts() async {
    await localDataSource.getAllPosts();
  }

  @override
  Future<List<PostEntity>> getUserPostsById() async {
    final posts = await localDataSource.getUserPostsById();
    return posts.map((model) => _mapModelToEntity(model)).toList();
  }

  PostEntity _mapModelToEntity(PostModel model) {
    return PostEntity(
      id: model.id,
      createdUserId: model.createdUserId,
      title: model.title,
      content: model.content,
      timestamp: model.timestamp,
      imagePath: model.imagePath,
      likedBy: model.likedBy,
    );
  }
}
