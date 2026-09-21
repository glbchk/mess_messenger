import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class UserSearchState {
  final bool isLoading;
  final bool hasSearched;
  final UserModel? result;
  final String? error;

  const UserSearchState({
    this.isLoading = false,
    this.hasSearched = false,
    this.result,
    this.error,
  });
}
