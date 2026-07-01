import 'package:flutter/material.dart';

class AppSpacing {
  // Prevent instantiation
  AppSpacing._();

  // Standard Spacing (8pt grid)
  static const double p4 = 4.0;
  static const double p8 = 8.0;
  static const double p12 = 12.0;
  static const double p16 = 16.0;
  static const double p20 = 20.0;
  static const double p24 = 24.0;
  static const double p28 = 28.0;
  static const double p32 = 32.0;
  static const double p36 = 36.0;
  static const double p40 = 40.0;
  static const double p44 = 44.0;
  static const double p48 = 48.0;
  static const double p52 = 52.0;
  static const double p56 = 56.0;
  static const double p60 = 60.0;
  static const double p64 = 64.0;
}

// Optional: Extension for cleaner SizedBox usage
extension Spacing on num {
  SizedBox get gapH => SizedBox(width: toDouble());
  SizedBox get gapV => SizedBox(height: toDouble());
}
