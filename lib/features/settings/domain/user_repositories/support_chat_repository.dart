import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/support_chat_model.dart';

abstract class SupportChatRepository {
  Future<String> requestAgent(String userId);
  Future<void> sendMessage(
    String userId,
    String requestId,
    MessageModel message,
  );
  Stream<List<MessageModel>> fetchMessages(String userId, String requestId);
  Stream<SupportChatModel?> watchRequest(String userId, String requestId);
  Stream<String?> watchActiveRequestId(String userId);
  Stream<List<SupportChatModel>> fetchPastRequests(String userId);
}
