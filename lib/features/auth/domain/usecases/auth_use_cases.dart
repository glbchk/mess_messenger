import 'package:mess_messenger_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mess_messenger_app/features/auth/domain/repositories/auth_repository.dart';

abstract class AuthUserUseCase {
  final AuthRepository authRepository = AuthRepositoryImpl();
}

class IsLoggedInUserUseCase extends AuthUserUseCase {
  Future<bool> execute() {
    return authRepository.isLoggedIn();
  }
}

class SignUpUserUseCase extends AuthUserUseCase {
  Future<void> execute(String email, String password) {
    return authRepository.signUp(email, password);
  }
}

class LoginUserUseCase extends AuthUserUseCase {
  Future<void> execute(String email, String password) {
    return authRepository.login(email, password);
  }
}

class LogoutUserUseCase extends AuthUserUseCase {
  Future<void> execute() {
    return authRepository.logout();
  }
}
