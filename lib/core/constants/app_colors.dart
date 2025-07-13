import 'package:flutter/material.dart';

class AppColors {
  // Common Colors
  static const Color transparentColor = Colors.transparent;
  static const Color primaryColor = Color.fromARGB(255, 17, 56, 88);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF212121);
  static const Color errorColor = Color(0xFFB00020);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color buttonColor = primaryColor;
  static const Color buttonTextColor = backgroundColor;
  static const Color cardColor = Color.fromARGB(255, 209, 209, 209);
  static const Color dividerColor = Colors.black;

  static Color circleBorderColor = hexToColors("#D8D8D8");
}

Color hexToColors(String s) {
  return Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
}
