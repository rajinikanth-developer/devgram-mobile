import 'package:hive/hive.dart';
import '../../../auth/data/datasources/auth_local_ds.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domain/entities/post_entity.dart';
import '../models/post_model.dart';

abstract class FeedLocalDataSource {
  Future<UserModel?> getCurrentUser();
  Future<List<PostModel>> getAllPosts();
  Future<void> publishPost(PostEntity post);
  Future<void> likePost(PostEntity post);
  Future<List<PostModel>> getUserPostsById();
}

class FeedLocalDataSourceImpl implements FeedLocalDataSource {
  final Box<PostModel> postsBox;
  final AuthLocalDataSource authLocalDataSource;

  FeedLocalDataSourceImpl(
      {required this.postsBox, required this.authLocalDataSource});

  @override
  Future<UserModel?> getCurrentUser() async {
    return authLocalDataSource.getCurrentUser();
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    return postsBox.values.toList();
  }

  @override
  Future<void> publishPost(PostEntity post) async {
    final user = await authLocalDataSource.getCurrentUser();
    PostEntity newPost = PostEntity(
        id: post.id,
        createdUserId: user!.id,
        title: post.title,
        timestamp: post.timestamp,
        content: post.content,
        imagePath: post.imagePath,
        likedBy: []);
    final postModel = newPost.toModel();
    await postsBox.put(newPost.id, postModel);
  }

  @override
  Future<void> likePost(PostEntity post) async {
    final postModel = postsBox.get(post.id);
    if (postModel != null) {
      final user = await authLocalDataSource.getCurrentUser();
      if (postModel.likedBy.contains(user!.id)) {
        postModel.likedBy.remove(user.id);
      } else {
        postModel.likedBy.add(user.id);
      }
      await postModel.save();
    }
  }

  @override
  Future<List<PostModel>> getUserPostsById() async {
    final user = await authLocalDataSource.getCurrentUser();
    return postsBox.values
        .where((post) => post.createdUserId == user!.id)
        .toList();
  }
}
