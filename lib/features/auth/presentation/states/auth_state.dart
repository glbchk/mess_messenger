abstract class AuthState {}

// class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {
  final bool isRegisterMode;
  final bool rememberMe;
  final String? emailError;
  final String? passwordError;
  final String? errorMessage;
  final String? successMessage;
  final bool isPasswordVisible;
  final bool needsGoogleLinkConfirmation;
  final String? pendingLinkEmail;
  final String? pendingLinkPassword;
  final bool needsPasswordLinkConfirmation;

  AuthUnauthenticated({
    this.isRegisterMode = true,
    this.rememberMe = true,
    this.emailError,
    this.passwordError,
    this.errorMessage,
    this.successMessage,
    this.isPasswordVisible = false,
    this.needsGoogleLinkConfirmation = false,
    this.pendingLinkEmail,
    this.pendingLinkPassword,
    this.needsPasswordLinkConfirmation = false,
  });

  AuthUnauthenticated copyWith({
    bool? isRegisterMode,
    bool? rememberMe,
    String? Function()? emailError,
    String? Function()? passwordError,
    String? Function()? errorMessage,
    String? Function()? successMessage,
    bool? isPasswordVisible,
    bool? needsGoogleLinkConfirmation,
    String? pendingLinkEmail,
    String? pendingLinkPassword,
    bool? needsPasswordLinkConfirmation,
  }) {
    return AuthUnauthenticated(
      isRegisterMode: isRegisterMode ?? this.isRegisterMode,
      rememberMe: rememberMe ?? this.rememberMe,
      emailError: emailError != null ? emailError() : this.emailError,
      passwordError: passwordError != null
          ? passwordError()
          : this.passwordError,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      successMessage: successMessage != null
          ? successMessage()
          : this.successMessage,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      needsGoogleLinkConfirmation:
          needsGoogleLinkConfirmation ?? this.needsGoogleLinkConfirmation,
      pendingLinkEmail: pendingLinkEmail ?? this.pendingLinkEmail,
      pendingLinkPassword: pendingLinkPassword ?? this.pendingLinkPassword,
      needsPasswordLinkConfirmation:
          needsPasswordLinkConfirmation ?? this.needsPasswordLinkConfirmation,
    );
  }
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
