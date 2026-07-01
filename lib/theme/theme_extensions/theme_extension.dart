import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/app_icons.dart';
import 'package:mess_messenger_app/core/utils/colors/app_colors.dart';

extension AppThemeExtension on BuildContext {
  AppColors get colors =>
      Theme.of(this).extension<AppColors>() ?? AppColors.light();
  TextTheme get textStyles => Theme.of(this).textTheme;
  AppIcons get icons =>
      Theme.of(this).extension<AppIcons>() ?? AppIcons.light();
}
