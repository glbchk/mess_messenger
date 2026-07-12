import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class UserState {
  final UserModel? userData;
  final bool isLoading;
  final String? error;
  const UserState({this.userData, this.isLoading = false, this.error});

  UserState copyWith({UserModel? userData, bool? isLoading, String? error}) {
    return UserState(
      userData: userData ?? this.userData,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
