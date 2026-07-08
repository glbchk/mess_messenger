import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';

class UserChatsState {
  final List<ChatModel> chats;
  final bool isLoading;
  final String? error;

  const UserChatsState({
    this.chats = const [],
    this.isLoading = false,
    this.error,
  });

  UserChatsState copyWith({
    List<ChatModel>? chats,
    bool? isLoading,
    String? error,
  }) {
    return UserChatsState(
      chats: chats ?? this.chats,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
