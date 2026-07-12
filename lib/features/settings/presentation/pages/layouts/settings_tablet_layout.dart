import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/header_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/web_side_menu.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat_detail_panel.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat_tile_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chats_header_section_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SettingsTabletLayout extends ConsumerWidget {
  final UserModel userData;
  final List<ChatModel> chats;
  final String selectedChatId;
  final Future<void> Function() onPressed;
  final void Function(String chatId) onChatSelected;
  final TextEditingController messageController;
  final VoidCallback onSendMessage;
  final VoidCallback onDeselectChat;

  const SettingsTabletLayout({
    super.key,
    required this.userData,
    required this.chats,
    required this.selectedChatId,
    required this.onPressed,
    required this.onChatSelected,
    required this.messageController,
    required this.onSendMessage,
    required this.onDeselectChat,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = AppLocalizations.of(context)!;

    final directChats = chats.where((c) => !c.isGroup).toList();
    final groupChats = chats.where((c) => c.isGroup).toList();

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WebSideMenu(userData: userData),

          Expanded(
            child: Container(
              color: colors.surface0,
              child: Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  color: colors.bg,
                ),
                child: selectedChatId == ''
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        child: _buildChatList(
                          context,
                          l10n,
                          colors,
                          textTheme,
                          groupChats,
                          directChats,
                        ),
                      )
                    : _buildChatDetail(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList(
    BuildContext context,
    AppLocalizations l10n,
    dynamic colors,
    dynamic textTheme,
    List<ChatModel> groupChats,
    List<ChatModel> directChats,
  ) {
    return Column(
      children: [
        HeaderWidget(
          title: l10n.chats,
          iconPath: SvgIcons.add,
          onPressed: onPressed,
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
                              'In future should be group messages!', //groupChat.id.substring(0, 12),
                          subtitle: groupChat.lastMessage,
                          onPressed: () {},
                        ),

                      //Chats
                      ChatsHeaderSectionWidget(
                        sectionTitle: l10n.chats,
                        onPressed: () {},
                      ),
                      for (final directChat in directChats)
                        ChatTileWidget(
                          iconPath: SvgIcons.folders,
                          chatId: directChat.id,
                          title: directChat.id.substring(0, 12),
                          subtitle: directChat.lastMessage,
                          onPressed: () => onChatSelected(directChat.id),
                        ),
                    ],
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/empty_screen_logo.png',
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
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildChatDetail(BuildContext context) {
    return ChatDetailPanel(
      userData: userData,
      chatId: selectedChatId,
      controller: messageController,
      onPressedAttachment: () {},
      onPressedEmoji: () {},
      onPressedTextNewLine: () {},
      onPressedSend: onSendMessage,
      onBackButtonPressed: onDeselectChat,
    );
  }
}
