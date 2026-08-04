import 'package:mess_messenger_app/features/settings/data/models/general_settings_model.dart';
import 'package:mess_messenger_app/features/settings/domain/entities/user_entity.dart';

class UserModel {
  final bool? isAnonymous;
  final String id;
  final String? name;
  final String? email;
  final bool? isEmailVerified;
  final String? phoneNumber;
  final String? birthday;
  // final bool isOnboardingCompleted;
  final GeneralSettingsModel? generalSettings;

  UserModel({
    this.isAnonymous,
    required this.id,
    this.name,
    this.email,
    this.isEmailVerified,
    this.phoneNumber,
    this.birthday,
    // required this.isOnboardingCompleted,
    this.generalSettings,
  });

  factory UserModel.newUser({
    required String id,
    required String email,
    required String name,
  }) {
    return UserModel(
      id: id,
      email: email,
      isAnonymous: false,
      isEmailVerified: false,
      name: name,
      phoneNumber: '',
      birthday: '',
      generalSettings: GeneralSettingsModel.defaults(),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      isAnonymous: json['is_anonymous'] ?? false,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      isEmailVerified: json['is_email_verified'] ?? false,
      phoneNumber: json['phone_number'] ?? '',
      birthday: json['birthday'] ?? '',
      // isOnboardingCompleted: json['is_onboarding_completed'],
      generalSettings: json['general_settings'] != null
          ? GeneralSettingsModel.fromJson(json['general_settings'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_anonymous': isAnonymous,
      'id': id,
      'name': name,
      'email': email,
      'is_email_verified': isEmailVerified,
      'phone_number': phoneNumber,
      'birthday': birthday,
      // 'is_onboarding_completed': isOnboardingCompleted,
      'general_settings': generalSettings?.toJson(),
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      isAnonymous: entity.isAnonymous ?? false,
      id: entity.id,
      name: entity.name ?? '',
      email: entity.email,
      isEmailVerified: entity.isEmailVerified ?? false,
      phoneNumber: entity.phoneNumber ?? '',
      birthday: entity.birthday ?? '',
      // isOnboardingCompleted: entity.isOnboardingCompleted,
      generalSettings: entity.generalSettings,
    );
  }

  UserModel copyUserWith({
    bool? isAnonymous,
    String? id,
    String? name,
    String? email,
    bool? isEmailVerified,
    String? phoneNumber,
    String? birthday,
    bool? isOnboardingCompleted,
    GeneralSettingsModel? generalSettings,
  }) {
    return UserModel(
      isAnonymous: isAnonymous ?? this.isAnonymous,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthday: birthday ?? this.birthday,
      // isOnboardingCompleted:
      //     isOnboardingCompleted ?? this.isOnboardingCompleted,
      generalSettings: generalSettings ?? this.generalSettings,
    );
  }
}
