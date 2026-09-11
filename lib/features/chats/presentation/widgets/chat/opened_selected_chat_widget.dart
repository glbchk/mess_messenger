import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/desktop_chat_header_widget.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/web_input_bar.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/date_separator_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/received_message_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/sent_message_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/typing_indicator_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/ui_helper/build_message_list_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';

class OpenedSelectedChatWidget extends ConsumerStatefulWidget {
  final String chatId;
  final TextEditingController controller;

  const OpenedSelectedChatWidget({
    super.key,
    required this.chatId,
    required this.controller,
  });

  @override
  ConsumerState<OpenedSelectedChatWidget> createState() =>
      _OpenedSelectedChatWidgetState();
}

class _OpenedSelectedChatWidgetState
    extends ConsumerState<OpenedSelectedChatWidget> {
  @override
  Widget build(BuildContext context) {
    final currentUserId = ref.watch(userNotifierProvider).userData?.id ?? '';
    final myName = ref.watch(userNotifierProvider).userData?.name;
    final chatState = ref.watch(chatsNotifierProvider(widget.chatId));

    final peer = chatState.otherUser;

    final items = buildChatItems(chatState.messages, context);
    final otherIsTyping = chatState.typingUserIds.contains(
      chatState.otherUser?.id,
    );

    return Column(
      children: [
        DesktopChatHeaderWidget(
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
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TypingIndicatorWidget(
                            userName: peer?.name ?? 'Other',
                          ),
                        ),
                      );
                    }

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
                                userName: myName ?? 'Me',
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
            textNewLineOrSend: true,
            controller: widget.controller,
            onPressedAttachment: () {},
            onPressedEmoji: () {},
            onPressedTextNewLine: () {},
            onPressedSend: () {
              final text = widget.controller.text.trim();
              if (text.isEmpty) return;
              final myId = ref.read(userNotifierProvider).userData?.id;
              if (myId == null) return;
              ref
                  .read(chatsNotifierProvider(widget.chatId).notifier)
                  .sendMessage(myId, text);
              widget.controller.clear();
            },
          ),
        ),
      ],
    );
  }
}
