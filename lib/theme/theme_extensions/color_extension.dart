import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/colors/app_colors.dart';

extension AppThemeExtension on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
