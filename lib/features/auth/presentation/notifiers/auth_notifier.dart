import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/errors/auth_failure.dart';
import 'package:mess_messenger_app/core/providers/data_providers/global_providers.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/domain/auth_validators.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/theme/providers/theme_provider.dart';

class AuthNotifier extends Notifier<AuthState> {
  // String? _validateEmail(String value) {
  //   if (value.isEmpty) return 'Email required';
  //   if (!value.contains('@') || !value.contains('.')) return 'Invalid email';
  //   return null;
  // }
  //
  // String? _validatePassword(String value) {
  //   if (value.isEmpty) return 'Password required';
  //   if (value.length < 6) return 'Password must be at least 6 characters';
  //   return null;
  // }

  @override
  AuthState build() {
    _checkAuthStatus();
    return AuthUnauthenticated(isRegisterMode: true);
  }

  void toggleThemeMode() {
    final currentMode = ref.read(appThemeProvider);
    final nextMode = currentMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    ref.read(appThemeProvider.notifier).setTheme(nextMode);
  }

  void toggleLanguage() {
    final currentLocale = ref.read(appLanguageProvider);
    final nextLocale = currentLocale.languageCode == 'en'
        ? const Locale('uk')
        : const Locale('en');

    ref.read(appLanguageProvider.notifier).changeLanguage(nextLocale);
  }

  void toggleAuthMode() {
    final currentlyRegistering = state is AuthUnauthenticated
        ? (state as AuthUnauthenticated).isRegisterMode
        : true;

    state = AuthUnauthenticated(isRegisterMode: !currentlyRegistering);
  }

  Future<void> _checkAuthStatus() async {
    try {
      final isLoggedIn = await ref.read(isLoggedInUseCaseProvider).execute();
      if (isLoggedIn) {
        state = AuthAuthenticated();
      } else {
        final s = state;
        state = s is AuthUnauthenticated
            ? s
            : AuthUnauthenticated(isRegisterMode: true);
      }
    } on FirebaseAuthException catch (e) {
      state = AuthUnauthenticated(failure: mapFirebaseAuthException(e));
    } catch (e) {
      state = AuthUnauthenticated(failure: UnknownAuthFailure(e.toString()));
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    final emailError = AuthValidators.email(email);
    final passwordError = AuthValidators.password(password);

    if (emailError != null || passwordError != null) {
      state = AuthUnauthenticated(
        emailError: emailError,
        passwordError: passwordError,
      );
      return;
    }

    state = AuthLoading();

    try {
      await ref.read(signUpUseCaseProvider).execute(email, password, name);
      state = AuthAuthenticated();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        state = AuthUnauthenticated(
          needsGoogleLinkConfirmation: true,
          pendingLinkEmail: email,
          pendingLinkPassword: password,
          failure: const EmailAlreadyInUseFailure(),
        );
      } else {
        state = AuthUnauthenticated(failure: mapFirebaseAuthException(e));
      }
    } catch (e) {
      state = AuthUnauthenticated(failure: UnknownAuthFailure(e.toString()));
    }
  }

  Future<void> confirmGoogleLinkAndSignIn() async {
    final s = state;
    if (s is! AuthUnauthenticated || !s.needsGoogleLinkConfirmation) return;

    final email = s.pendingLinkEmail!;
    final password = s.pendingLinkPassword!;

    state = AuthLoading();

    try {
      await ref.read(signInWithGoogleUseCaseProvider).execute();
      await ref.read(linkEmailPasswordUseCaseProvider).execute(email, password);

      state = AuthAuthenticated();
    } catch (e) {
      state = AuthUnauthenticated(failure: UnknownAuthFailure(e.toString()));
    }
  }

  Future<void> signInWithEmail(
    String email,
    String password,
    bool rememberMe,
  ) async {
    final currentState = state is AuthUnauthenticated
        ? state as AuthUnauthenticated
        : AuthUnauthenticated();

    final emailError = AuthValidators.email(email);
    final passwordError = AuthValidators.password(password);

    if (emailError != null || passwordError != null) {
      state = currentState.copyWith(
        emailError: () => emailError,
        passwordError: () => passwordError,
      );
      return;
    }

    final hadPendingGoogleLink = currentState.needsPasswordLinkConfirmation;

    state = AuthLoading(isRegisterMode: currentState.isRegisterMode);

    try {
      await ref
          .read(signInWithEmailUseCaseProvider)
          .execute(email, password, rememberMe);

      if (hadPendingGoogleLink) {
        await ref.read(linkGoogleAccountUseCaseProvider).execute();
      }

      state = AuthAuthenticated();
    } on FirebaseAuthException catch (e) {
      state = currentState.copyWith(failure: () => mapFirebaseAuthException(e));
    } catch (e) {
      state = currentState.copyWith(
        failure: () => UnknownAuthFailure(e.toString()),
      );
    }
  }

  void toggleRememberMe() {
    final s = state;
    if (s is AuthUnauthenticated) {
      state = s.copyWith(rememberMe: !s.rememberMe);
    }
  }

  Future<void> signInWithGoogle() async {
    state = AuthLoading();

    try {
      await ref.read(signInWithGoogleUseCaseProvider).execute();
      state = AuthAuthenticated();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        state = AuthUnauthenticated(
          needsPasswordLinkConfirmation: true,
          failure: const AccountExistsWithDifferentCredentialFailure(),
        );
      } else {
        state = AuthUnauthenticated(failure: mapFirebaseAuthException(e));
      }
    } catch (e) {
      state = AuthUnauthenticated(failure: UnknownAuthFailure(e.toString()));
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    if (email.isEmpty) {
      state = AuthUnauthenticated(failure: const InvalidEmailFailure());
      return;
    }

    try {
      await ref.read(sendPasswordResetUseCaseProvider).execute(email);
      state = AuthUnauthenticated(
        successMessage: 'Password reset link sent to $email',
      );
    } on FirebaseAuthException catch (e) {
      final failure = e.code == 'user-not-found'
          ? const AccountNotFoundFailure()
          : mapFirebaseAuthException(e);
      state = AuthUnauthenticated(failure: failure);
    }
  }

  Future<void> updatePassword(
    String newPassword,
    String currentPassword,
  ) async {
    final s = state;
    if (s is! AuthAuthenticated) return;

    state = s.copyWith(
      isUpdatingPassword: true,
      passwordUpdateError: () => null,
    );

    try {
      await ref
          .read(updatePasswordUseCaseProvider)
          .execute(newPassword: newPassword, currentPassword: currentPassword);

      state = (state as AuthAuthenticated).copyWith(
        isUpdatingPassword: false,
        passwordUpdateSuccess: true,
      );
    } on AuthFailure catch (e) {
      state = (state as AuthAuthenticated).copyWith(
        isUpdatingPassword: false,
        passwordUpdateError: () => e,
      );
    }
  }

  void clearSuccessMessage() {
    final s = state;
    if (s is AuthUnauthenticated) {
      state = s.copyWith(successMessage: () => null);
    }
  }

  void clearErrorMessage() {
    final s = state;
    if (s is AuthUnauthenticated) {
      state = s.copyWith(failure: () => null);
    }
  }

  Future<void> logout() async {
    try {
      await ref.read(logoutUseCaseProvider).execute();
      state = AuthUnauthenticated();
    } on FirebaseAuthException catch (e) {
      state = AuthUnauthenticated(failure: mapFirebaseAuthException(e));
    } catch (e) {
      state = AuthUnauthenticated(failure: UnknownAuthFailure(e.toString()));
    }
  }

  Future<void> logoutFromAllDevices() async {
    try {
      await ref.read(logoutFromAllDevicesUseCaseProvider).execute();
      state = AuthUnauthenticated();
    } on FirebaseAuthException catch (e) {
      state = AuthUnauthenticated(failure: mapFirebaseAuthException(e));
    } catch (e) {
      state = AuthUnauthenticated(failure: UnknownAuthFailure(e.toString()));
    }
  }
}
