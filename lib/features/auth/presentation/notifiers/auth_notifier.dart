import 'package:flutter_riverpod/legacy.dart';
import 'package:mess_messenger_app/features/auth/domain/usecases/auth_use_cases.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUserUseCase _loginUserUseCase;
  final LogoutUserUseCase _logoutUserUseCase;
  final IsLoggedInUserUseCase _isLoggedInUserUseCase;

  AuthNotifier({
    required LoginUserUseCase loginUserUseCase,
    required LogoutUserUseCase logoutUserUseCase,
    required IsLoggedInUserUseCase isLoggedInUserUseCase,
  }) : _loginUserUseCase = loginUserUseCase,
       _logoutUserUseCase = logoutUserUseCase,
       _isLoggedInUserUseCase = isLoggedInUserUseCase,
       super(AuthInitial()) {
    checkAuthStatus();
  }

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

  Future<void> checkAuthStatus() async {
    try {
      final isLoggedIn = await _isLoggedInUserUseCase.execute();
      state = isLoggedIn ? AuthAuthenticated() : AuthUnauthenticated();
    } catch (e) {
      state = AuthError(e.toString());
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
      await _loginUserUseCase.execute(email, password);
      state = AuthAuthenticated();
    } catch (e) {
      state = AuthUnauthenticated(errorMessage: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _logoutUserUseCase.execute();
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
