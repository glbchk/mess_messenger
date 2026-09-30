import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ThemeModeWidget extends StatelessWidget {
  final String label;
  final String icon;
  final VoidCallback onTap;
  const ThemeModeWidget({
    super.key,
    required this.onTap,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final bp = ResponsiveBreakpoints.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: colors.surface2,
          borderRadius: BorderRadius.circular(24),
        ),
        height: 44,
        child: Row(
          children: [
            Row(
              children: [
                if (bp.isDesktop) ...[
                  Text(
                    label,
                    style: textTheme.labelLarge?.copyWith(color: colors.text1),
                  ),
                  AppSpacing.p12.gapH,
                ],
                MessIcon(icon),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
