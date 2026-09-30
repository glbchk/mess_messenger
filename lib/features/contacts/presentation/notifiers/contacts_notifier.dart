import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/router/app_router.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/contacts/presentation/states/contacts_state.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';

class ContactsNotifier extends Notifier<ContactsState> {
  @override
  ContactsState build() => const ContactsState();

  void openContactDetails(String contactUserId, {required bool isMobile}) {
    if (isMobile) {
      ref.read(routerProvider).push(AppRoutes.contactDetailsFor(contactUserId));
    } else {
      state = state.copyWith(selectedContactId: contactUserId);
    }
  }

  Future<void> openChatWith(
    String otherUserId, {
    required bool isDesktop,
  }) async {
    final myId = ref.read(userNotifierProvider).userData?.id;
    if (myId == null) return;

    final chatId = await ref
        .read(getOrCreateChatUseCaseProvider)
        .execute(myId, otherUserId, myId);

    final router = ref.read(routerProvider);
    isDesktop
        ? router.go(AppRoutes.chatsWithSelection(chatId))
        : router.push(AppRoutes.chatWith(chatId));
  }

  void selectContact(String userId) =>
      state = state.copyWith(selectedContactId: userId);

  void clearSelection() => state = state.copyWith(clearSelection: true);
}
