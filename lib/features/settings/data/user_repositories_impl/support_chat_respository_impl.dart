import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/settings/data/data_sources/support_chat_remote_data_source.dart';
import 'package:mess_messenger_app/features/settings/data/models/support_chat_model.dart';
import 'package:mess_messenger_app/features/settings/domain/user_repositories/support_chat_repository.dart';

class SupportChatRepositoryImpl implements SupportChatRepository {
  final SupportChatRemoteDataSource remoteDataSource;

  SupportChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> requestAgent(String userId) =>
      remoteDataSource.requestAgent(userId);

  @override
  Future<void> sendMessage(
    String userId,
    String requestId,
    MessageModel message,
  ) => remoteDataSource.sendMessage(userId, requestId, message);

  @override
  Stream<List<MessageModel>> fetchMessages(String userId, String requestId) =>
      remoteDataSource.fetchMessages(userId, requestId);

  @override
  Stream<SupportChatModel?> watchRequest(String userId, String requestId) =>
      remoteDataSource.watchRequest(userId, requestId);

  @override
  Stream<String?> watchActiveRequestId(String userId) =>
      remoteDataSource.watchActiveRequestId(userId);

  @override
  Stream<List<SupportChatModel>> fetchPastRequests(String userId) =>
      remoteDataSource.fetchPastRequests(userId);
}
