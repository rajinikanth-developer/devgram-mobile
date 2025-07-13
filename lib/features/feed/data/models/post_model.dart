import 'package:hive/hive.dart';
part 'post_model.g.dart';

@HiveType(typeId: 1)
class PostModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String createdUserId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String? content;

  @HiveField(4)
  final DateTime timestamp;

  @HiveField(5)
  final String? imagePath;

  @HiveField(6)
  List<String> likedBy;

  PostModel({
    required this.id,
    required this.createdUserId,
    required this.title,
    this.content,
    required this.timestamp,
    this.imagePath,
    List<String>? likedBy,
  }) : likedBy = likedBy ?? [];

  // void toggleLike(String userId) {
  //   if (likedBy.contains(userId)) {
  //     likedBy.remove(userId);
  //   } else {
  //     likedBy.add(userId);
  //   }
  // }
}
