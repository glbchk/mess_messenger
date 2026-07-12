import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/web_side_menu.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/ui_helper/build_chat_list_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat_detail_panel.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ChatsTabletLayout extends ConsumerWidget {
  final String pageTitle;
  final UserModel userData;
  final List<ChatModel> chats;
  final String selectedChatId;
  final Future<void> Function() onPressed;
  final void Function(String chatId) onChatSelected;
  final TextEditingController messageController;
  final VoidCallback onSendMessage;
  final VoidCallback onDeselectChat;

  const ChatsTabletLayout({
    super.key,
    required this.pageTitle,
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
                        child: buildChatList(
                          pageTitle: pageTitle,
                          context: context,
                          l10n: l10n,
                          colors: colors,
                          textTheme: textTheme,
                          groupChats: groupChats,
                          directChats: directChats,
                          onPressed: onPressed,
                          onChatSelected: onChatSelected,
                        ),
                      )
                    : ChatDetailPanel(
                        userData: userData,
                        chatId: selectedChatId,
                        controller: messageController,
                        onPressedAttachment: () {},
                        onPressedEmoji: () {},
                        onPressedTextNewLine: () {},
                        onPressedSend: onSendMessage,
                        onBackButtonPressed: onDeselectChat,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
