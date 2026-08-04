import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/settings/data/models/general_settings_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/states/user_state.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:mess_messenger_app/providers/firebase_provider.dart';
import 'package:mess_messenger_app/providers/global_providers.dart';

class UserNotifier extends Notifier<UserState> {
  @override
  UserState build() {
    Future.microtask(() => fetchUserData());
    return const UserState();
  }

  Future<void> fetchUserData() async {
    final uid = ref.read(firebaseAuthProvider).currentUser?.uid;
    if (uid == null) return;

    state = state.copyWith(isLoading: true);
    try {
      final userData = await ref
          .read(fetchUserDataUseCaseProvider)
          .execute(uid);
      state = state.copyWith(userData: userData, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: () => e.toString());
    }
  }

  Future<void> updateGeneralSettingToggle(
    String userId, {
    bool? isLoggedIn,
    bool? isPhotoPasswordProtected,
    bool? isAudioPasswordProtected,
    bool? isVideoPasswordProtected,
    bool? isDocumentPasswordProtected,
  }) async {
    final previousUser = state.userData;
    if (previousUser == null) return;

    final updatedSettings =
        (previousUser.generalSettings ?? GeneralSettingsModel.defaults())
            .copyUserWith(
              isLoggedIn: isLoggedIn,
              isPhotoPasswordProtected: isPhotoPasswordProtected,
              isAudioPasswordProtected: isAudioPasswordProtected,
              isVideoPasswordProtected: isVideoPasswordProtected,
              isDocumentPasswordProtected: isDocumentPasswordProtected,
            );

    state = state.copyWith(
      userData: previousUser.copyUserWith(generalSettings: updatedSettings),
    );

    try {
      final useCase = ref.read(updateGeneralSettingsUseCaseProvider);
      await useCase.execute(userId, updatedSettings);
    } catch (e) {
      state = state.copyWith(userData: previousUser);
      rethrow;
    }
  }

  Future<void> dropdownSelectLanguage(String userId, String? localeCode) async {
    if (localeCode != null) {
      await ref
          .read(appLanguageProvider.notifier)
          .changeLanguage(Locale(localeCode));
    } else {
      await ref.read(appLanguageProvider.notifier).resetToSystemDefault();
    }

    await updateApplicationLanguage(userId, localeCode);
  }

  Future<void> saveGeneralSettings(
    String userId,
    GeneralSettingsModel newSettings,
  ) async {
    final previousUser = state.userData;
    if (previousUser == null) return;

    state = state.copyWith(
      userData: previousUser.copyUserWith(generalSettings: newSettings),
    );

    if (newSettings.language != null) {
      await ref
          .read(appLanguageProvider.notifier)
          .changeLanguage(Locale(newSettings.language!));
    } else {
      await ref.read(appLanguageProvider.notifier).resetToSystemDefault();
    }

    try {
      final useCase = ref.read(updateGeneralSettingsUseCaseProvider);
      await useCase.execute(userId, newSettings);
    } catch (e) {
      state = state.copyWith(userData: previousUser);
      rethrow;
    }
  }

  Future<void> updateApplicationLanguage(
    String userId,
    String? selectedLanguage,
  ) async {
    final previousUser = state.userData;
    if (previousUser == null) return;

    final updatedSettings =
        (previousUser.generalSettings ?? GeneralSettingsModel.defaults())
            .copyUserWith(language: () => selectedLanguage);

    // Optimistic update
    state = state.copyWith(
      userData: previousUser.copyUserWith(generalSettings: updatedSettings),
    );

    try {
      final useCase = ref.read(updateApplicationLanguageUseCaseProvider);
      await useCase.execute(userId, selectedLanguage);
    } catch (e) {
      // Roll back on failure
      state = state.copyWith(userData: previousUser);
      rethrow; // let the UI show an error if it wants to
    }
  }

  Future<void> updateUserName(String userId, String newName) async {
    final previousUser = state.userData;
    if (previousUser == null) return;

    // Optimistic update
    state = state.copyWith(userData: previousUser.copyUserWith(name: newName));

    try {
      final useCase = ref.read(updateUserNameUseCaseProvider);
      await useCase.execute(userId, newName);
    } catch (e) {
      // Roll back on failure
      state = state.copyWith(userData: previousUser);
      rethrow; // let the UI show an error if it wants to
    }
  }

  Future<void> updateUserBirthday(String userId, String newBirthday) async {
    final previousUser = state.userData;
    if (previousUser == null) return;

    // Optimistic update
    state = state.copyWith(
      userData: previousUser.copyUserWith(birthday: newBirthday),
    );

    try {
      final useCase = ref.read(updateUserBirthdayUseCaseProvider);
      await useCase.execute(userId, newBirthday);
    } catch (e) {
      // Roll back on failure
      state = state.copyWith(userData: previousUser);
      rethrow; // let the UI show an error if it wants to
    }
  }

  Future<void> updateUserEmail(
    String newEmail, {
    String? currentPassword,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final useCase = ref.read(updateUserEmailUseCaseProvider);
      await useCase.execute(newEmail, currentPassword: currentPassword);
      state = state.copyWith(
        isLoading: false,
        pendingEmailVerification: () => newEmail,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: () => e.toString());
      rethrow;
    }
  }
}
