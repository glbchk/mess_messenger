import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mess_messenger_app/core/errors/auth_failure.dart';

class AuthRemoteDataSource {
  final FirebaseAuth auth;

  AuthRemoteDataSource(this.auth);

  Future<bool> isUserLoggedIn() async {
    final user = await auth.authStateChanges().first;
    return user != null;
  }

  Future<String> signUp(String email, String password) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user!.uid;
  }

  Future<String> signInWithEmail(String email, String password) async {
    final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user!.uid;
  }

  Future<void> setPersistence(bool rememberMe) async {
    if (kIsWeb) {
      await auth.setPersistence(
        rememberMe ? Persistence.LOCAL : Persistence.SESSION,
      );
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      final provider = GoogleAuthProvider();
      return auth.signInWithPopup(provider);
    }
    final googleUser = await GoogleSignIn.instance.authenticate();
    final googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    return auth.signInWithCredential(credential);
  }

  Future<void> linkEmailPassword(String email, String password) async {
    final user = auth.currentUser;
    if (user == null) throw Exception('No authenticated user');
    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await user.linkWithCredential(credential);
  }

  Future<void> linkGoogleAccount() async {
    final user = auth.currentUser;
    if (user == null) throw Exception('No authenticated user');

    if (kIsWeb) {
      await user.linkWithPopup(GoogleAuthProvider());
      return;
    }
    final googleUser = await GoogleSignIn.instance.authenticate();
    final googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    await user.linkWithCredential(credential);
  }

  Future<void> unlinkGoogleAccount() async {
    //TODO: NEED TO FIX
  }

  Future<void> updatePassword(String newPassword) async {
    final user = auth.currentUser;
    if (user == null) throw const UnknownAuthFailure('No authenticated user');
    try {
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseAuthException(e);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> verifyBeforeUpdateEmail(String newEmail) async {
    final user = auth.currentUser;
    if (user == null) throw const UnknownAuthFailure('No authenticated user');
    try {
      await user.verifyBeforeUpdateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseAuthException(e);
    }
  }

  Future<void> reauthenticateWithPassword(String currentPassword) async {
    final user = auth.currentUser;
    if (user == null) throw const UnknownAuthFailure('No authenticated user');
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );
    try {
      await user.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseAuthException(e);
    }
  }

  Future<String?> reloadAndGetCurrentEmail() async {
    final user = auth.currentUser;
    if (user == null) return null;
    try {
      await user.reload();
      return auth.currentUser?.email;
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseAuthException(e);
    }
  }

  Future<void> logout() async {
    return await auth.signOut();
  }

  Future<void> logoutFromAllDevices() async {
    final result = await FirebaseFunctions.instance
        .httpsCallable('logoutFromAllDevices')
        .call();
    if (result.data['success'] != true) {
      throw Exception('Failed to revoke sessions');
    }
  }
}
