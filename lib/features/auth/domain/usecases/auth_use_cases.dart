import 'package:firebase_auth/firebase_auth.dart';
import 'package:mess_messenger_app/features/auth/domain/repositories/auth_repository.dart';

abstract class AuthUserUseCase {
  final AuthRepository authRepository;

  AuthUserUseCase(this.authRepository);
}

class IsLoggedInUserUseCase extends AuthUserUseCase {
  IsLoggedInUserUseCase(super.authRepository);

  Future<bool> execute() {
    return authRepository.isLoggedIn();
  }
}

class SignUpUserUseCase extends AuthUserUseCase {
  SignUpUserUseCase(super.authRepository);

  Future<void> execute(String email, String password) {
    return authRepository.signUp(email, password);
  }
}

class SignInWithEmailUserUseCase extends AuthUserUseCase {
  SignInWithEmailUserUseCase(super.authRepository);

  Future<void> execute(String email, String password, bool rememberMe) {
    return authRepository.signInWithEmail(email, password, rememberMe);
  }
}

class SignInWithGoogleUseCase extends AuthUserUseCase {
  SignInWithGoogleUseCase(super.authRepository);

  Future<UserCredential> execute() {
    return authRepository.signInWithGoogle();
  }
}

class SendPasswordResetUserUseCase extends AuthUserUseCase {
  SendPasswordResetUserUseCase(super.authRepository);

  Future<void> execute(String email) {
    return authRepository.sendPasswordResetEmail(email);
  }
}

class LinkEmailPasswordUseCase extends AuthUserUseCase {
  LinkEmailPasswordUseCase(super.authRepository);

  Future<void> execute(String email, String password) {
    return authRepository.linkEmailPassword(email, password);
  }
}

class LinkGoogleAccountUseCase extends AuthUserUseCase {
  LinkGoogleAccountUseCase(super.authRepository);

  Future<void> execute() {
    return authRepository.linkGoogleAccount();
  }
}

class LogoutUserUseCase extends AuthUserUseCase {
  LogoutUserUseCase(super.authRepository);

  Future<void> execute() {
    return authRepository.logout();
  }
}
