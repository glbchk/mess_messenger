import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/app_images.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class EmptyScreenWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const EmptyScreenWidget({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Image.asset(AppImages.emptyScreenLogo, width: 300, height: 300),
            AppSpacing.p20.gapV,
            Text(
              title ?? l10n.messenger,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p8.gapV,
            Text(
              subtitle ?? l10n.chatsEmptyScreenText,
              style: textTheme.bodyLarge?.copyWith(color: colors.text2),
              textAlign: .center,
            ),
          ],
        ),
      ),
    );
  }
}
