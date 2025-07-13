import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/strings/app_strings.dart';

class AppUtils {
  static getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Color getSnackBarColor(messageType) {
    var selectedColor = AppColors.primaryColor;
    switch (messageType) {
      case AppStrings.warning:
        return selectedColor = AppColors.warningColor;
      case AppStrings.success:
        return selectedColor = AppColors.successColor;
      case AppStrings.failure:
        return selectedColor = AppColors.errorColor;
    }
    return selectedColor;
  }
}
