import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/app_images.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class EmptyScreenWidget extends StatelessWidget {
  final AppLocalizations l10n;

  const EmptyScreenWidget({super.key, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.emptyScreenLogo, width: 300, height: 300),
            AppSpacing.p20.gapV,
            Text(
              l10n.messenger,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p8.gapV,
            Text(
              l10n.chatsEmptyScreenText,
              style: textTheme.bodyLarge?.copyWith(color: colors.text2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
