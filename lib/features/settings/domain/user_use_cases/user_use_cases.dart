import 'package:mess_messenger_app/features/settings/data/models/general_settings_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/domain/user_repositories/user_repository.dart';

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

class UpdateGeneralSettingsUseCase extends UserUseCase {
  UpdateGeneralSettingsUseCase(super.userRepository);

  Future<void> execute(String userId, GeneralSettingsModel settings) {
    return userRepository.updateGeneralSettings(userId, settings);
  }
}

class UpdateApplicationLanguageUseCase extends UserUseCase {
  UpdateApplicationLanguageUseCase(super.userRepository);

  Future<void> execute(String userId, String? selectedLanguage) {
    return userRepository.updateApplicationLanguage(userId, selectedLanguage);
  }
}

class UpdateUserNameUseCase extends UserUseCase {
  UpdateUserNameUseCase(super.userRepository);

  Future<void> execute(String userId, String newName) {
    return userRepository.updateUserName(userId, newName);
  }
}

class UpdateUserBirthdayUseCase extends UserUseCase {
  UpdateUserBirthdayUseCase(super.userRepository);

  Future<void> execute(String userId, String newBirthday) {
    return userRepository.updateUserBirthday(userId, newBirthday);
  }
}

class UpdateUserEmailUseCase extends UserUseCase {
  UpdateUserEmailUseCase(super.userRepository);

  Future<void> execute(String newEmail, {String? currentPassword}) {
    return userRepository.updateUserEmail(
      newEmail,
      currentPassword: currentPassword,
    );
  }
}
