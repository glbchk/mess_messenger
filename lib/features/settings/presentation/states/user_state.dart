import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class UserState {
  final UserModel? userData;
  final bool isLoading;
  final String? error;
  final String? pendingEmailVerification;
  const UserState({
    this.userData,
    this.isLoading = false,
    this.error,
    this.pendingEmailVerification,
  });

  UserState copyWith({
    UserModel? userData,
    bool? isLoading,
    String? Function()? error,
    String? Function()? pendingEmailVerification,
  }) {
    return UserState(
      userData: userData ?? this.userData,
      isLoading: isLoading ?? this.isLoading,
      error: error != null ? error() : this.error,
      pendingEmailVerification: pendingEmailVerification != null
          ? pendingEmailVerification()
          : this.pendingEmailVerification,
    );
  }
}
