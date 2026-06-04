import 'package:flutter/material.dart';

import 'app_palette.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color surface0;
  final Color surface2;
  final Color text1;
  final Color text2;
  final Color textInverse;
  final Color icon1;
  final Color icon2;
  final Color textPlaceHolder;
  final Color textHint;
  final Color buttonPrimary;
  final Color link;
  // final Color background;
  // final Color foreground;
  // final Color card;
  // final Color primary;
  // final Color destructive;
  // final Color success;
  // final Color warning;
  // final Color info;
  const AppColors({
    required this.surface0,
    required this.surface2,
    required this.text1,
    required this.text2,
    required this.textInverse,
    required this.icon1,
    required this.icon2,
    required this.textPlaceHolder,
    required this.textHint,
    required this.buttonPrimary,
    required this.link,

    // required this.background,
    // required this.foreground,
    // required this.card,
    // required this.primary,
    // required this.destructive,
    // required this.success,
    // required this.warning,
    // required this.info,
  });

  /// ✅ Light preset
  factory AppColors.light() => const AppColors(
    surface0: AppPalette.surface0Light,
    surface2: AppPalette.surface2Light,
    text1: AppPalette.text1Light,
    text2: AppPalette.text2Light,
    textInverse: AppPalette.textInverseLight,
    icon1: AppPalette.icon1Light,
    icon2: AppPalette.icon2Light,
    textPlaceHolder: AppPalette.textPlaceHolderLight,
    textHint: AppPalette.textHintLight,
    buttonPrimary: AppPalette.buttonPrimaryLight,
    link: AppPalette.linkLight,

    // background: AppPalette.background,
    // foreground: AppPalette.foreground,
    // card: AppPalette.card,
    // primary: AppPalette.primary,
    // destructive: AppPalette.destructive,
    // success: AppPalette.success,
    // warning: AppPalette.warning,
    // info: AppPalette.info,
  );

  /// ✅ Dark preset
  factory AppColors.dark() => const AppColors(
    surface0: AppPalette.surface0Dark,
    surface2: AppPalette.surface2Dark,
    text1: AppPalette.text1Dark,
    text2: AppPalette.text2Dark,
    textInverse: AppPalette.textInverseDark,
    icon1: AppPalette.icon1Dark,
    icon2: AppPalette.icon2Dark,
    textPlaceHolder: AppPalette.textPlaceHolderDark,
    textHint: AppPalette.textHintDark,
    buttonPrimary: AppPalette.buttonPrimaryDark,
    link: AppPalette.linkDark,

    // background: AppPalette.darkBackground,
    // foreground: AppPalette.darkForeground,
    // card: AppPalette.darkCard,
    // primary: AppPalette.primaryGlow,
    // destructive: Color(0xFF7F1D1D),
    // success: Color(0xFF15803D),
    // warning: Color(0xFFB45309),
    // info: Color(0xFF0284C7),
  );
  @override
  AppColors copyWith({
    Color? surface0,
    Color? surface2,
    Color? text1,
    Color? text2,
    Color? textInverse,
    Color? icon1,
    Color? icon2,
    Color? textPlaceHolder,
    Color? textHint,
    Color? buttonPrimary,
    Color? link,
    // Color? background,
    // Color? foreground,
    // Color? card,
    // Color? primary,
    // Color? destructive,
    // Color? success,
    // Color? warning,
    // Color? info,
  }) {
    return AppColors(
      surface0: surface0 ?? this.surface0,
      surface2: surface2 ?? this.surface2,
      text1: text1 ?? this.text1,
      text2: text2 ?? this.text2,
      textInverse: textInverse ?? this.textInverse,
      icon1: icon1 ?? this.icon1,
      icon2: icon2 ?? this.icon2,
      textPlaceHolder: textPlaceHolder ?? this.textPlaceHolder,
      textHint: textHint ?? this.textHint,
      buttonPrimary: buttonPrimary ?? this.buttonPrimary,
      link: link ?? this.link,
      // background: background ?? this.background,
      // foreground: foreground ?? this.foreground,
      // card: card ?? this.card,
      // primary: primary ?? this.primary,
      // destructive: destructive ?? this.destructive,
      // success: success ?? this.success,
      // warning: warning ?? this.warning,
      // info: info ?? this.info,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      surface0: Color.lerp(surface0, other.surface0, t)!,
      surface2: Color.lerp(surface2, other.surface2, t)!,
      text1: Color.lerp(text1, other.text1, t)!,
      text2: Color.lerp(text2, other.text2, t)!,
      textInverse: Color.lerp(textInverse, other.textInverse, t)!,
      icon1: Color.lerp(icon1, other.icon1, t)!,
      icon2: Color.lerp(icon2, other.icon2, t)!,
      textPlaceHolder: Color.lerp(textPlaceHolder, other.textPlaceHolder, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      buttonPrimary: Color.lerp(buttonPrimary, other.buttonPrimary, t)!,
      link: Color.lerp(link, other.link, t)!,

      // background: Color.lerp(background, other.background, t)!,
      // foreground: Color.lerp(foreground, other.foreground, t)!,
      // card: Color.lerp(card, other.card, t)!,
      // primary: Color.lerp(primary, other.primary, t)!,
      // destructive: Color.lerp(destructive, other.destructive, t)!,
      // success: Color.lerp(success, other.success, t)!,
      // warning: Color.lerp(warning, other.warning, t)!,
      // info: Color.lerp(info, other.info, t)!,
    );
  }
}

// class AppColors {
//   AppColors._();
//
//   /// The color white
//   static const white = Colors.white;
//
//   /// The color black
//   static const black = Colors.black;
//
//   /// The color transparent
//   static const transparent = Colors.transparent;
//
//   /// Brand color palette.
//   static const brand = MaterialColor(0xFF347AF6, {
//     50: Color(0xFFF0F5FF),
//     100: Color(0xFFE0ECFF),
//     150: Color(0xFFD3E1FB),
//     200: Color(0xFFBDD3F9),
//     250: Color(0xFF9FBFF9),
//     300: Color(0xFF81ACF9),
//     400: Color(0xFF5A93F9),
//     500: Color(0xFF347AF6),
//     600: Color(0xFF1559D1),
//     700: Color(0xFF174EAF),
//     800: Color(0xFF1D4387),
//     900: Color(0xFF163367),
//   });
//
//   /// Light gray color palette.
//   static const grayLight = MaterialColor(0xFF667085, {
//     50: Color(0xFFFCFCFD),
//     100: Color(0xFFF9FAFB),
//     150: Color(0xFFF2F4F7),
//     200: Color(0xFFEAECF0),
//     250: Color(0xFFD0D5DD),
//     300: Color(0xFF98A2B3),
//     400: Color(0xFF667085),
//     500: Color(0xFF475467),
//     600: Color(0xFF344054),
//     700: Color(0xFF182230),
//     800: Color(0xFF101828),
//     900: Color(0xFF0C111D),
//   });
//
//   /// Dark gray color palette.
//   static const grayDark = MaterialColor(0xFF85888E, {
//     50: Color(0xFFFAFAFA),
//     100: Color(0xFFF5F5F6),
//     150: Color(0xFFF0F1F1),
//     200: Color(0xFFECECED),
//     250: Color(0xFFCECFD2),
//     300: Color(0xFF94969C),
//     400: Color(0xFF85888E),
//     500: Color(0xFF61646C),
//     600: Color(0xFF333741),
//     700: Color(0xFF1F242F),
//     800: Color(0xFF161B26),
//     900: Color(0xFF0C111D),
//   });
// }
