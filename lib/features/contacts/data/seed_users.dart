import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

Future<void> seedUsers(FirebaseFirestore firestore) async {
  for (final u in kSeedUsers) {
    await firestore
        .collection('users')
        .doc(u.id)
        .set(u.toJson(), SetOptions(merge: true));
  }
}
