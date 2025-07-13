import '../repositories/feed_repository.dart';
import '../entities/post_entity.dart';

class GetPostsUseCase {
  final FeedRepository repository;

  GetPostsUseCase(this.repository);

  Future<List<PostEntity>> call() async {
    return await repository.getAllPosts();
  }
}
