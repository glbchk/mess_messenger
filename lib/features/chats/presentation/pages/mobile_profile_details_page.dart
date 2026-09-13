import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/dropdown_item_action_model.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/mess_icon_dropdown_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_text_button.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/app_bar/mobile_app_bar.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/core/widgets/user_data_content_widget.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/user_details_panel/message_card_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/user_details_panel/section_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MobileProfileDetailsPage extends ConsumerWidget {
  final String? chatId;
  const MobileProfileDetailsPage({super.key, this.chatId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final otherUserData = ref.watch(
      chatsNotifierProvider(chatId ?? '').select((s) => s.otherUser),
    );

    return Scaffold(
      backgroundColor: colors.bg,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: MobileAppBar(
        userName: otherUserData?.name,
        userEmail: otherUserData?.email,
        appBarUserPhotoPath: otherUserData?.avatarUrl,
        appBarBackgroundColor: colors.transparent,
        showBackButton: true,
        showAppBarContent: false,
        showBottomLine: false,
        onPressedBack: () => context.pop(),
        actions: [
          MessIconDropdownButton<DropdownItemAction>(
            svgAsset: SvgIcons.menuVert,
            isButtonFilled: true,
            borderWidth: 0,
            itemLabelBuilder: (item) => item.label,
            textColorBuilder: (item) => item.textColor,
            onItemTap: (item) => item.onTap(),
            items: [
              DropdownItemAction(
                label: 'Search',
                onTap: () {}, //widget.onPressedChangeAvatar,
              ),
              DropdownItemAction(label: 'Mute notifications', onTap: () {}),
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
          AppSpacing.p16.gapH,
        ],
      ),

      body: Container(
        color: colors.surface0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            color: colors.bg,
          ),
          child: ClipRRect(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Stack(
                    clipBehavior: .none,
                    children: [
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Container(
                            height: 210,
                            width: double.infinity,
                            decoration: BoxDecoration(color: colors.bg),
                            child: ClipRRect(
                              child: Image.asset(
                                'assets/images/settings_header.png',
                                fit: .cover,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 24, top: 60),
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  otherUserData?.name ?? 'No Name',
                                  style: textTheme.displaySmall?.copyWith(
                                    color: colors.text1,
                                  ),
                                ),

                                AppSpacing.p4.gapV,

                                Text(
                                  otherUserData?.phoneNumber ?? '+44656548060',
                                  style: textTheme.headlineMedium?.copyWith(
                                    color: colors.text2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppSpacing.p40.gapV,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                            ),
                            child: Column(
                              crossAxisAlignment: .start,
                              spacing: 32,
                              children: [
                                Wrap(
                                  alignment: .spaceBetween,
                                  spacing: 32,
                                  runSpacing: 16,
                                  children: [
                                    _action(SvgIcons.calls, 'Call'),
                                    _action(SvgIcons.video, 'Video'),
                                    _action(SvgIcons.email, 'Email'),
                                  ],
                                ),
                                SectionWidget(
                                  title: 'Status',
                                  widgets: [
                                    Text(
                                      'When there’s no more hope, think of the lobster in the  restaurant’s aquarium of the Titanic.',
                                      style: textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                SectionWidget(
                                  title: 'Saved messages',
                                  widgets: [
                                    MessageCardWidget(),

                                    MessTextButton(label: 'Show more'),
                                  ],
                                ),
                                SectionWidget(
                                  title: 'Groups',
                                  widgets: [
                                    UserDataContentWidget(
                                      avatarSize: 40,
                                      titleSize: textTheme.titleMedium,
                                      titleColor: colors.text1,
                                      subtitleSize: textTheme.bodyMedium,
                                      subtitleColor: colors.text2,
                                      mainAxisAlignment: .start,
                                    ),
                                  ],
                                ),

                                AppSpacing.p60.gapV,
                              ],
                            ),
                          ),
                        ],
                      ),

                      Positioned(
                        left: 24,
                        top: 154,
                        child: Stack(
                          clipBehavior: .none,
                          children: [
                            UserAvatarWidget(
                              isOnline: false,
                              userName: otherUserData?.name ?? '?',
                              size: 96,
                              textStyle: textTheme.displayMedium?.copyWith(
                                color: colors.iconContrast,
                              ),
                              backgroundColor: colors.surface4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _action(String icon, String label) => Column(
  mainAxisSize: .min,
  spacing: 16,
  children: [MessIconButton(icon, isButtonFilled: true), Text(label)],
);
