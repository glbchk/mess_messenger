import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class ContactsRemoteDataSource {
  final FirebaseFirestore firestore;

  ContactsRemoteDataSource(this.firestore);

  Future<UserModel?> findUserByEmail(String email) async {
    final normalized = email.trim().toLowerCase();
    final query = await firestore
        .collection('users')
        .where('email', isEqualTo: normalized)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    return UserModel.fromJson(query.docs.first.data());
  }
}
