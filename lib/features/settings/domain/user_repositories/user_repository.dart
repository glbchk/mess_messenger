import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<void> createUser(UserEntity user);
  Future<UserModel?> fetchUserData(String uid);
  Future<void> updateAvatar(String userId, String? avatarUrl);
  Future<void> updateIsLoggedIn(String userId, bool isLoggedIn);
  Future<void> updateLanguage(String userId, String? language);
  Future<void> updateIsPhotoPasswordProtected(String userId, bool isProtected);
  Future<void> updateIsAudioPasswordProtected(String userId, bool isProtected);
  Future<void> updateIsVideoPasswordProtected(String userId, bool isProtected);
  Future<void> updateIsDocumentPasswordProtected(
    String userId,
    bool isProtected,
  );
  Future<void> updateUserName(String userId, String newName);
  Future<void> updateUserBirthday(String userId, String newBirthday);
  Future<void> updateUserEmail(String newEmail, {String? currentPassword});
  Future<void> updateUserPhoneNumber(String userId, String newPhoneNumber);
  Future<void> updateThemeMode(String userId, String selectedTheme);
  Future<void> updateBackgroundColor(String userId, int? backgroundColorIndex);
  Future<void> updateSubscriptionPlan(
    String userId,
    SubscriptionPlan selectedPlan,
  );
}
