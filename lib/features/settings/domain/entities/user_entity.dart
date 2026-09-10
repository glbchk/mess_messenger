import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/features/settings/data/models/general_settings_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/notification_settings_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/personalization_settings_model.dart';

class UserEntity {
  final bool? isAnonymous;
  final String id;
  final String? name;
  final String? email;
  final bool? isEmailVerified;
  final String? pendingEmail;
  final String? phoneNumber;
  final String? birthday;
  final String? avatarUrl;
  final bool isOnboardingCompleted;
  final String? language;
  final GeneralSettingsModel? generalSettings;
  final PersonalizationSettingsModel? personalizationSettings;
  final SubscriptionPlan? subscriptionPlan;
  final NotificationSettingsModel? notificationSettings;
  final bool isOnline;
  final DateTime? lastActiveAt;

  UserEntity({
    this.isAnonymous,
    required this.id,
    this.name,
    this.email,
    this.isEmailVerified,
    this.pendingEmail,
    this.phoneNumber,
    this.birthday,
    this.avatarUrl,
    required this.isOnboardingCompleted,
    this.language,
    this.generalSettings,
    this.personalizationSettings,
    this.subscriptionPlan,
    this.notificationSettings,
    this.isOnline = false,
    this.lastActiveAt,
  });
}
