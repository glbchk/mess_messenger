import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/colors/app_palette.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color surface0;
  final Color surface2;
  final Color surface4;
  final Color text1;
  final Color text2;
  final Color textInverse;
  final Color icon1;
  final Color icon2;
  final Color textPlaceHolder;
  final Color textHint;
  final Color buttonPrimary;
  final Color link;
  final Color border2;
  final Color bg;
  final Color transparent;

  const AppColors({
    required this.surface0,
    required this.surface2,
    required this.surface4,
    required this.text1,
    required this.text2,
    required this.textInverse,
    required this.icon1,
    required this.icon2,
    required this.textPlaceHolder,
    required this.textHint,
    required this.buttonPrimary,
    required this.link,
    required this.border2,
    required this.bg,
    required this.transparent,
  });

  /// ✅ Light preset
  factory AppColors.light() => const AppColors(
    surface0: AppPalette.surface0Light,
    surface2: AppPalette.surface2Light,
    surface4: AppPalette.surface4Light,
    text1: AppPalette.text1Light,
    text2: AppPalette.text2Light,
    textInverse: AppPalette.textInverseLight,
    icon1: AppPalette.icon1Light,
    icon2: AppPalette.icon2Light,
    textPlaceHolder: AppPalette.textPlaceHolderLight,
    textHint: AppPalette.textHintLight,
    buttonPrimary: AppPalette.buttonPrimaryLight,
    link: AppPalette.linkLight,
    border2: AppPalette.border2Light,
    bg: AppPalette.bgLight,
    transparent: AppPalette.transparentLight,
  );

  /// ✅ Dark preset
  factory AppColors.dark() => const AppColors(
    surface0: AppPalette.surface0Dark,
    surface2: AppPalette.surface2Dark,
    surface4: AppPalette.surface4Dark,
    text1: AppPalette.text1Dark,
    text2: AppPalette.text2Dark,
    textInverse: AppPalette.textInverseDark,
    icon1: AppPalette.icon1Dark,
    icon2: AppPalette.icon2Dark,
    textPlaceHolder: AppPalette.textPlaceHolderDark,
    textHint: AppPalette.textHintDark,
    buttonPrimary: AppPalette.buttonPrimaryDark,
    link: AppPalette.linkDark,
    border2: AppPalette.border2Dark,
    bg: AppPalette.bgDark,
    transparent: AppPalette.transparentDark,
  );
  @override
  AppColors copyWith({
    Color? surface0,
    Color? surface2,
    Color? surface4,
    Color? text1,
    Color? text2,
    Color? textInverse,
    Color? icon1,
    Color? icon2,
    Color? textPlaceHolder,
    Color? textHint,
    Color? buttonPrimary,
    Color? link,
    Color? border2,
    Color? bg,
    Color? transparent,
  }) {
    return AppColors(
      surface0: surface0 ?? this.surface0,
      surface2: surface2 ?? this.surface2,
      surface4: surface4 ?? this.surface4,
      text1: text1 ?? this.text1,
      text2: text2 ?? this.text2,
      textInverse: textInverse ?? this.textInverse,
      icon1: icon1 ?? this.icon1,
      icon2: icon2 ?? this.icon2,
      textPlaceHolder: textPlaceHolder ?? this.textPlaceHolder,
      textHint: textHint ?? this.textHint,
      buttonPrimary: buttonPrimary ?? this.buttonPrimary,
      link: link ?? this.link,
      border2: border2 ?? this.border2,
      bg: bg ?? this.bg,
      transparent: transparent ?? this.transparent,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      surface0: Color.lerp(surface0, other.surface0, t)!,
      surface2: Color.lerp(surface2, other.surface2, t)!,
      surface4: Color.lerp(surface4, other.surface4, t)!,
      text1: Color.lerp(text1, other.text1, t)!,
      text2: Color.lerp(text2, other.text2, t)!,
      textInverse: Color.lerp(textInverse, other.textInverse, t)!,
      icon1: Color.lerp(icon1, other.icon1, t)!,
      icon2: Color.lerp(icon2, other.icon2, t)!,
      textPlaceHolder: Color.lerp(textPlaceHolder, other.textPlaceHolder, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      buttonPrimary: Color.lerp(buttonPrimary, other.buttonPrimary, t)!,
      link: Color.lerp(link, other.link, t)!,
      border2: Color.lerp(border2, other.border2, t)!,
      bg: Color.lerp(bg, other.bg, t)!,
      transparent: Color.lerp(transparent, other.transparent, t)!,
    );
  }
}
