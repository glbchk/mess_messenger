import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/core/errors/auth_failure.dart';
import 'package:mess_messenger_app/core/providers/cloudinary_provider.dart';
import 'package:mess_messenger_app/core/providers/firebase_provider.dart';
import 'package:mess_messenger_app/core/providers/global_providers.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/settings/data/models/general_settings_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/personalization_settings_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/states/user_state.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/providers/theme_provider.dart';

class UserNotifier extends Notifier<UserState> {
  @override
  UserState build() {
    ref.listen(firebaseAuthStateChangesProvider, (previous, next) {
      print('DEBUG: authStateChanges listener fired, next=$next');
      final user = next.whenOrNull(data: (user) => user);
      if (user != null) {
        fetchUserData();
      } else {
        state = const UserState();
      }
    }, fireImmediately: true);

    return const UserState();
  }

  Future<void> fetchUserData() async {
    print('DEBUG: fetchUserData() called');
    final uid = ref.read(firebaseAuthProvider).currentUser?.uid;
    if (uid == null) return;

    state = state.copyWith(isLoading: true);
    try {
      final userData = await ref
          .read(fetchUserDataUseCaseProvider)
          .execute(uid);
      state = state.copyWith(userData: userData, isLoading: false);

      if (userData?.pendingEmail?.isNotEmpty ?? false) {
        await checkEmailVerificationStatus();
      }
    } catch (e) {
      print('DEBUG: fetchUserData FAILED: $e');
      state = state.copyWith(isLoading: false, error: () => e.toString());
    }
  }

  Future<void> updateAvatar(XFile imageFile) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final previousUser = state.userData;
    if (previousUser == null) return;

    try {
      final bytes = await imageFile.readAsBytes();
      final cloudinaryService = ref.read(cloudinaryServiceProvider);
      final downloadUrl = await cloudinaryService.uploadImage(
        bytes,
        publicId: 'avatars/$userId-${DateTime.now().millisecondsSinceEpoch}',
        filename: imageFile.name,
      );

      state = state.copyWith(
        userData: previousUser.copyUserWith(avatarUrl: downloadUrl),
      );

      final useCase = ref.read(updateAvatarUseCaseProvider);
      await useCase.execute(userId, downloadUrl);
    } catch (e) {
      // Roll back on failure
      state = state.copyWith(userData: previousUser);
      rethrow; // let the UI show an error if it wants to
    }
  }

  Future<void> updateIsLoggedIn(bool isLoggedIn) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final previousUser = state.userData;
    if (previousUser == null) return;

    final currentSettings =
        previousUser.generalSettings ?? GeneralSettingsModel.defaults();
    final newSettings = currentSettings.copyUserWith(isLoggedIn: isLoggedIn);

    state = state.copyWith(
      userData: previousUser.copyUserWith(generalSettings: newSettings),
    );

    try {
      final useCase = ref.read(updateIsLoggedInUseCaseProvider);
      await useCase.execute(userId, isLoggedIn);
    } catch (e) {
      state = state.copyWith(userData: previousUser);
      rethrow;
    }
  }

  Future<void> updateLanguage(String? language) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final previousUser = state.userData;
    if (previousUser == null) return;

    final currentSettings =
        previousUser.generalSettings ?? GeneralSettingsModel.defaults();
    final newSettings = currentSettings.copyUserWith(language: () => language);

    state = state.copyWith(
      userData: previousUser.copyUserWith(generalSettings: newSettings),
    );

    if (language != currentSettings.language) {
      if (language != null) {
        await ref
            .read(appLanguageProvider.notifier)
            .changeLanguage(Locale(language));
      } else {
        await ref.read(appLanguageProvider.notifier).resetToSystemDefault();
      }
    }

    try {
      final useCase = ref.read(updateLanguageUseCaseProvider);
      await useCase.execute(userId, language);
    } catch (e) {
      state = state.copyWith(userData: previousUser);
      rethrow;
    }
  }

  Future<void> updateIsPhotoPasswordProtected(bool isProtected) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final previousUser = state.userData;
    if (previousUser == null) return;

    final currentSettings =
        previousUser.generalSettings ?? GeneralSettingsModel.defaults();
    final newSettings = currentSettings.copyUserWith(
      isPhotoPasswordProtected: isProtected,
    );

    state = state.copyWith(
      userData: previousUser.copyUserWith(generalSettings: newSettings),
    );

    try {
      final useCase = ref.read(updateIsPhotoPasswordProtectedUseCaseProvider);
      await useCase.execute(userId, isProtected);
    } catch (e) {
      state = state.copyWith(userData: previousUser);
      rethrow;
    }
  }

  Future<void> updateIsAudioPasswordProtected(bool isProtected) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final previousUser = state.userData;
    if (previousUser == null) return;

    final currentSettings =
        previousUser.generalSettings ?? GeneralSettingsModel.defaults();
    final newSettings = currentSettings.copyUserWith(
      isAudioPasswordProtected: isProtected,
    );

    state = state.copyWith(
      userData: previousUser.copyUserWith(generalSettings: newSettings),
    );

    try {
      final useCase = ref.read(updateIsAudioPasswordProtectedUseCaseProvider);
      await useCase.execute(userId, isProtected);
    } catch (e) {
      state = state.copyWith(userData: previousUser);
      rethrow;
    }
  }

  Future<void> updateIsVideoPasswordProtected(bool isProtected) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final previousUser = state.userData;
    if (previousUser == null) return;

    final currentSettings =
        previousUser.generalSettings ?? GeneralSettingsModel.defaults();
    final newSettings = currentSettings.copyUserWith(
      isVideoPasswordProtected: isProtected,
    );

    state = state.copyWith(
      userData: previousUser.copyUserWith(generalSettings: newSettings),
    );

    try {
      final useCase = ref.read(updateIsVideoPasswordProtectedUseCaseProvider);
      await useCase.execute(userId, isProtected);
    } catch (e) {
      state = state.copyWith(userData: previousUser);
      rethrow;
    }
  }

  Future<void> updateIsDocumentPasswordProtected(bool isProtected) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final previousUser = state.userData;
    if (previousUser == null) return;

    final currentSettings =
        previousUser.generalSettings ?? GeneralSettingsModel.defaults();
    final newSettings = currentSettings.copyUserWith(
      isDocumentPasswordProtected: isProtected,
    );

    state = state.copyWith(
      userData: previousUser.copyUserWith(generalSettings: newSettings),
    );

    try {
      final useCase = ref.read(
        updateIsDocumentPasswordProtectedUseCaseProvider,
      );
      await useCase.execute(userId, isProtected);
    } catch (e) {
      state = state.copyWith(userData: previousUser);
      rethrow;
    }
  }

  Future<void> updateUserName(String newName) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
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

  Future<void> updateUserBirthday(String newBirthday) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
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

  Future<void> updateUserPhoneNumber(String newPhoneNumber) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final previousUser = state.userData;
    if (previousUser == null) return;

    // Optimistic update
    state = state.copyWith(
      userData: previousUser.copyUserWith(phoneNumber: newPhoneNumber),
    );

    try {
      final useCase = ref.read(updateUserPhoneNumberUseCaseProvider);
      await useCase.execute(userId, newPhoneNumber);
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
    final userId = state.userData?.id;
    if (userId == null) return;

    state = state.copyWith(isLoading: true, error: null);
    try {
      final useCase = ref.read(updateUserEmailUseCaseProvider);
      await useCase.execute(newEmail, currentPassword: currentPassword);

      final userDataSource = ref.read(userRemoteDataSourceProvider);
      await userDataSource.setPendingEmail(userId, newEmail);

      state = state.copyWith(
        isLoading: false,
        userData: state.userData?.copyUserWith(pendingEmail: newEmail),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: () => e.toString());
      rethrow;
    }
  }

  Future<void> checkEmailVerificationStatus() async {
    final userData = state.userData;
    if (userData == null) return;

    final hasPendingEmail = userData.pendingEmail?.isNotEmpty ?? false;
    if (userData.isEmailVerified == true && !hasPendingEmail) return;

    final targetEmail = hasPendingEmail
        ? userData.pendingEmail!
        : userData.email;
    if (targetEmail == null) return;

    final authDataSource = ref.read(authRemoteDataSourceProvider);

    String? currentAuthEmail;
    try {
      currentAuthEmail = await authDataSource.reloadAndGetCurrentEmail();
    } on SessionRevokedFailure {
      ref
          .read(postSignOutMessageProvider.notifier)
          .set(
            'Your email was updated to "$targetEmail". Please sign in again to continue.',
          );
      await authDataSource.logout();
      return;
    }

    if (currentAuthEmail != targetEmail) return; // not confirmed yet

    final userDataSource = ref.read(userRemoteDataSourceProvider);
    await userDataSource.confirmPendingEmail(userData.id, targetEmail);

    state = state.copyWith(
      userData: userData.copyUserWith(
        email: targetEmail,
        isEmailVerified: true,
        pendingEmail: '',
      ),
    );
  }

  Future<void> updateThemeMode(String selectedTheme) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final previousUser = state.userData;
    if (previousUser == null) return;

    final currentSettings =
        previousUser.personalizationSettings ??
        PersonalizationSettingsModel.defaults();
    final newSettings = currentSettings.copyUserWith(themeMode: selectedTheme);

    state = state.copyWith(
      userData: previousUser.copyUserWith(personalizationSettings: newSettings),
    );

    await ref
        .read(appThemeProvider.notifier)
        .setTheme(labelToThemeMode(selectedTheme));

    try {
      final useCase = ref.read(updateThemeModeUseCaseProvider);
      await useCase.execute(userId, selectedTheme);
    } catch (e) {
      // Roll back on failure
      state = state.copyWith(userData: previousUser);
      rethrow; // let the UI show an error if it wants to
    }
  }

  Future<void> updateBackgroundColor(int? backgroundColorIndex) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final previousUser = state.userData;
    if (previousUser == null) return;

    final currentSettings =
        previousUser.personalizationSettings ??
        PersonalizationSettingsModel.defaults();
    final newSettings = currentSettings.copyUserWith(
      backgroundColorIndex: backgroundColorIndex,
    );

    state = state.copyWith(
      userData: previousUser.copyUserWith(personalizationSettings: newSettings),
    );

    try {
      final useCase = ref.read(updateBackgroundColorUseCaseProvider);
      await useCase.execute(userId, backgroundColorIndex);
    } catch (e) {
      // Roll back on failure
      state = state.copyWith(userData: previousUser);
      rethrow; // let the UI show an error if it wants to
    }
  }

  Future<void> updateSubscriptionPlan(SubscriptionPlan selectedPlan) async {
    //TODO: Need to build logic with adding credit card and payment process to make it work right. Need to connect Stripe!
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final previousUser = state.userData;
    if (previousUser == null) return;

    state = state.copyWith(
      userData: previousUser.copyUserWith(subscriptionPlan: selectedPlan),
    );

    try {
      final useCase = ref.read(updateSubscriptionPlanUseCaseProvider);
      await useCase.execute(userId, selectedPlan);
    } catch (e) {
      // Roll back on failure
      state = state.copyWith(userData: previousUser);
      rethrow; // let the UI show an error if it wants to
    }
  }
}
