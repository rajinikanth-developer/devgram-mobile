import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'text_widget.dart';

class ButtonWidgets {
  static Widget elevatedButton(
    String title,
    void Function()? onPressed, {
    double height = 48,
    double width = double.infinity,
    double radius = 1.0,
    double fontSize = 16.0,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: TextWidget(
            text: title,
            color: AppColors.buttonTextColor,
            isBold: true,
            fontSize: fontSize),
      ),
    );
  }

  static Widget elevatedButtonWithIcon(
    String title,
    void Function()? onPressed,
    IconData icon, {
    double height = 48,
    double width = 150,
    double radius = 1.0,
    double fontSize = 16.0,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.buttonTextColor),
        label: TextWidget(
            text: title,
            color: AppColors.buttonTextColor,
            isBold: true,
            fontSize: fontSize),
      ),
    );
  }
}
