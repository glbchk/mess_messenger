import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';

abstract class ChatsRepository {
  Future<String> getOrCreateChat(String userA, String userB);
  Future<void> sendMessage(MessageModel message);
  Stream<List<MessageModel>> fetchMessages(String chatId);
  Stream<List<ChatModel>> fetchUserChats(String userId);
}
