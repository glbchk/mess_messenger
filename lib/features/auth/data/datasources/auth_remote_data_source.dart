import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDataSource {
  final FirebaseAuth auth;

  AuthRemoteDataSource(this.auth);

  Future<bool> isLoggedIn() async {
    final user = await auth.authStateChanges().first;
    if (user == null) return false;

    if (!kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      final rememberMe = prefs.getBool('remember_me') ?? true;

      if (!rememberMe) {
        final loginTimestamp = prefs.getInt('login_timestamp');
        if (loginTimestamp != null) {
          final daysSinceLogin = DateTime.now()
              .difference(DateTime.fromMillisecondsSinceEpoch(loginTimestamp))
              .inDays;
          if (daysSinceLogin >= 30) {
            await auth.signOut();
            return false;
          }
        }
      }
    }

    return true;
  }

  Future<String> signUp(String email, String password) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        final emailCredential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );

        final googleUserCredential = await signInWithGoogle();
        final user = googleUserCredential.user!;

        await user.linkWithCredential(emailCredential);
        return user.uid;
      }
      rethrow;
    }
  }

  Future getCurrentUser() async {
    User? user = auth.currentUser;

    if (user != null) {
      return user;
    } else {
      throw Exception('User is not logged in');
    }
  }

  Future<String> signInWithEmail(
    String email,
    String password,
    bool rememberMe,
  ) async {
    if (kIsWeb) {
      await auth.setPersistence(
        rememberMe ? Persistence.LOCAL : Persistence.SESSION,
      );
    }

    final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (!kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('remember_me', rememberMe);
      await prefs.setInt(
        'login_timestamp',
        DateTime.now().millisecondsSinceEpoch,
      );
    }

    return credential.user!.uid;
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

  Future<void> linkGoogleAccount() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('No authenticated user');
    }

    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    if (kIsWeb) {
      await user.linkWithPopup(googleProvider);
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

  Future<void> sendPasswordResetEmail(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() async {
    return await auth.signOut();
  }
}
