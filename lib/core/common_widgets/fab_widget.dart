import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';
import '../constants/path_constants.dart';
import '../constants/strings/app_strings.dart';

class FABWidget {
  static FloatingActionButton getFAB(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: () {
        // Navigate to create post screen
        context.push(PathConstants.createPostScreen,
            extra: AppStrings.feed); // Pass 'feed' as the source screen
      },
      child: Icon(
        Icons.post_add,
        color: AppColors.buttonTextColor,
        size: 30,
      ),
    );
  }
}
