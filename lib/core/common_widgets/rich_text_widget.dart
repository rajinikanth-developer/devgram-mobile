import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class RichTextWidget extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  Function onSecondaryTextTap;

  RichTextWidget({
    super.key,
    required this.primaryText,
    required this.secondaryText,
    required this.onSecondaryTextTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(text: primaryText),
          const TextSpan(text: ' '),
          TextSpan(
            text: secondaryText,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = onSecondaryTextTap as void Function()?,
          ),
        ],
      ),
    );
  }
}
