import 'package:mess_messenger_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mess_messenger_app/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:mess_messenger_app/features/auth/data/models/user_model.dart';
import 'package:mess_messenger_app/features/auth/domain/entities/user_entity.dart';
import 'package:mess_messenger_app/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();
  final UserRemoteDataSource userRemoteDataSource = UserRemoteDataSource();

  @override
  Future<void> createUser(UserEntity user) async {
    final userModel = UserModel(
      isAnonymous: user.isAnonymous,
      id: user.id,
      name: user.name,
      email: user.email,
      phoneNumber: user.phoneNumber,
      isOnboardingCompleted: user.isOnboardingCompleted,
      language: user.language,
    );

    await userRemoteDataSource.createUser(userModel);
  }

  @override
  Future<void> getCurrentUser() async {
    await userRemoteDataSource.getCurrentUser();
  }
}
