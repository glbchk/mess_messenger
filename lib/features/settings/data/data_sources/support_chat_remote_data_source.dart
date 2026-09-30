import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/support_chat_model.dart';

class SupportChatRemoteDataSource {
  final FirebaseFirestore firestore;

  SupportChatRemoteDataSource(this.firestore);

  Future<String> requestAgent(String userId) async {
    final docRef = firestore.collection('support_chats').doc(userId);
    final requestsRef = firestore
        .collection('support_chats')
        .doc(userId)
        .collection('requests');
    final now = DateTime.now();

    final userSnapshot = await docRef.get();
    final activeRequestId =
        userSnapshot.data()?['active_request_id'] as String?;

    if (activeRequestId != null) {
      final activeSnapshot = await requestsRef.doc(activeRequestId).get();
      if (activeSnapshot.exists &&
          activeSnapshot.data()?['status'] != SupportChatStatus.closed.name) {
        await requestsRef.doc(activeRequestId).update({
          'status': SupportChatStatus.agentRequested.name,
          'updated_at': now.toIso8601String(),
        });
        return activeRequestId;
      }
    }

    final requestRef = requestsRef.doc();
    await requestRef.set(
      SupportChatModel(
        id: requestRef.id,
        userId: userId,
        status: SupportChatStatus.agentRequested,
        createdAt: now,
        updatedAt: now,
      ).toJson(),
    );
    await docRef.set({
      'active_request_id': requestRef.id,
    }, SetOptions(merge: true));

    return requestRef.id;
  }

  Future<void> sendMessage(
    String userId,
    String requestId,
    MessageModel message,
  ) async {
    final requestRef = firestore
        .collection('support_chats')
        .doc(userId)
        .collection('requests')
        .doc(requestId);
    final messageRef = requestRef.collection('messages').doc(message.messageId);

    await messageRef.set(message.toJson());
    await requestRef.update({'updated_at': DateTime.now().toIso8601String()});
  }

  Stream<List<MessageModel>> fetchMessages(String userId, String requestId) {
    return firestore
        .collection('support_chats')
        .doc(userId)
        .collection('requests')
        .doc(requestId)
        .collection('messages')
        .orderBy('created_at')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => MessageModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Stream<SupportChatModel?> watchRequest(String userId, String requestId) {
    return firestore
        .collection('support_chats')
        .doc(userId)
        .collection('requests')
        .doc(requestId)
        .snapshots()
        .map((doc) {
          final data = doc.data();
          if (data == null) return null;
          return SupportChatModel.fromJson(data);
        });
  }

  Stream<String?> watchActiveRequestId(String userId) {
    return firestore
        .collection('support_chats')
        .doc(userId)
        .snapshots()
        .map((doc) => doc.data()?['active_request_id'] as String?);
  }

  Stream<List<SupportChatModel>> fetchPastRequests(String userId) {
    return firestore
        .collection('support_chats')
        .doc(userId)
        .collection('requests')
        .orderBy('created_at', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => SupportChatModel.fromJson(doc.data()))
              .toList(),
        );
  }
}
