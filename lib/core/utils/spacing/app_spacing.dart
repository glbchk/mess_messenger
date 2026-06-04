import 'package:flutter/material.dart';

class AppSpacing {
  // Prevent instantiation
  AppSpacing._();

  // Standard Spacing (8pt grid)
  static const double p4 = 4.0;
  static const double p8 = 8.0;
  static const double p12 = 12.0;
  static const double p16 = 16.0;
  static const double p24 = 24.0;
  static const double p32 = 32.0;
  static const double p48 = 48.0;
  static const double p64 = 64.0;
}

// Optional: Extension for cleaner SizedBox usage
extension Spacing on num {
  SizedBox get gapH => SizedBox(width: toDouble());
  SizedBox get gapV => SizedBox(height: toDouble());
}
