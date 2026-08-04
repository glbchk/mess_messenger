import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SettingsUserDataPanelWidget extends StatelessWidget {
  final UserModel userData;
  final VoidCallback onPressedLogout;
  final bool isChangeApplied;
  // final Color activeTrackColor;
  // final Color inactiveTrackColor;
  // final Color thumbColor;

  const SettingsUserDataPanelWidget({
    super.key,
    required this.userData,
    required this.onPressedLogout,
    this.isChangeApplied = false,
    // this.activeTrackColor = colors.text1,
    // this.inactiveTrackColor = colors.surface3,
    // this.thumbColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = AppLocalizations.of(context)!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 246),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userData.name ?? 'Sylvia Reyes',
                style: textTheme.displaySmall?.copyWith(color: colors.text1),
              ),

              const SizedBox(height: 4),

              Text(
                '+44656548060', //userData.phoneNumber ?? '+44656548060',
                style: textTheme.headlineMedium?.copyWith(color: colors.text2),
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 32),
          child: Row(
            spacing: 12,
            children: [
              MessMainButton(
                height: 36,
                width: 128,
                label: 'Log out',
                suffixIconPath: SvgIcons.logout,
                suffixIconSize: 20,
                textColor: colors.text1,
                backgroundColor: colors.surface2,
                hoverColor: colors.surface4,
                onPressed: onPressedLogout,
              ),
              MessIconButton(
                SvgIcons.menuHorizontal,
                buttonSize: 36,
                isButtonFilled: true,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
