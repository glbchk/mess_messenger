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
    return AuthInitial();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final isLoggedIn = await ref.read(isLoggedInUseCaseProvider).execute();
      state = isLoggedIn ? AuthAuthenticated() : AuthUnauthenticated();
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

  Future<void> login(String email, String password) async {
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
      await ref.read(loginUseCaseProvider).execute(email, password);
      state = AuthAuthenticated();
    } catch (e) {
      state = AuthUnauthenticated(errorMessage: e.toString());
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
