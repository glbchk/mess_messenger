import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/features/settings/data/models/notification_settings_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSource(this.firestore);

  Future<void> createUser(UserModel user) async {
    await firestore.collection('users').doc(user.id).set(user.toJson());
  }

  Future<UserModel?> fetchUserData(String uid) async {
    final doc = await firestore.collection("users").doc(uid).get();

    if (doc.exists && doc.data() != null) {
      final userModel = UserModel.fromJson(doc.data()!);

      print("DEBUG: Firestore Data: ${doc.data()}");

      return userModel;
    }

    return null;
  }

  Future<void> updateAvatar(String userId, String? avatarUrl) async {
    await firestore.collection('users').doc(userId).update({
      'avatar_url': avatarUrl,
    });
  }

  Future<void> updateIsLoggedIn(String userId, bool isLoggedIn) async {
    await firestore.collection('users').doc(userId).update({
      'general_settings.is_logged_in': isLoggedIn,
    });
  }

  Future<void> updateLanguage(String userId, String? language) async {
    await firestore.collection('users').doc(userId).update({
      'general_settings.language': language,
    });
  }

  Future<void> updateIsPhotoPasswordProtected(
    String userId,
    bool isProtected,
  ) async {
    await firestore.collection('users').doc(userId).update({
      'general_settings.is_photo_password_protected': isProtected,
    });
  }

  Future<void> updateIsAudioPasswordProtected(
    String userId,
    bool isProtected,
  ) async {
    await firestore.collection('users').doc(userId).update({
      'general_settings.is_audio_password_protected': isProtected,
    });
  }

  Future<void> updateIsVideoPasswordProtected(
    String userId,
    bool isProtected,
  ) async {
    await firestore.collection('users').doc(userId).update({
      'general_settings.is_video_password_protected': isProtected,
    });
  }

  Future<void> updateIsDocumentPasswordProtected(
    String userId,
    bool isProtected,
  ) async {
    await firestore.collection('users').doc(userId).update({
      'general_settings.is_document_password_protected': isProtected,
    });
  }

  Future<void> updateUserName(String userId, String newName) async {
    await firestore.collection('users').doc(userId).update({'name': newName});
  }

  Future<void> updateUserBirthday(String userId, String newBirthday) async {
    await firestore.collection('users').doc(userId).update({
      'birthday': newBirthday,
    });
  }

  Future<void> updateUserEmail(
    String userId,
    String newEmail, {
    bool isEmailVerified = false,
  }) async {
    await firestore.collection('users').doc(userId).update({
      'email': newEmail,
      'is_email_verified': isEmailVerified,
    });
  }

  Future<void> updateUserPhoneNumber(
    String userId,
    String newPhoneNumber,
  ) async {
    await firestore.collection('users').doc(userId).update({
      'phone_number': newPhoneNumber,
    });
  }

  Future<void> setPendingEmail(String userId, String? pendingEmail) async {
    await firestore.collection('users').doc(userId).update({
      'pending_email': pendingEmail,
    });
  }

  Future<void> confirmPendingEmail(String userId, String confirmedEmail) async {
    await firestore.collection('users').doc(userId).update({
      'email': confirmedEmail,
      'is_email_verified': true,
      'pending_email': '',
    });
  }

  Future<void> updateThemeMode(String userId, String selectedTheme) async {
    await firestore.collection('users').doc(userId).update({
      'personalization_settings.theme_mode': selectedTheme,
    });
  }

  Future<void> updateBackgroundColor(
    String userId,
    String? backgroundColorId,
  ) async {
    await firestore.collection('users').doc(userId).update({
      'personalization_settings.background_color_id': backgroundColorId,
    });
  }

  //TODO: Add method on Text Size

  Future<void> updateSubscriptionPlan(
    String userId,
    SubscriptionPlan selectedPlan,
  ) async {
    await firestore.collection('users').doc(userId).update({
      'subscription_plan': selectedPlan.name,
    });
  }

  Future<void> updateNotificationSettings(
    String userId,
    NotificationSettingsModel settings,
  ) async {
    await firestore.collection('users').doc(userId).update({
      'notification_settings': settings.toJson(),
    });
  }
}
