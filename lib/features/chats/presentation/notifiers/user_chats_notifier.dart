import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/presentation/states/user_chats_state.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';

class UserChatsNotifier extends Notifier<UserChatsState> {
  StreamSubscription<List<ChatModel>>? _chatsSubscription;

  @override
  UserChatsState build() {
    ref.onDispose(() {
      _chatsSubscription?.cancel();
    });

    final userData = ref.watch(userNotifierProvider).userData;

    if (userData != null) {
      Future.microtask(() => fetchChats());
    }

    return const UserChatsState(isLoading: true);
  }

  void fetchChats() async {
    final uid = ref.read(userNotifierProvider).userData?.id;
    if (uid == null) return;

    state = state.copyWith(isLoading: true);

    // Cancel old listener if it exists
    _chatsSubscription?.cancel();

    _chatsSubscription = ref
        .read(fetchUserChatsUseCaseProvider)
        .execute(uid)
        .listen(
          (chats) {
            state = state.copyWith(chats: chats, isLoading: false);
          },
          onError: (error) {
            state = state.copyWith(isLoading: false, error: error.toString());

            print('DEBUG: fetchChats failed: $error');
          },
        );
  }
}
