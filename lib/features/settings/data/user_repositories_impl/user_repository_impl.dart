import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/core/errors/auth_failure.dart';
import 'package:mess_messenger_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:mess_messenger_app/features/settings/data/data_sources/user_remote_data_source.dart';
import 'package:mess_messenger_app/features/settings/data/models/notification_settings_model.dart';
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
    );

    await userRemoteDataSource.createUser(userModel);
  }

  @override
  Future<UserModel?> fetchUserData(String uid) async {
    return await userRemoteDataSource.fetchUserData(uid);
  }

  @override
  Future<void> updateAvatar(String userId, String? avatarUrl) async {
    return await userRemoteDataSource.updateAvatar(userId, avatarUrl);
  }

  @override
  Future<void> updateIsLoggedIn(String userId, bool isLoggedIn) async {
    return await userRemoteDataSource.updateIsLoggedIn(userId, isLoggedIn);
  }

  @override
  Future<void> updateLanguage(String userId, String? language) async {
    return await userRemoteDataSource.updateLanguage(userId, language);
  }

  @override
  Future<void> updateIsPhotoPasswordProtected(
    String userId,
    bool isProtected,
  ) async {
    return await userRemoteDataSource.updateIsPhotoPasswordProtected(
      userId,
      isProtected,
    );
  }

  @override
  Future<void> updateIsAudioPasswordProtected(
    String userId,
    bool isProtected,
  ) async {
    return await userRemoteDataSource.updateIsAudioPasswordProtected(
      userId,
      isProtected,
    );
  }

  @override
  Future<void> updateIsVideoPasswordProtected(
    String userId,
    bool isProtected,
  ) async {
    return await userRemoteDataSource.updateIsVideoPasswordProtected(
      userId,
      isProtected,
    );
  }

  @override
  Future<void> updateIsDocumentPasswordProtected(
    String userId,
    bool isProtected,
  ) async {
    return await userRemoteDataSource.updateIsDocumentPasswordProtected(
      userId,
      isProtected,
    );
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
    } on RequiresRecentLoginFailure {
      if (currentPassword == null || currentPassword.isEmpty) {
        throw const MissingPasswordFailure();
      }
      await authRemoteDataSource.reauthenticateWithPassword(currentPassword);
      await authRemoteDataSource.verifyBeforeUpdateEmail(newEmail);
    }
  }

  @override
  Future<void> updateUserPhoneNumber(
    String userId,
    String newPhoneNumber,
  ) async {
    return await userRemoteDataSource.updateUserPhoneNumber(
      userId,
      newPhoneNumber,
    );
  }

  @override
  Future<void> updateThemeMode(String userId, String selectedTheme) async {
    return await userRemoteDataSource.updateThemeMode(userId, selectedTheme);
  }

  @override
  Future<void> updateBackgroundColor(
    String userId,
    String? backgroundColorId,
  ) async {
    return await userRemoteDataSource.updateBackgroundColor(
      userId,
      backgroundColorId,
    );
  }

  @override
  Future<void> updateSubscriptionPlan(
    String userId,
    SubscriptionPlan selectedPlan,
  ) async {
    return await userRemoteDataSource.updateSubscriptionPlan(
      userId,
      selectedPlan,
    );
  }

  @override
  Future<void> updateNotificationSettings(
    String userId,
    NotificationSettingsModel settings,
  ) async {
    return await userRemoteDataSource.updateNotificationSettings(
      userId,
      settings,
    );
  }
}
