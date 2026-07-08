import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mess_messenger_app/features/profile/data/models/user_model.dart';

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
}
