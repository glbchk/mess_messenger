import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSource(this.firestore);

  Future<void> createUser(UserModel user) async {
    await firestore.collection('users').doc(user.id).set(user.toJson());
  }

  Future<UserModel?> fetchUserData(String uid) async {
    final doc = await firestore.collection("users").doc(uid).get();

    if (doc.exists && doc.data() != null) {
      final userModel = UserModel.fromJson(doc.data()!);

      print("DEBUG: Firestore Data: ${doc.data()}");

      return userModel;
    }

    return null;
  }

  Future<void> updateUserName(String userId, String newName) async {
    await firestore.collection('users').doc(userId).update({'name': newName});
  }

  Future<void> updateUserBirthday(String userId, String newBirthday) async {
    await firestore.collection('users').doc(userId).update({
      'birthday': newBirthday,
    });
  }

  Future<void> updateUserEmail(String userId, String newEmail) async {
    await firestore.collection('users').doc(userId).update({'email': newEmail});
  }
}
