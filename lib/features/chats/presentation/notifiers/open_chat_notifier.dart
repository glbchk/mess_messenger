import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/support_faq_list.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/chats/presentation/states/open_chat_state.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';

class OpenChatNotifier extends Notifier<OpenChatState> {
  OpenChatNotifier(this.chatId);
  final String chatId;

  StreamSubscription<List<MessageModel>>? _messagesSubscription;
  StreamSubscription<ChatModel>? _chatSubscription;
  StreamSubscription<UserModel>? _otherUserSubscription;

  ChatModel? _lastChat;

  @override
  OpenChatState build() {
    ref.onDispose(() {
      _messagesSubscription?.cancel();
      _chatSubscription?.cancel();
      _otherUserSubscription?.cancel();
    });

    ref.listen(
      userNotifierProvider.select((s) => s.userData?.id),
      (_, __) => _resolveOtherUser(),
    );

    Future.microtask(() => _init());
    return const OpenChatState(isLoading: true);
  }

  Future<void> _init() async {
    fetchMessages(chatId);

    _chatSubscription = ref
        .read(chatsRemoteDataSourceProvider)
        .watchChat(chatId)
        .listen((chat) {
          _lastChat = chat;
          state = state.copyWith(typingUserIds: chat.typingUserIds);
          _resolveOtherUser();
        }, onError: (e) => print('DEBUG: watchChat failed: $e'));
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

  Future<void> sendFaqExchange(String userId, SupportFaqItem item) async {
    await sendMessage(userId, item.question);
    await sendMessage(kFaqBotSenderId, item.answer);
  }

  Future<void> sendUserMessage(String userId, String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    await sendMessage(userId, trimmed);

    final match = findMatchingFaq(trimmed);
    if (match != null) {
      await sendMessage(kFaqBotSenderId, match.answer);
    } else {
      await sendMessage(
        kFaqBotSenderId,
        "I couldn't find an answer to that. You can reach our support "
        "team directly at support@yourapp.com and we'll get back to you.",
      );
    }
  }

  Future<void> setTyping(String userId, bool isTyping) async {
    try {
      await ref
          .read(chatsRemoteDataSourceProvider)
          .setTypingStatus(chatId, userId, isTyping);
    } catch (e) {
      print('DEBUG: setTyping failed: $e');
    }
  }

  void _resolveOtherUser() {
    final chat = _lastChat;
    if (chat == null) return;

    final currentUserId = ref.read(userNotifierProvider).userData?.id;
    if (currentUserId == null) return;

    final otherUserId = chat.participantIds.firstWhere(
      (id) => id != currentUserId,
      orElse: () => '',
    );
    if (otherUserId.isEmpty || otherUserId == state.otherUser?.id) return;

    _otherUserSubscription?.cancel();
    _otherUserSubscription = ref
        .read(chatsRemoteDataSourceProvider)
        .watchUser(otherUserId)
        .listen(
          (user) => state = state.copyWith(otherUser: user),
          onError: (e) => print('DEBUG: watchUser failed: $e'),
        );
  }
}
