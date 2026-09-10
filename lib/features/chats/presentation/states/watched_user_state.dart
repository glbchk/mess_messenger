import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class WatchedUserState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const WatchedUserState({this.user, this.isLoading = false, this.error});

  bool get isOnline => user?.isOnline ?? false;
  DateTime? get lastActiveAt => user?.lastActiveAt;

  WatchedUserState copyWith({UserModel? user, bool? isLoading, String? error}) {
    return WatchedUserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
