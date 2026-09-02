import 'package:firebase_auth/firebase_auth.dart';

sealed class AuthFailure implements Exception {
  const AuthFailure();
}

class WrongPasswordFailure extends AuthFailure {
  const WrongPasswordFailure();
}

class RequiresRecentLoginFailure extends AuthFailure {
  const RequiresRecentLoginFailure();
}

class EmailAlreadyInUseFailure extends AuthFailure {
  const EmailAlreadyInUseFailure();
}

class MissingPasswordFailure extends AuthFailure {
  const MissingPasswordFailure();
}

class UnknownAuthFailure extends AuthFailure {
  final String debugMessage;
  const UnknownAuthFailure(this.debugMessage);
}

AuthFailure mapFirebaseAuthException(FirebaseAuthException e) {
  return switch (e.code) {
    'wrong-password' || 'invalid-credential' => const WrongPasswordFailure(),
    'requires-recent-login' => const RequiresRecentLoginFailure(),
    'email-already-in-use' => const EmailAlreadyInUseFailure(),
    'missing-password' => const MissingPasswordFailure(),
    'user-token-expired' || 'user-not-found' => const SessionRevokedFailure(),
    _ => UnknownAuthFailure(e.message ?? e.code),
  };
}

class SessionRevokedFailure extends AuthFailure {
  const SessionRevokedFailure();
}
