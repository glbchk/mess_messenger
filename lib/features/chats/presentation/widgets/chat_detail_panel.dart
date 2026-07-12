import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/desktop_header_widget.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/web_input_bar.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ChatDetailPanel extends ConsumerWidget {
  final String chatId;
  final UserModel userData;
  final TextEditingController controller;
  final VoidCallback onPressedAttachment;
  final VoidCallback onPressedEmoji;
  final VoidCallback onPressedTextNewLine;
  final VoidCallback onPressedSend;
  final bool? textNewLineOrSend;
  final VoidCallback? onBackButtonPressed;

  const ChatDetailPanel({
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
    final colors = context.colors;
    final textTheme = context.textStyles;
    final chatState = ref.watch(chatsNotifierProvider(chatId));

    return Column(
      children: [
        DesktopHeaderWidget(
          showBackButton: true,
          onBackButtonPressed: onBackButtonPressed,
          userData: userData,
          onPressed: () {},
        ),
        Expanded(
          child: chatState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: chatState.messages.length,
                  itemBuilder: (context, index) {
                    final msg = chatState.messages[index];
                    final currentUserId = ref
                        .read(userNotifierProvider)
                        .userData
                        ?.id;
                    final isMe = msg.senderId == currentUserId;

                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? colors.surface2 : colors.surface4,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(msg.text, style: textTheme.bodyLarge),
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
