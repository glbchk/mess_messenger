import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/support_chat_model.dart';

class SupportChatState {
  final String? activeRequestId;
  final SupportChatStatus status;
  final List<MessageModel> messages;
  final bool isLoading;
  final String? error;

  const SupportChatState({
    this.activeRequestId,
    this.status = SupportChatStatus.bot,
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  SupportChatState copyWith({
    String? activeRequestId,
    SupportChatStatus? status,
    List<MessageModel>? messages,
    bool? isLoading,
    String? error,
  }) {
    return SupportChatState(
      activeRequestId: activeRequestId ?? this.activeRequestId,
      status: status ?? this.status,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
