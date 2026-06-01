import 'package:mess_messenger_app/features/auth/data/repositories/user_repository_impl.dart';
import 'package:mess_messenger_app/features/auth/domain/entities/user_entity.dart';

abstract class UserUseCase {
  final UserRepositoryImpl userRepository = UserRepositoryImpl();
}

class CreateUserUseCase extends UserUseCase {
  Future<void> execute(UserEntity user) {
    return userRepository.createUser(user);
  }
}
