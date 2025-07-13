import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../utils/app_utils.dart';
import 'text_widget.dart';

var duration = 3;

class SnackBarWidget {
  BuildContext context;
  String message;
  String messageType;

  SnackBarWidget({
    required this.context,
    required this.message,
    required this.messageType,
  });

  void show() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          behavior: SnackBarBehavior.fixed,
          backgroundColor: AppUtils.getSnackBarColor(messageType),
          duration: Duration(seconds: 2),
          content: TextWidget(
            text: message,
            color: AppColors.buttonTextColor,
            fontSize: 14.0,
          )),
    );
  }
}
