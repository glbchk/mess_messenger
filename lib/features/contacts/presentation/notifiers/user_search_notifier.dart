import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/contacts/presentation/contacts_providers/contacts_providers.dart';
import 'package:mess_messenger_app/features/contacts/presentation/states/user_search_state.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';

class UserSearchNotifier extends Notifier<UserSearchState> {
  @override
  UserSearchState build() => const UserSearchState();

  Future<void> searchByEmail(String email) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty) {
      state = const UserSearchState();
      return;
    }

    state = const UserSearchState(isLoading: true, hasSearched: true);

    try {
      final myId = ref.read(userNotifierProvider).userData?.id;
      final found = await ref
          .read(findUserByEmailUseCaseProvider)
          .execute(trimmed);

      if (found != null && found.id == myId) {
        state = const UserSearchState(
          hasSearched: true,
          error: 'That\'s your own email',
        );
        return;
      }
      state = UserSearchState(hasSearched: true, result: found);
    } catch (e) {
      state = UserSearchState(hasSearched: true, error: e.toString());
    }
  }
}
