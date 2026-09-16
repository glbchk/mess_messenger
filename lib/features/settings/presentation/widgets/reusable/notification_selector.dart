import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_switch.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class NotificationSelector extends StatelessWidget {
  final String title;
  final String description;
  final bool firstValue;
  final bool secondValue;
  final bool thirdValue;
  final ValueChanged<bool> onFirstSwitchChanged;
  final ValueChanged<bool> onSecondSwitchChanged;
  final ValueChanged<bool> onThirdSwitchChanged;

  const NotificationSelector({
    super.key,
    required this.title,
    required this.description,
    required this.firstValue,
    required this.secondValue,
    required this.thirdValue,
    required this.onFirstSwitchChanged,
    required this.onSecondSwitchChanged,
    required this.onThirdSwitchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final bp = ResponsiveBreakpoints.of(context);
    final isWide = bp.isDesktop || bp.isTablet;

    final textSection = Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(color: colors.text1),
        ),
        AppSpacing.p4.gapV,
        Text(
          description,
          style: textTheme.bodyMedium?.copyWith(color: colors.text2),
        ),
      ],
    );

    final switchesSection = Column(
      crossAxisAlignment: .start,
      spacing: 16,
      children: [
        Row(
          spacing: 8,
          mainAxisSize: .min,
          children: [
            MessSwitch(
              value: firstValue,
              onChanged: (bool value) => onFirstSwitchChanged(!firstValue),
            ),
            Text(
              l10n.email,
              style: textTheme.bodyLarge?.copyWith(color: colors.text1),
            ),
          ],
        ),
        Row(
          spacing: 8,
          mainAxisSize: .min,
          children: [
            MessSwitch(
              value: secondValue,
              onChanged: (bool value) => onSecondSwitchChanged(!secondValue),
            ),
            Text(
              l10n.desktop,
              style: textTheme.bodyLarge?.copyWith(color: colors.text1),
            ),
          ],
        ),
        Row(
          spacing: 8,
          mainAxisSize: .min,
          children: [
            MessSwitch(
              value: thirdValue,
              onChanged: (bool value) => onThirdSwitchChanged(!thirdValue),
            ),
            Text(
              l10n.push,
              style: textTheme.bodyLarge?.copyWith(color: colors.text1),
            ),
          ],
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.surface3, width: 1)),
      ),
      child: isWide
          ? Row(
              crossAxisAlignment: .start,
              children: [
                SizedBox(width: 280, child: textSection),
                AppSpacing.p32.gapH,
                switchesSection,
              ],
            )
          : Column(
              crossAxisAlignment: .start,
              children: [textSection, AppSpacing.p16.gapV, switchesSection],
            ),
    );
  }
}
