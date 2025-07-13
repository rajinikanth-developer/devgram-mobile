import '../../data/models/post_model.dart';

class PostEntity {
  final String id;
  final String? createdUserId;
  final String title;
  final String? content;
  final DateTime timestamp;
  final String? imagePath;
  final List<String>? likedBy;

  PostEntity({
    required this.id,
    this.createdUserId,
    required this.title,
    this.content,
    required this.timestamp,
    this.imagePath,
    this.likedBy,
  });

  PostModel toModel() => PostModel(
        id: id,
        createdUserId: createdUserId!,
        title: title,
        content: content,
        timestamp: timestamp,
        imagePath: imagePath,
        likedBy: likedBy,
      );

  factory PostEntity.fromModel(PostModel model) => PostEntity(
        id: model.id,
        createdUserId: model.createdUserId,
        title: model.title,
        content: model.content,
        timestamp: model.timestamp,
        imagePath: model.imagePath,
        likedBy: model.likedBy,
      );

  // void toggleLike(String userId) {
  //   if (likedBy!.contains(userId)) {
  //     likedBy!.remove(userId);
  //   } else {
  //     likedBy!.add(userId);
  //   }
  // }
}
