import 'package:mess_messenger_app/features/auth/data/models/user_model.dart';
import 'package:mess_messenger_app/features/auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<void> createUser(UserEntity user);
  Future<UserModel?> getCurrentUser(String uid);
}
