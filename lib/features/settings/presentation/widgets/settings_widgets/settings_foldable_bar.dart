import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/dropdown_item_action_model.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/mess_icon_dropdown_button.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/delegates/profile_header_delegate.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SettingsFoldableBar extends ConsumerStatefulWidget {
  final Widget body;
  final SliverPersistentHeader header;
  final VoidCallback onPressedChangeAvatar;
  final VoidCallback onPressedContactSupport;

  const SettingsFoldableBar({
    super.key,
    required this.body,
    required this.header,
    required this.onPressedChangeAvatar,
    required this.onPressedContactSupport,
  });

  @override
  ConsumerState<SettingsFoldableBar> createState() =>
      _SettingsMobileLayoutState();
}

class _SettingsMobileLayoutState extends ConsumerState<SettingsFoldableBar> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final topPadding = MediaQuery.paddingOf(context).top;

    final l10n = context.l10n;

    final userData =
        ref.watch(userNotifierProvider).userData ?? UserModel(id: '');

    return NestedScrollView(
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverPersistentHeader(
          pinned: true,
          delegate: ProfileHeaderDelegate(
            topInset: topPadding,
            userData: userData,
            textTheme: textTheme,
            colors: colors,
            onBack: () => context.pop(),
            actions: MessIconDropdownButton<DropdownItemAction>(
              svgAsset: SvgIcons.menuVert,
              isButtonFilled: true,
              borderWidth: 0,
              itemLabelBuilder: (item) => item.label,
              textColorBuilder: (item) => item.textColor,
              onItemTap: (item) => item.onTap(),
              items: [
                DropdownItemAction(
                  label: l10n.changeAvatar,
                  onTap: widget.onPressedChangeAvatar,
                ),
                DropdownItemAction(label: l10n.exportAccountData, onTap: () {}),
                DropdownItemAction(
                  label: l10n.terminateAllActiveSessions,
                  onTap: () {
                    ref
                        .read(authNotifierProvider.notifier)
                        .logoutFromAllDevices();
                  },
                ),
                DropdownItemAction(
                  label: l10n.contactSupport,
                  onTap: widget.onPressedContactSupport,
                ),
                DropdownItemAction(
                  label: l10n.logOut,
                  textColor: colors.errorColor,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        widget.header,
      ],
      body: widget.body,
    );
  }
}
