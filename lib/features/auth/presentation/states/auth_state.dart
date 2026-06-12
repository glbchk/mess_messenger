abstract class AuthState {}

// class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {
  final bool isRegisterMode;
  final String? emailError;
  final String? passwordError;
  final String? errorMessage;
  final bool isPasswordVisible;

  AuthUnauthenticated({
    this.isRegisterMode = true,
    this.emailError,
    this.passwordError,
    this.errorMessage,
    this.isPasswordVisible = false,
  });

  AuthUnauthenticated copyWith({
    bool? isRegisterMode,
    String? Function()? emailError,
    String? Function()? passwordError,
    String? Function()? errorMessage,
    bool? isPasswordVisible,
  }) {
    return AuthUnauthenticated(
      isRegisterMode: isRegisterMode ?? this.isRegisterMode,
      emailError: emailError != null ? emailError() : this.emailError,
      passwordError: passwordError != null
          ? passwordError()
          : this.passwordError,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
