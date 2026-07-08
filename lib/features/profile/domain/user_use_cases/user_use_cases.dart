import 'package:mess_messenger_app/features/profile/data/models/user_model.dart';
import 'package:mess_messenger_app/features/profile/domain/user_repositories/user_repository.dart';

abstract class UserUseCase {
  final UserRepository userRepository;

  UserUseCase(this.userRepository);
}

class FetchUserDataUseCase extends UserUseCase {
  FetchUserDataUseCase(super.userRepository);

  Future<UserModel?> execute(String uid) {
    return userRepository.fetchUserData(uid);
  }
}
