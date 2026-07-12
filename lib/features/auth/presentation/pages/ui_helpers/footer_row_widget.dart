import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/colors/app_colors.dart';

Widget buildFooter(AppColors colors, TextTheme textTheme) {
  return Container(
    height: 68,
    color: colors.surface0,
    padding: const EdgeInsets.only(top: 26, left: 32, bottom: 26),
    child: Text(
      '©Mess Messenger 2026',
      style: textTheme.bodyMedium?.copyWith(color: colors.text2),
    ),
  );
}
