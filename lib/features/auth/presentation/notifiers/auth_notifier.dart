import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/errors/auth_failure.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';

class AuthNotifier extends Notifier<AuthState> {
  String? _validateEmail(String value) {
    if (value.isEmpty) return 'Email required';
    if (!value.contains('@') || !value.contains('.')) return 'Invalid email';
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) return 'Password required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  @override
  AuthState build() {
    _checkAuthStatus();
    return AuthUnauthenticated(isRegisterMode: true);
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
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    final emailError = _validateEmail(email);
    final passwordError = _validatePassword(password);

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
          errorMessage:
              'An account with this email already exists via Google. Sign in with Google to link it.',
        );
      } else {
        state = AuthUnauthenticated(errorMessage: e.toString());
      }
    } catch (e) {
      state = AuthUnauthenticated(errorMessage: e.toString());
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
      state = AuthUnauthenticated(errorMessage: e.toString());
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

    final emailError = _validateEmail(email);
    final passwordError = _validatePassword(password);

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
    } catch (e) {
      state = currentState.copyWith(errorMessage: () => e.toString());
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
          errorMessage:
              'An account with this email already exists. Sign in with your password to link Google.',
        );
      } else {
        state = AuthUnauthenticated(errorMessage: e.toString());
      }
    } catch (e) {
      state = AuthUnauthenticated(errorMessage: e.toString());
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    if (email.isEmpty) {
      state = AuthUnauthenticated(
        errorMessage: 'Enter your email first' /* other required fields */,
      );
      return;
    }

    try {
      await ref.read(sendPasswordResetUseCaseProvider).execute(email);
      state = AuthUnauthenticated(
        successMessage: 'Password reset link sent to $email',
        /* preserve other AuthUnauthenticated fields like isRegisterMode, rememberMe */
      );
    } on FirebaseAuthException catch (e) {
      final message = switch (e.code) {
        'user-not-found' => 'No account found with that email',
        'invalid-email' => 'Enter a valid email address',
        _ => 'Something went wrong. Try again.',
      };
      state = AuthUnauthenticated(errorMessage: message /* other fields */);
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

  Future<void> logout() async {
    try {
      await ref.read(logoutUseCaseProvider).execute();
      state = AuthUnauthenticated();
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  void clearErrorMessage() {
    final s = state;
    if (s is AuthUnauthenticated) {
      state = s.copyWith(errorMessage: () => null);
    }
  }
}
