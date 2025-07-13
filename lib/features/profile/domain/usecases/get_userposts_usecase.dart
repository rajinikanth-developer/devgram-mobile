import '../../../feed/domain/entities/post_entity.dart';
import '../../../feed/domain/repositories/feed_repository.dart';

class GetUserpostsUsecase {
  final FeedRepository repository;

  GetUserpostsUsecase(this.repository);

  Future<List<PostEntity>> call() async {
    return await repository.getUserPostsById();
  }
}
