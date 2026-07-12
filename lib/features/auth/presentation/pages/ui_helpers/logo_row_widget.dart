import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/colors/app_colors.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';

Widget buildLogoRow(AppColors colors, TextTheme textTheme) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 32.0, top: 32.0),
        child: Row(
          children: [
            MessIcon(SvgIcons.logo, size: 34),
            const SizedBox(width: 10),
            Text(
              'Mess Messenger',
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
          ],
        ),
      ),
    ],
  );
}
