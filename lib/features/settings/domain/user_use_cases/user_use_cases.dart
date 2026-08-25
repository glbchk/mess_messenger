import 'package:mess_messenger_app/core/enums/enums.dart';
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

class UpdateAvatarUseCase extends UserUseCase {
  UpdateAvatarUseCase(super.userRepository);

  Future<void> execute(String userId, String? avatarUrl) {
    return userRepository.updateAvatar(userId, avatarUrl);
  }
}

class UpdateIsLoggedInUseCase extends UserUseCase {
  UpdateIsLoggedInUseCase(super.userRepository);

  Future<void> execute(String userId, bool isLoggedIn) {
    return userRepository.updateIsLoggedIn(userId, isLoggedIn);
  }
}

class UpdateLanguageUseCase extends UserUseCase {
  UpdateLanguageUseCase(super.userRepository);

  Future<void> execute(String userId, String? language) {
    return userRepository.updateLanguage(userId, language);
  }
}

class UpdateIsPhotoPasswordProtectedUseCase extends UserUseCase {
  UpdateIsPhotoPasswordProtectedUseCase(super.userRepository);

  Future<void> execute(String userId, bool isProtected) {
    return userRepository.updateIsPhotoPasswordProtected(userId, isProtected);
  }
}

class UpdateIsAudioPasswordProtectedUseCase extends UserUseCase {
  UpdateIsAudioPasswordProtectedUseCase(super.userRepository);

  Future<void> execute(String userId, bool isProtected) {
    return userRepository.updateIsAudioPasswordProtected(userId, isProtected);
  }
}

class UpdateIsVideoPasswordProtectedUseCase extends UserUseCase {
  UpdateIsVideoPasswordProtectedUseCase(super.userRepository);

  Future<void> execute(String userId, bool isProtected) {
    return userRepository.updateIsVideoPasswordProtected(userId, isProtected);
  }
}

class UpdateIsDocumentPasswordProtectedUseCase extends UserUseCase {
  UpdateIsDocumentPasswordProtectedUseCase(super.userRepository);

  Future<void> execute(String userId, bool isProtected) {
    return userRepository.updateIsDocumentPasswordProtected(
      userId,
      isProtected,
    );
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

class UpdateUserPhoneNumberUseCase extends UserUseCase {
  UpdateUserPhoneNumberUseCase(super.userRepository);

  Future<void> execute(String userId, String newPhoneNumber) {
    return userRepository.updateUserPhoneNumber(userId, newPhoneNumber);
  }
}

class UpdateThemeModeUseCase extends UserUseCase {
  UpdateThemeModeUseCase(super.userRepository);
  Future<void> execute(String userId, String selectedTheme) {
    return userRepository.updateThemeMode(userId, selectedTheme);
  }
}

class UpdateBackgroundColorUseCase extends UserUseCase {
  UpdateBackgroundColorUseCase(super.userRepository);
  Future<void> execute(String userId, int? backgroundColorIndex) {
    return userRepository.updateBackgroundColor(userId, backgroundColorIndex);
  }
}

class UpdateSubscriptionPlanUseCase extends UserUseCase {
  UpdateSubscriptionPlanUseCase(super.userRepository);
  Future<void> execute(String userId, SubscriptionPlan selectedPlan) {
    return userRepository.updateSubscriptionPlan(userId, selectedPlan);
  }
}
