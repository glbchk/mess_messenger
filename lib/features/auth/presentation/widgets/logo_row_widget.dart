import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/presentation/widgets/theme_mode_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class LogoRowWidget extends ConsumerWidget {
  const LogoRowWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;
    final isCurrentlyLight = Theme.of(context).brightness == Brightness.light;

    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 24.0),
      child: Row(
        children: [
          Row(
            children: [
              MessIcon(SvgIcons.logo, size: 34),
              AppSpacing.p12.gapH,
              Text(
                'Mess Messenger',
                style: textTheme.headlineLarge?.copyWith(color: colors.text1),
              ),
            ],
          ),
          Spacer(),
          ThemeModeWidget(
            label: isCurrentlyLight ? l10n.changeToDark : l10n.changeToLight,
            icon: isCurrentlyLight ? SvgIcons.darkMode : SvgIcons.lightMode,
            onTap: () {
              ref.read(authNotifierProvider.notifier).toggleThemeMode();
            },
          ),
        ],
      ),
    );
  }
}
