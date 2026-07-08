import 'package:mess_messenger_app/features/profile/data/models/user_model.dart';
import 'package:mess_messenger_app/features/profile/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<void> createUser(UserEntity user);
  Future<UserModel?> fetchUserData(String uid);
}
