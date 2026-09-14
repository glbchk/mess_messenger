import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/chats/domain/chat_helper.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class ChatsRemoteDataSource {
  final FirebaseFirestore firestore;
  ChatsRemoteDataSource(this.firestore);

  Future<String> getOrCreateChat(String userA, String userB) async {
    final pairKey = directChatId(userA, userB);
    final chatRef = firestore.collection('direct_chats').doc(pairKey);

    return firestore.runTransaction<String>((txn) async {
      final chatSnap = await txn.get(chatRef);

      if (chatSnap.exists) {
        return chatRef.id;
      }

      txn.set(
        chatRef,
        ChatModel(
          id: chatRef.id,
          participantIds: [userA, userB]..sort(),
          lastMessage: '',
          lastMessageAt: DateTime.now(),
          isGroup: false,
        ).toJson(),
      );

      return chatRef.id;
    });
  }

  Future<String> createGroupChat(
    List<String> participantIds, {
    required String groupName,
  }) async {
    final chatRef = firestore.collection('group_chats').doc();
    await chatRef.set(
      ChatModel(
        id: chatRef.id,
        participantIds: participantIds,
        lastMessage: '',
        lastMessageAt: DateTime.now(),
        isGroup: true,
        groupName: groupName,
      ).toJson(),
    );
    return chatRef.id;
  }

  Future<void> sendMessage(MessageModel message) async {
    final chatRef = firestore.collection('direct_chats').doc(message.chatId);
    final messageRef = chatRef.collection('messages').doc(message.messageId);

    await messageRef.set(message.toJson());

    await chatRef.set({
      'last_message': message.text,
      'last_message_at': message.createdAt.toIso8601String(),
    }, SetOptions(merge: true));
  }

  Stream<List<MessageModel>> fetchMessages(String chatId) {
    return firestore
        .collection('direct_chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('created_at')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => MessageModel.fromJson(doc.data()))
              .toList();
        });
  }

  Stream<List<ChatModel>> fetchUserChats(String userId) {
    return firestore
        .collection('direct_chats')
        .where('participant_ids', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
          final chats = snapshot.docs
              .map((doc) => ChatModel.fromJson(doc.data()))
              .toList();
          chats.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
          return chats;
        });
  }

  Future<void> setUserOnlineStatus(String userId, bool isOnline) async {
    await firestore.collection('users').doc(userId).set({
      'is_online': isOnline,
      'last_active_at': DateTime.now().toIso8601String(),
    }, SetOptions(merge: true));
  }

  Stream<UserModel> watchUser(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map((doc) {
      final data = doc.data();
      if (data == null) return UserModel(id: userId);
      return UserModel.fromJson({...data, 'id': doc.id});
    });
  }

  Future<void> setTypingStatus(
    String chatId,
    String userId,
    bool isTyping,
  ) async {
    final chatRef = firestore.collection('direct_chats').doc(chatId);
    await chatRef.set({
      'typing_user_ids': isTyping
          ? FieldValue.arrayUnion([userId])
          : FieldValue.arrayRemove([userId]),
    }, SetOptions(merge: true));
  }

  Stream<ChatModel> watchChat(String chatId) {
    return firestore
        .collection('direct_chats')
        .doc(chatId)
        .snapshots()
        .map((doc) => ChatModel.fromJson(doc.data()!));
  }
}
