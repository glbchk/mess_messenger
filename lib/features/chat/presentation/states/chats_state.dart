import 'package:mess_messenger_app/features/auth/data/models/user_model.dart';

class ChatsState {
  final bool isUserAuthenticated;
  final bool isLoading;
  final UserModel? userData;
  final bool clearUserData;

  ChatsState({
    required this.isUserAuthenticated,
    this.isLoading = false,
    this.userData,
    this.clearUserData = false,
  });

  ChatsState copyWith({
    bool? isUserAuthenticated,
    bool? isLoading,
    UserModel? userData,
    bool clearUserData = false,
  }) {
    return ChatsState(
      isUserAuthenticated: isUserAuthenticated ?? this.isUserAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      userData: clearUserData ? null : (userData ?? this.userData),
      clearUserData: clearUserData,
    );
  }
}
