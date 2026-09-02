import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> globalLogout() async {
  final user = FirebaseAuth.instance.currentUser;
  print("currentUser: ${user?.uid}");
  print("idToken: ${await user?.getIdToken()}");

  try {
    final result = await FirebaseFunctions.instance
        .httpsCallable('logoutFromAllDevices')
        .call();
    if (result.data['success'] == true) {
      await FirebaseAuth.instance.signOut();
    }
  } catch (e) {
    print("Failed to logout from all devices: $e");
  }
}
