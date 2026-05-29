import 'package:mess_messenger_app/features/auth/domain/repositories/auth_repository.dart';

class IsLoggedInUserUseCase {
  final AuthRepository _repository;
  IsLoggedInUserUseCase(this._repository);

  Future<bool> execute() => _repository.isLoggedIn();
}

class LoginUserUseCase {
  final AuthRepository _repository;
  LoginUserUseCase(this._repository);

  Future<void> execute(String email, String password) =>
      _repository.login(email, password);
}

class LogoutUserUseCase {
  final AuthRepository _repository;
  LogoutUserUseCase(this._repository);

  Future<void> execute() => _repository.logout();
}
