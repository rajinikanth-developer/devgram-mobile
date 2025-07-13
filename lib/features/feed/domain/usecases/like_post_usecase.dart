import '../entities/post_entity.dart';
import '../repositories/feed_repository.dart';

class LikePostUsecase {
  final FeedRepository repository;

  LikePostUsecase(this.repository);

  Future<void> call(PostEntity post) async {
    await repository.likePost(post);
  }
}
