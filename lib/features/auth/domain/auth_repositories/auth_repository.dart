import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<bool> isUserLoggedIn();
  Future<void> signUp(String email, String password, String name);
  Future<void> signInWithEmail(String email, String password, bool rememberMe);
  Future<UserCredential> signInWithGoogle();
  Future<void> linkEmailPassword(String email, String password);
  Future<void> linkGoogleAccount();
  // Future<void> unlinkGoogleAccount();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> logout();
}
