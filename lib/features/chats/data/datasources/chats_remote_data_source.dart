import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';

class ChatsRemoteDataSource {
  final FirebaseFirestore firestore;
  ChatsRemoteDataSource(this.firestore);

  // Finds an existing chat between two users, or creates one if none exists.
  Future<String> getOrCreateChat(String userA, String userB) async {
    final existing = await firestore
        .collection('chats')
        .where('participant_ids', arrayContains: userA)
        .where('is_group', isEqualTo: false)
        .get();

    for (final doc in existing.docs) {
      final ids = List<String>.from(doc['participant_ids']);
      if (ids.length == 2 && ids.contains(userB)) {
        return doc.id;
      }
    }

    final chatRef = firestore.collection('chats').doc();
    await chatRef.set(
      ChatModel(
        id: chatRef.id,
        participantIds: [userA, userB],
        lastMessage: '',
        lastMessageAt: DateTime.now(),
        isGroup: false,
      ).toJson(),
    );

    return chatRef.id;
  }

  Future<String> createChat(
    List<String> participantIds, {
    bool isGroup = false,
    String? groupName,
  }) async {
    final chatRef = firestore.collection('chats').doc();
    await chatRef.set(
      ChatModel(
        id: chatRef.id,
        participantIds: participantIds,
        lastMessage: '',
        lastMessageAt: DateTime.now(),
        isGroup: isGroup,
        groupName: groupName,
      ).toJson(),
    );
    return chatRef.id;
  }

  Future<void> sendMessage(MessageModel message) async {
    final chatRef = firestore.collection('chats').doc(message.chatId);
    final messageRef = chatRef.collection('messages').doc(message.messageId);

    await messageRef.set(message.toJson());

    await chatRef.update({
      'last_message': message.text,
      'last_message_at': message.createdAt.toIso8601String(),
    });
  }

  Stream<List<MessageModel>> fetchMessages(String chatId) {
    return firestore
        .collection('chats')
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
        .collection('chats')
        .where('participant_ids', arrayContains: userId)
        .orderBy('last_message_at', descending: true)
        .snapshots()
        .map((snapshot) {
          print('DEBUG: fetchUserChats found ${snapshot.docs.length} docs');

          for (final doc in snapshot.docs) {
            print('DEBUG: doc id = ${doc.id}, data = ${doc.data()}');
          }

          return snapshot.docs
              .map((doc) => ChatModel.fromJson(doc.data()))
              .toList();
        });
  }
}
