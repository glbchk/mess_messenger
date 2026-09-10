import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/dropdown_item_action_model.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/mess_icon_dropdown_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/user_data_content_widget.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/web_ui_helpers/build_web_header_action_button.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DesktopChatHeaderWidget extends ConsumerWidget {
  final UserModel otherUserData;
  final VoidCallback onPressed;
  final bool showBackButton;
  final VoidCallback? onBackButtonPressed;

  const DesktopChatHeaderWidget({
    super.key,
    required this.otherUserData,
    required this.onPressed,
    this.showBackButton = false,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserDataContentWidget(otherUserData: otherUserData),
            Spacer(),
            Row(
              spacing: 12,
              children: [
                buildWebHeaderActionButton(
                  context: context,
                  iconPath: SvgIcons.add,
                  onPressed: () {},
                ),
                buildWebHeaderActionButton(
                  context: context,
                  iconPath: SvgIcons.calls,
                  onPressed: () {},
                ),
                MessMainButton(
                  label: 'View Profile',
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
                  buttonSize: 32,
                  borderWidth: 0,
                  itemLabelBuilder: (item) => item.label,
                  textColorBuilder: (item) => item.textColor,
                  onItemTap: (item) => item.onTap(),
                  items: [
                    if (bp.isDesktop)
                      DropdownItemAction(
                        label: isCollapsed ? 'Show chats' : 'Full screen chat',
                        onTap: () => ref
                            .read(userChatsNotifierProvider.notifier)
                            .toggleChatList(),
                      ),
                    DropdownItemAction(
                      label: 'Search',
                      onTap: () {}, //widget.onPressedChangeAvatar,
                    ),
                    DropdownItemAction(
                      label: 'Mute notifications',
                      onTap: () {},
                    ),
                    DropdownItemAction(
                      label: 'Clear/Delete chat',
                      onTap: () {}, //widget.onPressedLogoutFromAllDevices,
                    ),
                    DropdownItemAction(
                      label: 'Block/Report user',
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
