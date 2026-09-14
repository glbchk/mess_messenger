import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/dropdown_item_action_model.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/mess_icon_dropdown_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/user_data_content_widget.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DesktopChatHeaderWidget extends ConsumerWidget {
  final UserModel otherUserData;
  final VoidCallback onPressed;

  const DesktopChatHeaderWidget({
    super.key,
    required this.otherUserData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final bp = ResponsiveBreakpoints.of(context);

    final isCollapsed = ref.watch(
      userChatsNotifierProvider.select((s) => s.isChatListCollapsed),
    );

    return Container(
      height: 112,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(bottom: BorderSide(color: colors.border2, width: 1.0)),
      ),

      child: Padding(
        padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
        child: Row(
          crossAxisAlignment: .start,
          mainAxisAlignment: .center,
          children: [
            UserDataContentWidget(otherUserData: otherUserData),
            Spacer(),
            Row(
              spacing: 12,
              children: [
                MessIconButton(
                  SvgIcons.add,
                  iconSize: 20,
                  buttonSize: 36,
                  onPressed: () {},
                ),
                MessIconButton(
                  SvgIcons.calls,
                  iconSize: 20,
                  buttonSize: 36,
                  onPressed: () {},
                ),
                MessMainButton(
                  label: l10n.viewProfile,
                  height: 32,
                  width: 126,
                  textStyle: textTheme.labelMedium?.copyWith(
                    color: colors.textInverse,
                  ),
                  onPressed: () => ref
                      .read(userChatsNotifierProvider.notifier)
                      .toggleDisplayProfileDetails(),
                ),
                MessIconDropdownButton<DropdownItemAction>(
                  svgAsset: SvgIcons.menuHorizontal,
                  isButtonFilled: true,
                  buttonSize: 36,
                  borderWidth: 0,
                  itemLabelBuilder: (item) => item.label,
                  textColorBuilder: (item) => item.textColor,
                  onItemTap: (item) => item.onTap(),
                  items: [
                    if (bp.isDesktop)
                      DropdownItemAction(
                        label: isCollapsed
                            ? l10n.showChats
                            : l10n.fullScreenChat,
                        onTap: () => ref
                            .read(userChatsNotifierProvider.notifier)
                            .toggleChatList(),
                      ),
                    DropdownItemAction(
                      label: l10n.search,
                      onTap: () {}, //widget.onPressedChangeAvatar,
                    ),
                    DropdownItemAction(
                      label: l10n.muteNotifications,
                      onTap: () {},
                    ),
                    DropdownItemAction(
                      label: l10n.clearChat,
                      onTap: () {}, //widget.onPressedLogoutFromAllDevices,
                    ),
                    DropdownItemAction(
                      label: l10n.blockUser,
                      onTap: () {}, //widget.onPressedContactSupport,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
