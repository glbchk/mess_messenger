import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/features/settings/data/models/general_settings_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/notification_settings_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/personalization_settings_model.dart';
import 'package:mess_messenger_app/features/settings/domain/entities/user_entity.dart';

class UserModel {
  final bool? isAnonymous;
  final String id;
  final String? name;
  final String? email;
  final bool? isEmailVerified;
  final String? pendingEmail;
  final String? phoneNumber;
  final String? birthday;
  final String? avatarUrl;
  // final bool isOnboardingCompleted;
  final GeneralSettingsModel? generalSettings;
  final PersonalizationSettingsModel? personalizationSettings;
  final SubscriptionPlan? subscriptionPlan;
  final NotificationSettingsModel? notificationSettings;

  UserModel({
    this.isAnonymous,
    required this.id,
    this.name,
    this.email,
    this.isEmailVerified,
    this.pendingEmail,
    this.phoneNumber,
    this.birthday,
    this.avatarUrl,
    // required this.isOnboardingCompleted,
    this.generalSettings,
    this.personalizationSettings,
    this.subscriptionPlan,
    this.notificationSettings,
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
      pendingEmail: '',
      name: name,
      phoneNumber: '',
      birthday: '',
      avatarUrl: '',
      generalSettings: GeneralSettingsModel.defaults(),
      personalizationSettings: PersonalizationSettingsModel.defaults(),
      subscriptionPlan: SubscriptionPlan.free,
      notificationSettings: NotificationSettingsModel.defaults(),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      isAnonymous: json['is_anonymous'] ?? false,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      isEmailVerified: json['is_email_verified'] ?? false,
      pendingEmail: json['pending_email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      birthday: json['birthday'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      // isOnboardingCompleted: json['is_onboarding_completed'],
      generalSettings: json['general_settings'] != null
          ? GeneralSettingsModel.fromJson(json['general_settings'])
          : null,
      personalizationSettings: json['personalization_settings'] != null
          ? PersonalizationSettingsModel.fromJson(
              json['personalization_settings'],
            )
          : null,
      subscriptionPlan: () {
        final raw = json['subscription_plan'] as String?;
        if (raw == null) return SubscriptionPlan.free;
        return SubscriptionPlan.values.firstWhere(
          (e) => e.name == raw || e.toString() == raw,
          orElse: () => SubscriptionPlan.free,
        );
      }(),
      notificationSettings: json['notification_settings'] != null
          ? NotificationSettingsModel.fromJson(json['notification_settings'])
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
      'pending_email': pendingEmail,
      'phone_number': phoneNumber,
      'birthday': birthday,
      'avatar_url': avatarUrl,
      // 'is_onboarding_completed': isOnboardingCompleted,
      'general_settings': generalSettings?.toJson(),
      'personalization_settings': personalizationSettings?.toJson(),
      'subscription_plan': subscriptionPlan?.name,
      'notification_settings': notificationSettings?.toJson(),
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      isAnonymous: entity.isAnonymous ?? false,
      id: entity.id,
      name: entity.name ?? '',
      email: entity.email,
      isEmailVerified: entity.isEmailVerified ?? false,
      pendingEmail: entity.pendingEmail ?? '',
      phoneNumber: entity.phoneNumber ?? '',
      birthday: entity.birthday ?? '',
      avatarUrl: entity.avatarUrl ?? '',
      // isOnboardingCompleted: entity.isOnboardingCompleted,
      generalSettings: entity.generalSettings,
      personalizationSettings: entity.personalizationSettings,
      subscriptionPlan: entity.subscriptionPlan,
      notificationSettings: entity.notificationSettings,
    );
  }

  UserModel copyUserWith({
    bool? isAnonymous,
    String? id,
    String? name,
    String? email,
    bool? isEmailVerified,
    String? pendingEmail,
    String? phoneNumber,
    String? birthday,
    String? avatarUrl,
    bool? isOnboardingCompleted,
    GeneralSettingsModel? generalSettings,
    PersonalizationSettingsModel? personalizationSettings,
    SubscriptionPlan? subscriptionPlan,
    NotificationSettingsModel? notificationSettings,
  }) {
    return UserModel(
      isAnonymous: isAnonymous ?? this.isAnonymous,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      pendingEmail: pendingEmail ?? this.pendingEmail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthday: birthday ?? this.birthday,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      // isOnboardingCompleted:
      //     isOnboardingCompleted ?? this.isOnboardingCompleted,
      generalSettings: generalSettings ?? this.generalSettings,
      personalizationSettings:
          personalizationSettings ?? this.personalizationSettings,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      notificationSettings: notificationSettings ?? this.notificationSettings,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.isAnonymous == isAnonymous &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.isEmailVerified == isEmailVerified &&
        other.pendingEmail == pendingEmail &&
        other.phoneNumber == phoneNumber &&
        other.birthday == birthday &&
        other.avatarUrl == avatarUrl &&
        other.generalSettings == generalSettings &&
        other.personalizationSettings == personalizationSettings &&
        other.subscriptionPlan == subscriptionPlan &&
        other.notificationSettings == notificationSettings;
  }

  @override
  int get hashCode => Object.hash(
    isAnonymous,
    id,
    name,
    email,
    isEmailVerified,
    pendingEmail,
    phoneNumber,
    birthday,
    avatarUrl,
    generalSettings,
    personalizationSettings,
    subscriptionPlan,
    notificationSettings,
  );
}
