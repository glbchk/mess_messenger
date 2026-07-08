import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';

class OpenChatState {
  final List<MessageModel> messages;
  final bool isLoading;
  final String? error;

  const OpenChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  OpenChatState copyWith({
    List<MessageModel>? messages,
    bool? isLoading,
    String? error,
  }) {
    return OpenChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
