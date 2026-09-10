import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/states/watched_user_state.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class WatchedUserNotifier extends Notifier<WatchedUserState> {
  WatchedUserNotifier(this.userId);
  final String userId;

  StreamSubscription<UserModel>? _userSubscription;

  @override
  WatchedUserState build() {
    ref.onDispose(() {
      _userSubscription?.cancel();
    });

    if (userId.isNotEmpty) {
      Future.microtask(() => _watchUser());
    }
    return const WatchedUserState(isLoading: true);
  }

  void _watchUser() {
    _userSubscription?.cancel();

    _userSubscription = ref
        .read(watchUserUseCaseProvider)
        .execute(userId)
        .listen(
          (user) {
            state = state.copyWith(user: user, isLoading: false);
          },
          onError: (error) {
            state = state.copyWith(isLoading: false, error: error.toString());
            print('DEBUG: watchUser failed: $error');
          },
        );
  }
}
