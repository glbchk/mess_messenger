import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension SettingsResponsiveSizingX on BuildContext {
  double getLabelWidth() {
    final bp = ResponsiveBreakpoints.of(this);
    if (bp.isDesktop) {
      return bp.screenWidth * 0.2;
    } else if (bp.isTablet) {
      return bp.screenWidth * 0.25;
    } else {
      return bp.screenWidth;
    }
  }

  double getFieldWidth() {
    final bp = ResponsiveBreakpoints.of(this);
    if (bp.isDesktop) {
      return bp.screenWidth * 0.25;
    } else if (bp.isTablet) {
      return bp.screenWidth * 0.4;
    } else {
      return bp.screenWidth * 0.85;
    }
  }

  SizedBox getSpacer() {
    final bp = ResponsiveBreakpoints.of(this);
    if (bp.isDesktop) {
      return AppSpacing.p8.gapV;
    } else {
      return AppSpacing.p4.gapV;
    }
  }

  Widget flexChild(bool isWide, Widget child) {
    return isWide ? Expanded(flex: 1, child: child) : child;
  }
}
