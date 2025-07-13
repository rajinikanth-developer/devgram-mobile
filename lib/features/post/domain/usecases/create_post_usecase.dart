import '../../../feed/domain/entities/post_entity.dart';
import '../../../feed/domain/repositories/feed_repository.dart';

class CreatePostUsecase {
  final FeedRepository repository;

  CreatePostUsecase(this.repository);

  Future<void> call(PostEntity post) async {
    return await repository.publishPost(post);
  }
}
