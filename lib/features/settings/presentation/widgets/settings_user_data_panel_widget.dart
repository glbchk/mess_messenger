import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/spacing_modifier.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/dropdown_item_action_model.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/mess_icon_dropdown_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SettingsUserDataPanelWidget extends StatelessWidget {
  final AppLocalizations l10n;
  final UserModel userData;
  final VoidCallback onPressedLogout;
  final bool isChangeApplied;

  const SettingsUserDataPanelWidget({
    super.key,
    required this.l10n,
    required this.userData,
    required this.onPressedLogout,
    this.isChangeApplied = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final bp = ResponsiveBreakpoints.of(context);

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
              bp.isDesktop
                  ? MessMainButton(
                      height: 36,
                      width: 128,
                      label: 'Log out',
                      suffixIconPath: SvgIcons.logout,
                      suffixIconSize: 20,
                      textColor: colors.text1,
                      backgroundColor: colors.surface2,
                      hoverColor: colors.surface4,
                      onPressed: onPressedLogout,
                    )
                  : SpacingModifier.empty(),
              MessIconDropdownButton<DropdownItemAction>(
                svgAsset: SvgIcons.menuHorizontal,
                isButtonFilled: true,
                borderWidth: 0,
                itemLabelBuilder: (item) => item.label,
                textColorBuilder: (item) => item.textColor,
                onItemTap: (item) => item.onTap(),
                items: [
                  DropdownItemAction(label: 'Change avatar', onTap: () {}),
                  DropdownItemAction(
                    label: 'Export account data',
                    onTap: () {},
                  ),
                  DropdownItemAction(label: 'Active sessions', onTap: () {}),
                  DropdownItemAction(label: 'Contact support', onTap: () {}),
                  if (!bp.isDesktop)
                    DropdownItemAction(label: 'Log out', onTap: () {}),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
