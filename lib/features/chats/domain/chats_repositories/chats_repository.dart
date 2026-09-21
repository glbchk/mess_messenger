import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

abstract class ChatsRepository {
  Future<String> getOrCreateChat(
    String userA,
    String userB,
    String requestedBy,
  );
  Future<void> sendMessage(MessageModel message);
  Stream<List<MessageModel>> fetchMessages(String chatId);
  Stream<List<ChatModel>> fetchUserChats(String userId);
  Stream<UserModel> watchUser(String userId);
  Future<void> updateChatStatus(String chatId, ChatRequestStatus status);
}
