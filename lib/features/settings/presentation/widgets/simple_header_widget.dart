import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SimpleHeaderWidget extends ConsumerWidget {
  final bool showBackButton;
  final VoidCallback? onBackButtonPressed;
  final VoidCallback? onPressedShowDetails;

  const SimpleHeaderWidget({
    super.key,
    this.showBackButton = false,
    this.onBackButtonPressed,
    this.onPressedShowDetails,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    return Container(
      height: 84,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(bottom: BorderSide(color: colors.border2, width: 1.0)),
      ),

      child: Padding(
        padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
        child: Row(
          crossAxisAlignment: .start,
          mainAxisAlignment: .center,
          spacing: 12,
          children: [
            Text(
              l10n.support,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            Spacer(),
            MessMainButton(
              label: l10n.showDetails,
              height: 32,
              width: 136,
              backgroundColor: colors.bg,
              borderColor: colors.border2,
              textStyle: textTheme.labelMedium?.copyWith(color: colors.text1),
              onPressed: onPressedShowDetails,
            ),
            MessIconButton(
              isButtonFilled: true,
              buttonSize: 36,
              iconSize: 16,
              SvgIcons.menuHorizontal,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
