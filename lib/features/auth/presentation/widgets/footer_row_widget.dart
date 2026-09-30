import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/widgets/mess_text_button.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class FooterWidget extends StatelessWidget {
  final VoidCallback? onPressedChangeLanguage;
  const FooterWidget({super.key, this.onPressedChangeLanguage});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    return Container(
      height: 68,
      color: colors.surface0,
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 32),
      child: Row(
        mainAxisAlignment: .center,
        children: [
          Text(
            '©Mess Messenger 2026',
            style: textTheme.bodyMedium?.copyWith(color: colors.text2),
          ),
          Spacer(),
          MessTextButton(
            textStyle: textTheme.labelMedium?.copyWith(color: colors.link),
            label: l10n.changeLanguage,
            onPressed: onPressedChangeLanguage,
          ),
        ],
      ),
    );
  }
}
