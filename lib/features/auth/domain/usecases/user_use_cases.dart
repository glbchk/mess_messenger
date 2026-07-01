import 'package:mess_messenger_app/features/auth/domain/repositories/user_repository.dart';

abstract class UserUseCase {
  final UserRepository userRepository;

  UserUseCase(this.userRepository);
}

// class CreateUserUseCase extends UserUseCase {
//   CreateUserUseCase(super.userRepository);
//
//   Future<void> execute(UserEntity user) {
//     return userRepository.createUser(user);
//   }
// }
