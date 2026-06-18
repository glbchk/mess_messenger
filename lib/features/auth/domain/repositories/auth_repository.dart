import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<bool> isLoggedIn();
  Future<String> signUp(String email, String password);
  Future<void> signInWithEmail(String email, String password, bool rememberMe);
  Future<UserCredential> signInWithGoogle();
  // Future<void> unlinkGoogleAccount();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> logout();
}
