import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/desktop_chat_header_widget.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/web_input_bar.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/date_separator_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/received_message_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/sent_message_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/typing_indicator_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/ui_helper/build_message_list_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';

class OpenedSelectedChatWidget extends ConsumerWidget {
  final String chatId;
  final UserModel userData;
  final TextEditingController controller;
  final VoidCallback onPressedAttachment;
  final VoidCallback onPressedEmoji;
  final VoidCallback onPressedTextNewLine;
  final VoidCallback onPressedSend;
  final bool? textNewLineOrSend;
  final VoidCallback? onBackButtonPressed;

  const OpenedSelectedChatWidget({
    super.key,
    required this.chatId,
    required this.userData,
    required this.controller,
    required this.onPressedAttachment,
    required this.onPressedEmoji,
    required this.onPressedTextNewLine,
    required this.onPressedSend,
    this.textNewLineOrSend,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(userNotifierProvider).userData?.id ?? '';
    final chatState = ref.watch(chatsNotifierProvider(chatId));

    final userData =
        ref.read(userNotifierProvider).userData ?? UserModel(id: '');

    final peer = chatState.otherUser;

    final items = buildChatItems(chatState.messages);
    final otherIsTyping = chatState.typingUserIds.contains(
      chatState.otherUser?.id,
    );

    return Column(
      children: [
        DesktopChatHeaderWidget(
          showBackButton: true,
          onBackButtonPressed: onBackButtonPressed,
          otherUserData: peer ?? UserModel(id: ''),
          onPressed: () {},
        ),
        Expanded(
          child: chatState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  reverse: true,
                  itemCount: items.length + (otherIsTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (otherIsTyping && index == 0) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TypingIndicatorWidget(),
                        ),
                      );
                    }
                    //TODO: The messages are getting deleted or not displaying correctly

                    final adjustedIndex = otherIsTyping ? index - 1 : index;

                    final item = items[items.length - 1 - adjustedIndex];

                    if (item is DateSeparatorItem) {
                      return DateSeparatorWidget(label: item.label);
                    }

                    final msg = (item as MessageItem).message;
                    final isMe = msg.senderId == currentUserId;

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: isMe ? .centerRight : .centerLeft,
                        child: isMe
                            ? SentMessageWidget(
                                userName: userData.name ?? 'Me',
                                message: msg,
                                currentUserId: currentUserId,
                              )
                            : ReceivedMessageWidget(
                                isOnline: peer?.isOnline ?? false,
                                userName: peer?.name ?? 'Other',
                                message: msg,
                                currentUserId: currentUserId,
                              ),
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: WebInputBar(
            textNewLineOrSend: textNewLineOrSend ?? true,
            controller: controller,
            onPressedAttachment: onPressedAttachment,
            onPressedEmoji: onPressedEmoji,
            onPressedTextNewLine: onPressedTextNewLine,
            onPressedSend: onPressedSend,
          ),
        ),
      ],
    );
  }
}
