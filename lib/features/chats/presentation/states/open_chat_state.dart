import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class OpenChatState {
  final List<MessageModel> messages;
  final bool isLoading;
  final String? error;
  final UserModel? otherUser;
  final List<String> typingUserIds;

  const OpenChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
    this.otherUser,
    this.typingUserIds = const [],
  });

  OpenChatState copyWith({
    List<MessageModel>? messages,
    bool? isLoading,
    String? error,
    UserModel? otherUser,
    List<String>? typingUserIds,
  }) {
    return OpenChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      otherUser: otherUser ?? this.otherUser,
      typingUserIds: typingUserIds ?? this.typingUserIds,
    );
  }
}
