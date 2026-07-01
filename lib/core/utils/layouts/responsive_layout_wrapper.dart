import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveBreakpoints.of(context);

    if (bp.isDesktop) return desktop;
    if (bp.isTablet) return tablet ?? mobile;
    return mobile;
  }
}
