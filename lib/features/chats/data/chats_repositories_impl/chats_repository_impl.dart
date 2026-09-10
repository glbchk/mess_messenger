import 'package:mess_messenger_app/features/chats/data/datasources/chats_remote_data_source.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/chats/domain/chats_repositories/chats_repository.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class ChatsRepositoryImpl implements ChatsRepository {
  final ChatsRemoteDataSource chatsRemoteDataSource;

  ChatsRepositoryImpl(this.chatsRemoteDataSource);

  @override
  Future<String> getOrCreateChat(String userA, String userB) {
    return chatsRemoteDataSource.getOrCreateChat(userA, userB);
  }

  @override
  Future<void> sendMessage(MessageModel message) {
    return chatsRemoteDataSource.sendMessage(message);
  }

  @override
  Stream<List<MessageModel>> fetchMessages(String chatId) {
    return chatsRemoteDataSource.fetchMessages(chatId);
  }

  @override
  Stream<List<ChatModel>> fetchUserChats(String userId) {
    return chatsRemoteDataSource.fetchUserChats(userId);
  }

  @override
  Stream<UserModel> watchUser(String userId) {
    return chatsRemoteDataSource.watchUser(userId);
  }
}
