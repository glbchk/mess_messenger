import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mess_messenger_app/features/auth/data/models/user_model.dart';

class UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSource(this.firestore);

  Future<void> createUser(UserModel user) async {
    await firestore.collection('users').doc(user.id).set(user.toJson());
  }

  Future<UserModel?> getCurrentUser(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    return doc.exists ? UserModel.fromJson(doc.data()!) : null;
  }
}
