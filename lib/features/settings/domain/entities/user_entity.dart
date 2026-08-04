import 'package:mess_messenger_app/features/settings/data/models/general_settings_model.dart';

class UserEntity {
  final bool? isAnonymous;
  final String id;
  final String? name;
  final String? email;
  final bool? isEmailVerified;
  final String? phoneNumber;
  final String? birthday;
  final bool isOnboardingCompleted;
  final String? language;
  final GeneralSettingsModel? generalSettings;

  UserEntity({
    this.isAnonymous,
    required this.id,
    this.name,
    this.email,
    this.isEmailVerified,
    this.phoneNumber,
    this.birthday,
    required this.isOnboardingCompleted,
    this.language,
    this.generalSettings,
  });
}
