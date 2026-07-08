import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/chats/domain/chats_repositories/chats_repository.dart';

abstract class ChatsUserUseCase {
  final ChatsRepository chatsRepository;

  ChatsUserUseCase(this.chatsRepository);
}

class GetOrCreateChatUseCase extends ChatsUserUseCase {
  GetOrCreateChatUseCase(super.chatsRepository);

  Future<String> execute(String userA, String userB) {
    return chatsRepository.getOrCreateChat(userA, userB);
  }
}

class SendMessageUseCase extends ChatsUserUseCase {
  SendMessageUseCase(super.chatsRepository);

  Future<void> execute(MessageModel message) {
    return chatsRepository.sendMessage(message);
  }
}

class FetchMessagesUseCase extends ChatsUserUseCase {
  FetchMessagesUseCase(super.chatsRepository);

  Stream<List<MessageModel>> execute(String chatId) {
    return chatsRepository.fetchMessages(chatId);
  }
}

class FetchUserChatsUseCase extends ChatsUserUseCase {
  FetchUserChatsUseCase(super.chatsRepository);

  Stream<List<ChatModel>> execute(String userId) {
    return chatsRepository.fetchUserChats(userId);
  }
}
