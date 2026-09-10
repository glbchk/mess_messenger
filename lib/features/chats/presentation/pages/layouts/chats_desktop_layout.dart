import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/app_images.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/header_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/web_side_menu.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat_tile_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chats_header_section_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/opened_selected_chat_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/user_details_panel/user_detals_panel_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ChatsDesktopLayout extends ConsumerWidget {
  final AppLocalizations l10n;
  final UserModel userData;
  final List<ChatModel> chats;
  final String selectedChatId;
  final Future<void> Function() onCreatedChatPressed;
  final void Function(String chatId) onChatSelected;
  final TextEditingController messageController;
  final VoidCallback onSendMessage;

  const ChatsDesktopLayout({
    super.key,
    required this.l10n,
    required this.userData,
    required this.chats,
    required this.selectedChatId,
    required this.onCreatedChatPressed,
    required this.onChatSelected,
    required this.messageController,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final bp = ResponsiveBreakpoints.of(context);

    final sectionWidth = bp.isDesktop
        ? bp.screenWidth * 0.25
        : bp.screenWidth * 0.35;

    final directChats = chats.where((c) => !c.isGroup).toList();
    final groupChats = chats.where((c) => c.isGroup).toList();

    final isCollapsed = ref.watch(
      userChatsNotifierProvider.select((s) => s.isChatListCollapsed),
    );

    final isProfilesDisplayed = ref.watch(
      userChatsNotifierProvider.select((s) => s.isProfileDetailsDisplayed),
    );

    final otherUser = selectedChatId.isEmpty
        ? null
        : ref.watch(
            chatsNotifierProvider(selectedChatId).select((s) => s.otherUser),
          );

    return Stack(
      children: [
        Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WebSideMenu(userData: userData),

              if (!isCollapsed)
                Container(
                  width: sectionWidth,
                  color: colors.surface0,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 24,
                      top: 12,
                      right: 24,
                    ),
                    margin: const EdgeInsets.only(
                      left: 20,
                      top: 20,
                      right: 16,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      color: colors.bg,
                    ),
                    child: Column(
                      children: [
                        HeaderWidget(
                          title: l10n.chats,
                          iconPath: SvgIcons.add,
                          onPressed: onCreatedChatPressed,
                        ),
                        MessTextField(
                          height: 56,
                          radius: 24,
                          hint: l10n.searchHere,
                          prefixIcon: SvgIcons.search,
                        ),
                        AppSpacing.p12.gapV,
                        Expanded(
                          child: chats.isNotEmpty
                              ? SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0,
                                    ),
                                    child: Column(
                                      children: [
                                        //Groups
                                        ChatsHeaderSectionWidget(
                                          sectionTitle: l10n.groups,
                                          onPressed: () {},
                                        ),
                                        for (final groupChat in groupChats)
                                          ChatTileWidget(
                                            iconPath: SvgIcons.folders,
                                            chatId: groupChat.id,
                                            title:
                                                'In future should be group messages!',
                                            subtitle: groupChat.lastMessage,
                                            onPressed: () {},
                                          ),

                                        //Chats
                                        ChatsHeaderSectionWidget(
                                          sectionTitle: l10n.chats,
                                          onPressed: () {},
                                        ),
                                        for (final directChat in directChats)
                                          Builder(
                                            builder: (context) {
                                              final peerId =
                                                  directChat.peerId(
                                                    userData.id,
                                                  ) ??
                                                  '';
                                              final peer = ref
                                                  .watch(
                                                    watchedUserProvider(peerId),
                                                  )
                                                  .value;

                                              return ChatTileWidget(
                                                iconPath: SvgIcons.folders,
                                                chatId: directChat.id,
                                                title: peer?.name ?? '…',
                                                subtitle:
                                                    directChat.lastMessage,
                                                onPressed: () => onChatSelected(
                                                  directChat.id,
                                                ),
                                              );
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                              : Center(
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 22.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              AppImages.emptyScreenLogo,
                                              width: 300,
                                              height: 300,
                                            ),
                                            AppSpacing.p20.gapV,
                                            Text(
                                              l10n.messenger,
                                              style: textTheme.headlineLarge
                                                  ?.copyWith(
                                                    color: colors.text1,
                                                  ),
                                            ),
                                            AppSpacing.p8.gapV,
                                            Text(
                                              l10n.chatsEmptyScreenText,
                                              style: textTheme.bodyLarge
                                                  ?.copyWith(
                                                    color: colors.text2,
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                            if (chats.isEmpty) ...[
                                              AppSpacing.p16.gapV,
                                              MessMainButton(
                                                label: l10n.startChat,
                                                onPressed: () {},
                                              ),
                                            ],
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),

              Expanded(
                child: selectedChatId == ''
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.emptyScreenLogo,
                            width: 300,
                            height: 300,
                          ),
                          AppSpacing.p20.gapV,
                          Text(
                            l10n.messenger,
                            style: textTheme.headlineLarge?.copyWith(
                              color: colors.text1,
                            ),
                          ),
                          AppSpacing.p8.gapV,
                          Text(
                            l10n.chatsEmptyScreenText,
                            style: textTheme.bodyLarge?.copyWith(
                              color: colors.text2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: colors.bg,
                        ),
                        child: OpenedSelectedChatWidget(
                          chatId: selectedChatId,
                          userData: userData,
                          controller: messageController,
                          onPressedAttachment: () {},
                          onPressedEmoji: () {},
                          onPressedTextNewLine: () {},
                          onPressedSend: onSendMessage,
                        ),
                      ),
              ),

              if (isProfilesDisplayed)
                // if (isProfilesDisplayed && otherUser != null)
                UserDetailsPanelWidget(
                  l10n: l10n,
                  otherUserData: otherUser ?? UserModel(id: ''),
                  onPressedClose: () => ref
                      .read(userChatsNotifierProvider.notifier)
                      .toggleDisplayProfileDetails(),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
