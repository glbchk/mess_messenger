import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/mess_text_button.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class NotificationCardWidget extends StatelessWidget {
  final double? width;
  final VoidCallback? onDismissPressed;
  final VoidCallback? onLearnMorePressed;

  const NotificationCardWidget({
    super.key,
    this.width,
    this.onDismissPressed,
    this.onLearnMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    return Container(
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: colors.textInverse,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              crossAxisAlignment: .center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.importantNotifications,
                  style: textTheme.headlineMedium?.copyWith(
                    color: colors.text1,
                  ),
                ),
                MessIcon(SvgIcons.information, color: colors.infoColor),
              ],
            ),
            AppSpacing.p12.gapV,
            Text(
              l10n.importantNotificationsDescription,
              style: textTheme.bodyMedium?.copyWith(color: colors.text1),
            ),
            AppSpacing.p8.gapV,
            Row(
              spacing: 12,
              children: [
                MessTextButton(
                  label: l10n.dismiss,
                  textStyle: textTheme.labelMedium?.copyWith(
                    color: colors.link,
                  ),
                  onPressed: onDismissPressed,
                ),
                MessTextButton(
                  label: l10n.learnMore,
                  textStyle: textTheme.labelMedium?.copyWith(
                    color: colors.link,
                  ),
                  onPressed: onLearnMorePressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
