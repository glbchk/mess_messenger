import 'package:flutter/material.dart';

const fontFamily = "RobotoFlex";

TextTheme buildTextTheme({required bool isDesktop}) {
  // final double headingXXXL = isDesktop ? 60.0 : 60.0;
  // final double headingXL = isDesktop ? 36.0 : 36.0;
  // final double headingL = isDesktop ? 28.0 : 28.0;
  // final double bodyL = isDesktop ? 20.0 : 18.0;
  // final double bodyS = isDesktop ? 14.0 : 14.0;
  // final double bodyXS = isDesktop ? 12.0 : 12.0;
  // final double labelLStrong = isDesktop ? 16.0 : 16.0;
  // final double labelSStrong = isDesktop ? 14.0 : 14.0;

  final double displayLarge = 60.0; //Medium 500
  final double displayMedium = 36.0; //Medium 500
  final double displaySmall = 28.0; //Medium 500
  final double headlineLarge = 22.0; //Medium 500
  final double headlineMedium = 18.0; //Medium 500
  final double headlineSmall = 16.0; //Medium 500
  final double titleLarge = 16.0; //Medium 500
  final double titleMedium = 14.0; //Medium 500
  final double bodyLarge = 16.0; //Regular 400
  final double bodyMedium = 14.0; //Regular 400
  final double bodySmall = 12.0; //Regular 400
  final double labelLarge = 16.0; //Medium 500
  final double labelMedium = 14.0; //Medium 500
  final double labelSmall = 12.0; //Medium 500

  return TextTheme(
    displayLarge: TextStyle(
      fontSize: displayLarge,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontVariations: const [FontVariation.weight(500)],
    ),
    displayMedium: TextStyle(
      fontSize: displayMedium,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontVariations: const [FontVariation.weight(500)],
    ),
    displaySmall: TextStyle(
      fontSize: displaySmall,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontVariations: const [FontVariation.weight(500)],
    ),
    headlineLarge: TextStyle(
      fontSize: headlineLarge,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontVariations: const [FontVariation.weight(500)],
    ),
    headlineMedium: TextStyle(
      fontSize: headlineMedium,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontVariations: const [FontVariation.weight(500)],
    ),
    headlineSmall: TextStyle(
      fontSize: headlineSmall,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontVariations: const [FontVariation.weight(500)],
    ),
    titleLarge: TextStyle(
      fontSize: titleLarge,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontVariations: const [FontVariation.weight(500)],
    ),
    titleMedium: TextStyle(
      fontSize: titleMedium,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontVariations: const [FontVariation.weight(500)],
    ),
    bodyLarge: TextStyle(
      fontSize: bodyLarge,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontVariations: const [FontVariation.weight(400)],
    ),
    bodyMedium: TextStyle(
      fontSize: bodyMedium,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontVariations: const [FontVariation.weight(400)],
    ),
    bodySmall: TextStyle(
      fontSize: bodySmall,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontVariations: const [FontVariation.weight(400)],
    ),
    labelLarge: TextStyle(
      fontSize: labelLarge,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontVariations: const [FontVariation.weight(500)],
    ),
    labelMedium: TextStyle(
      fontSize: labelMedium,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontVariations: const [FontVariation.weight(500)],
    ),
    labelSmall: TextStyle(
      fontSize: labelSmall,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontVariations: const [FontVariation.weight(500)],
    ),
  );
}
