import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class OpenChatState {
  final List<MessageModel> messages;
  final bool isLoading;
  final String? error;
  final UserModel? otherUser;
  final List<String> typingUserIds;
  final ChatRequestStatus status;
  final String? requestedBy;

  const OpenChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
    this.otherUser,
    this.typingUserIds = const [],
    this.status = ChatRequestStatus.accepted,
    this.requestedBy,
  });

  OpenChatState copyWith({
    List<MessageModel>? messages,
    bool? isLoading,
    String? error,
    UserModel? otherUser,
    List<String>? typingUserIds,
    ChatRequestStatus? status,
    String? requestedBy,
  }) {
    return OpenChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      otherUser: otherUser ?? this.otherUser,
      typingUserIds: typingUserIds ?? this.typingUserIds,
      status: status ?? this.status,
      requestedBy: requestedBy ?? this.requestedBy,
    );
  }
}
