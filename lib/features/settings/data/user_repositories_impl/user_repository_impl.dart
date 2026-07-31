import 'package:firebase_auth/firebase_auth.dart';
import 'package:mess_messenger_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:mess_messenger_app/features/settings/data/data_source/user_remote_data_source.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/domain/entities/user_entity.dart';
import 'package:mess_messenger_app/features/settings/domain/user_repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final AuthRemoteDataSource authRemoteDataSource;

  UserRepositoryImpl(this.userRemoteDataSource, this.authRemoteDataSource);

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

  @override
  Future<void> updateUserName(String userId, String newName) async {
    return await userRemoteDataSource.updateUserName(userId, newName);
  }

  @override
  Future<void> updateUserBirthday(String userId, String newBirthday) async {
    return await userRemoteDataSource.updateUserBirthday(userId, newBirthday);
  }

  @override
  Future<void> updateUserEmail(
    String newEmail, {
    String? currentPassword,
  }) async {
    try {
      await authRemoteDataSource.verifyBeforeUpdateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login' && currentPassword != null) {
        await authRemoteDataSource.reauthenticateWithPassword(currentPassword);
        await authRemoteDataSource.verifyBeforeUpdateEmail(newEmail);
      } else {
        rethrow;
      }
    }
  }
}
