import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/support_faq_list.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/support_chat_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/states/support_chat_state.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/support_chat_providers.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';

class SupportChatNotifier extends Notifier<SupportChatState> {
  StreamSubscription<List<MessageModel>>? _messagesSubscription;
  StreamSubscription<SupportChatModel?>? _statusSubscription;

  String? get _userId => ref.read(userNotifierProvider).userData?.id;

  @override
  SupportChatState build() {
    ref.onDispose(() {
      _messagesSubscription?.cancel();
      _statusSubscription?.cancel();
    });

    final userId = _userId;
    if (userId != null) {
      Future.microtask(() => _resumeActiveRequest(userId));
    }

    return const SupportChatState();
  }

  Future<void> _resumeActiveRequest(String userId) async {
    final activeRequestId = await ref
        .read(watchActiveRequestIdUseCaseProvider)
        .execute(userId)
        .first;
    if (activeRequestId != null) {
      _startListening(userId, activeRequestId);
    }
  }

  void _startListening(String userId, String requestId) {
    state = state.copyWith(activeRequestId: requestId);

    _messagesSubscription?.cancel();
    _messagesSubscription = ref
        .read(fetchSupportMessagesUseCaseProvider)
        .execute(userId, requestId)
        .listen((messages) => state = state.copyWith(messages: messages));

    _statusSubscription?.cancel();
    _statusSubscription = ref
        .read(watchSupportRequestUseCaseProvider)
        .execute(userId, requestId)
        .listen((request) {
          if (request != null) state = state.copyWith(status: request.status);
        });
  }

  Future<void> requestAgent() async {
    final userId = _userId;
    if (userId == null) return;

    final requestId = await ref
        .read(requestSupportAgentUseCaseProvider)
        .execute(userId);
    state = state.copyWith(
      status: SupportChatStatus.agentRequested,
      activeRequestId: requestId,
    );
    _startListening(userId, requestId);

    await _sendSystemMessage(
      userId,
      requestId,
      "You've requested to speak with a support agent. Someone from our "
      "team will join this chat shortly.",
    );
  }

  Future<void> _sendSystemMessage(
    String userId,
    String requestId,
    String text,
  ) {
    return ref
        .read(sendSupportMessageUseCaseProvider)
        .execute(
          userId,
          requestId,
          MessageModel(
            messageId: DateTime.now().millisecondsSinceEpoch.toString(),
            chatId: requestId,
            senderId: kFaqBotSenderId,
            text: text,
            createdAt: DateTime.now(),
            isRead: false,
          ),
        );
  }

  Future<void> sendMessage(String text) async {
    final userId = _userId;
    final requestId = state.activeRequestId;
    final trimmed = text.trim();
    if (userId == null || requestId == null || trimmed.isEmpty) return;

    await ref
        .read(sendSupportMessageUseCaseProvider)
        .execute(
          userId,
          requestId,
          MessageModel(
            messageId: DateTime.now().millisecondsSinceEpoch.toString(),
            chatId: requestId,
            senderId: userId,
            text: trimmed,
            createdAt: DateTime.now(),
            isRead: false,
          ),
        );
  }
}
