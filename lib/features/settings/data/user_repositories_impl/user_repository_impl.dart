import 'package:mess_messenger_app/features/settings/data/data_source/user_remote_data_source.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/domain/entities/user_entity.dart';
import 'package:mess_messenger_app/features/settings/domain/user_repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  // final AuthRemoteDataSource authRemoteDataSource;
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl(this.userRemoteDataSource);

  @override
  Future<void> createUser(UserEntity user) async {
    final userModel = UserModel(
      isAnonymous: user.isAnonymous,
      id: user.id,
      name: user.name,
      email: user.email,
      phoneNumber: user.phoneNumber,
      // isOnboardingCompleted: user.isOnboardingCompleted,
      language: user.language,
    );

    await userRemoteDataSource.createUser(userModel);
  }

  @override
  Future<UserModel?> fetchUserData(String uid) async {
    return await userRemoteDataSource.fetchUserData(uid);
  }
}
