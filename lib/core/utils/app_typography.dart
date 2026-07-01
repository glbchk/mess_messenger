import 'package:flutter/material.dart';

interface class AppTypography extends ThemeExtension<AppTypography> {
  /// {@macro app_typography}
  AppTypography({
    required this.buttonLarge,
    required this.buttonMedium,
    required this.buttonSmall,
  });

  /// Button Large
  final TextStyle buttonLarge;

  /// Button Medium
  final TextStyle buttonMedium;

  /// Button Small
  final TextStyle buttonSmall;

  @override
  ThemeExtension<AppTypography> copyWith({
    TextStyle? buttonLarge,
    TextStyle? buttonMedium,
    TextStyle? buttonSmall,
  }) {
    return AppTypography(
      buttonLarge: buttonLarge ?? this.buttonLarge,
      buttonMedium: buttonMedium ?? this.buttonMedium,
      buttonSmall: buttonSmall ?? this.buttonSmall,
    );
  }

  @override
  ThemeExtension<AppTypography> lerp(
    covariant ThemeExtension<AppTypography>? other,
    double t,
  ) {
    if (other is! AppTypography) {
      return this;
    }

    return AppTypography(
      buttonLarge: TextStyle.lerp(buttonLarge, other.buttonLarge, t)!,
      buttonMedium: TextStyle.lerp(buttonMedium, other.buttonMedium, t)!,
      buttonSmall: TextStyle.lerp(buttonSmall, other.buttonSmall, t)!,
    );
  }
}

/// {@macro app_typography}
class AppRegularTypography extends AppTypography {
  /// {@macro app_typography}
  AppRegularTypography({
    super.buttonLarge = const TextStyle(
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w500,
    ),
    super.buttonMedium = const TextStyle(
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w500,
    ),
    super.buttonSmall = const TextStyle(
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w500,
    ),
  });
}
