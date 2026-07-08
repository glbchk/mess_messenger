import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/chats/presentation/states/open_chat_state.dart';

class OpenChatNotifier extends Notifier<OpenChatState> {
  OpenChatNotifier(this.chatId);
  final String chatId;

  StreamSubscription<List<MessageModel>>? _messagesSubscription;

  @override
  OpenChatState build() {
    ref.onDispose(() {
      _messagesSubscription?.cancel();
    });

    Future.microtask(() => fetchMessages(chatId));
    return const OpenChatState(isLoading: true);
  }

  Future<void> fetchMessages(String chatId) async {
    state = state.copyWith(isLoading: true);

    _messagesSubscription?.cancel();

    _messagesSubscription = ref
        .read(fetchMessagesUseCaseProvider)
        .execute(chatId)
        .listen(
          (messages) {
            state = state.copyWith(messages: messages, isLoading: false);
          },
          onError: (error) {
            state = state.copyWith(isLoading: false, error: error.toString());
          },
        );
  }

  Future<void> sendMessage(String senderId, String text) async {
    final message = MessageModel(
      messageId: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: chatId,
      senderId: senderId,
      text: text,
      createdAt: DateTime.now(),
      isRead: false,
    );

    await ref.read(sendMessageUseCaseProvider).execute(message);
  }
}
