import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/spacing_modifier.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/dropdown_item_action_model.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/mess_icon_dropdown_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SettingsUserDataPanelWidget extends ConsumerWidget {
  final VoidCallback onPressedChangeAvatar;
  final VoidCallback onPressedExportAccountData;
  final VoidCallback onPressedContactSupport;
  final VoidCallback onPressedLogout;

  const SettingsUserDataPanelWidget({
    super.key,
    required this.onPressedChangeAvatar,
    required this.onPressedExportAccountData,
    required this.onPressedContactSupport,
    required this.onPressedLogout,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final bp = ResponsiveBreakpoints.of(context);

    final l10n = context.l10n;

    final userData =
        ref.watch(userNotifierProvider).userData ?? UserModel(id: '');

    return Row(
      crossAxisAlignment: .center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 246),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                userData.name ?? 'No Name',
                style: textTheme.displaySmall?.copyWith(color: colors.text1),
              ),

              const SizedBox(height: 4),

              Text(
                userData.phoneNumber ?? '+44656548060',
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
                      label: l10n.logOut,
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
                  DropdownItemAction(
                    label: l10n.changeAvatar,
                    onTap: onPressedChangeAvatar,
                  ),
                  DropdownItemAction(
                    label: l10n.exportAccountData,
                    onTap: onPressedExportAccountData,
                  ),
                  DropdownItemAction(
                    label: l10n.contactSupport,
                    onTap: onPressedContactSupport,
                  ),
                  DropdownItemAction(
                    label: l10n.terminateAllActiveSessions,
                    onTap: () {
                      ref
                          .read(authNotifierProvider.notifier)
                          .logoutFromAllDevices();
                    },
                  ),
                  if (!bp.isDesktop)
                    DropdownItemAction(
                      label: l10n.logOut,
                      onTap: onPressedLogout,
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
