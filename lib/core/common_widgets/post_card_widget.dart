import 'dart:io';
import 'package:devgram/features/feed/domain/entities/post_entity.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../utils/app_utils.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;
  final String? currentUserId;

  const PostCard({Key? key, required this.post, this.currentUserId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardColor,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (post.imagePath != null && post.imagePath != '')
              ? SizedBox(
                  height: AppUtils.getScreenHeight(context) * 0.3,
                  width: AppUtils.getScreenWidth(context),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: Image.file(
                        File(post.imagePath!),
                        fit: BoxFit.cover,
                      )),
                )
              : SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                if (post.content != null)
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(post.content!),
                  ),
                Divider(
                  color: AppColors.dividerColor,
                ),
                Row(
                  children: [
                    Icon(
                        post.likedBy!.length > 0 &&
                                post.likedBy!.contains(currentUserId)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: post.likedBy!.length > 0 &&
                                post.likedBy!.contains(currentUserId)
                            ? Colors.red
                            : Colors.grey),
                    SizedBox(width: 4),
                    Text('${post.likedBy!.length}'),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
