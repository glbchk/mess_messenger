import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/auth/providers/auth_provider.dart';

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

  Future<void> signUp(String email, String password) async {
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
      await ref.read(signUpUseCaseProvider).execute(email, password);
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
    final emailError = _validateEmail(email);
    final passwordError = _validatePassword(password);

    if (emailError != null || passwordError != null) {
      state = AuthUnauthenticated(
        emailError: emailError,
        passwordError: passwordError,
      );
      return;
    }

    final rememberMe = (state is AuthUnauthenticated)
        ? (state as AuthUnauthenticated).rememberMe
        : true;
    state = AuthLoading();

    try {
      await ref
          .read(signInWithEmailUseCaseProvider)
          .execute(email, password, rememberMe);
      state = AuthAuthenticated();
    } catch (e) {
      state = AuthUnauthenticated(errorMessage: e.toString());
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
    } catch (e) {
      state = AuthUnauthenticated(errorMessage: e.toString());
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    state = AuthLoading();
    try {
      await ref.read(sendPasswordResetUseCaseProvider).execute(email);
      state = AuthUnauthenticated(
        successMessage: 'Check your inbox for a reset link!',
      );
    } catch (e) {
      state = AuthUnauthenticated(errorMessage: e.toString());
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
