import 'package:mess_messenger_app/features/settings/data/models/general_settings_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<void> createUser(UserEntity user);
  Future<UserModel?> fetchUserData(String uid);
  Future<void> updateGeneralSettings(
    String userId,
    GeneralSettingsModel settings,
  );
  Future<void> updateApplicationLanguage(
    String userId,
    String? selectedLanguage,
  );
  Future<void> updateUserName(String userId, String newName);
  Future<void> updateUserBirthday(String userId, String newBirthday);
  Future<void> updateUserEmail(String newEmail, {String? currentPassword});
}
