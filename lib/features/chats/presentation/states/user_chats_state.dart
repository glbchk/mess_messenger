import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';

class UserChatsState {
  final List<ChatModel> chats;
  final bool isLoading;
  final String? error;
  final bool isChatListCollapsed;
  final bool isProfileDetailsDisplayed;

  const UserChatsState({
    this.chats = const [],
    this.isLoading = false,
    this.error,
    this.isChatListCollapsed = false,
    this.isProfileDetailsDisplayed = false,
  });

  UserChatsState copyWith({
    List<ChatModel>? chats,
    bool? isLoading,
    String? error,
    bool? isChatListCollapsed,
    bool? isProfileDetailsDisplayed,
  }) {
    return UserChatsState(
      chats: chats ?? this.chats,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isChatListCollapsed: isChatListCollapsed ?? this.isChatListCollapsed,
      isProfileDetailsDisplayed:
          isProfileDetailsDisplayed ?? this.isProfileDetailsDisplayed,
    );
  }
}
