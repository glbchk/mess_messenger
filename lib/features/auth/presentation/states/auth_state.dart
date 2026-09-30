import 'package:mess_messenger_app/core/errors/auth_failure.dart';

abstract class AuthState {}

class AuthLoading extends AuthState {
  final bool isRegisterMode;
  AuthLoading({this.isRegisterMode = true});
}

class AuthAuthenticated extends AuthState {
  final bool isUpdatingPassword;
  final AuthFailure? passwordUpdateError;
  final bool passwordUpdateSuccess;

  AuthAuthenticated({
    this.isUpdatingPassword = false,
    this.passwordUpdateError,
    this.passwordUpdateSuccess = false,
  });

  AuthAuthenticated copyWith({
    bool? isUpdatingPassword,
    AuthFailure? Function()? passwordUpdateError,
    bool? passwordUpdateSuccess,
  }) {
    return AuthAuthenticated(
      isUpdatingPassword: isUpdatingPassword ?? this.isUpdatingPassword,
      passwordUpdateError: passwordUpdateError != null
          ? passwordUpdateError()
          : this.passwordUpdateError,
      passwordUpdateSuccess:
          passwordUpdateSuccess ?? this.passwordUpdateSuccess,
    );
  }
}

class AuthUnauthenticated extends AuthState {
  final bool isRegisterMode;
  final bool rememberMe;
  final String? emailError;
  final String? passwordError;
  final AuthFailure? failure;
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
    this.failure,
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
    AuthFailure? Function()? failure,
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
      failure: failure != null ? failure() : this.failure,
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

extension AuthStateX on AuthState {
  bool get isRegisterMode => switch (this) {
    AuthUnauthenticated(:final isRegisterMode) => isRegisterMode,
    AuthLoading(:final isRegisterMode) => isRegisterMode,
    _ => true,
  };
}
