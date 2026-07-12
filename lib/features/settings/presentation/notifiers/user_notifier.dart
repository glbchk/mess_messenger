import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/settings/presentation/states/user_state.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:mess_messenger_app/providers/firebase_provider.dart';

class UserNotifier extends Notifier<UserState> {
  @override
  UserState build() {
    Future.microtask(() => fetchUserData());
    return const UserState();
  }

  Future<void> fetchUserData() async {
    final uid = ref.read(firebaseAuthProvider).currentUser?.uid;
    if (uid == null) return;

    state = state.copyWith(isLoading: true);
    try {
      final userData = await ref
          .read(fetchUserDataUseCaseProvider)
          .execute(uid);
      state = state.copyWith(userData: userData, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
