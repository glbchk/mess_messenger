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

class LoginUserUseCase extends AuthUserUseCase {
  LoginUserUseCase(super.authRepository);

  Future<void> execute(String email, String password) {
    return authRepository.login(email, password);
  }
}

class LogoutUserUseCase extends AuthUserUseCase {
  LogoutUserUseCase(super.authRepository);

  Future<void> execute() {
    return authRepository.logout();
  }
}
