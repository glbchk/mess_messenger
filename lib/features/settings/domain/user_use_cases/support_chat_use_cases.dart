import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/support_chat_model.dart';
import 'package:mess_messenger_app/features/settings/domain/user_repositories/support_chat_repository.dart';

abstract class SupportChatUseCase {
  final SupportChatRepository repository;
  SupportChatUseCase(this.repository);
}

class RequestSupportAgentUseCase extends SupportChatUseCase {
  RequestSupportAgentUseCase(super.repository);
  Future<String> execute(String userId) => repository.requestAgent(userId);
}

class SendSupportMessageUseCase extends SupportChatUseCase {
  SendSupportMessageUseCase(super.repository);
  Future<void> execute(String userId, String requestId, MessageModel message) =>
      repository.sendMessage(userId, requestId, message);
}

class FetchSupportMessagesUseCase extends SupportChatUseCase {
  FetchSupportMessagesUseCase(super.repository);
  Stream<List<MessageModel>> execute(String userId, String requestId) =>
      repository.fetchMessages(userId, requestId);
}

class WatchSupportRequestUseCase extends SupportChatUseCase {
  WatchSupportRequestUseCase(super.repository);
  Stream<SupportChatModel?> execute(String userId, String requestId) =>
      repository.watchRequest(userId, requestId);
}

class WatchActiveRequestIdUseCase extends SupportChatUseCase {
  WatchActiveRequestIdUseCase(super.repository);
  Stream<String?> execute(String userId) =>
      repository.watchActiveRequestId(userId);
}

class FetchPastRequestsUseCase extends SupportChatUseCase {
  FetchPastRequestsUseCase(super.repository);
  Stream<List<SupportChatModel>> execute(String userId) =>
      repository.fetchPastRequests(userId);
}
