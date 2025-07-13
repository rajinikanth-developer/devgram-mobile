import 'package:devgram/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final String? fontFamily;
  final double? fontSize;
  final bool? isBold;

  TextWidget({
    required this.text,
    this.color = AppColors.textColor,
    this.fontFamily = 'Roboto',
    this.fontSize = 14.0,
    this.isBold,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
