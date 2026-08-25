import 'package:firebase_auth/firebase_auth.dart';
import 'package:mess_messenger_app/features/auth/domain/auth_repositories/auth_repository.dart';

abstract class AuthUserUseCase {
  final AuthRepository authRepository;

  AuthUserUseCase(this.authRepository);
}

class IsLoggedInUserUseCase extends AuthUserUseCase {
  IsLoggedInUserUseCase(super.authRepository);

  Future<bool> execute() {
    return authRepository.isUserLoggedIn();
  }
}

class SignUpUserUseCase extends AuthUserUseCase {
  SignUpUserUseCase(super.authRepository);

  Future<void> execute(String email, String password, String name) {
    return authRepository.signUp(email, password, name);
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

class UpdatePasswordUseCase extends AuthUserUseCase {
  UpdatePasswordUseCase(super.authRepository);

  Future<void> execute({
    required String newPassword,
    required String currentPassword,
  }) {
    return authRepository.updatePassword(
      newPassword: newPassword,
      currentPassword: currentPassword,
    );
  }
}

class SendPasswordResetUseCase extends AuthUserUseCase {
  SendPasswordResetUseCase(super.authRepository);

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

class LogoutFromAllDevicesUseCase extends AuthUserUseCase {
  LogoutFromAllDevicesUseCase(super.authRepository);

  Future<void> execute() {
    return authRepository.logoutFromAllDevices();
  }
}
