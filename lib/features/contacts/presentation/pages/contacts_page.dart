import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/core/utils/layouts/responsive_layout_wrapper.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/mobile_open_chat_page.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/layouts/contacts_desktop_layout.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/layouts/contacts_mobile_layout.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/layouts/contacts_tablet_layout.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ContactsPage extends ConsumerStatefulWidget {
  const ContactsPage({super.key});

  @override
  ConsumerState<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends ConsumerState<ContactsPage> {
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage(String chatId) {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final userData = ref.read(userNotifierProvider).userData;
    if (userData == null) return;

    ref
        .read(chatsNotifierProvider(chatId).notifier)
        .sendMessage(userData.id, text);
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userData =
        ref.watch(userNotifierProvider).userData ?? UserModel(id: '');

    final chatsListState = ref.watch(userChatsNotifierProvider);
    final selectedChatId = ref.watch(selectedChatIdProvider);

    final bp = ResponsiveBreakpoints.of(context);

    final l10n = AppLocalizations.of(context)!;

    Future<void> openChatWith(String otherUserId) async {
      final myId = ref.read(userNotifierProvider).userData?.id;
      if (myId == null) return;

      final chatId = await ref
          .read(getOrCreateChatUseCaseProvider)
          .execute(myId, otherUserId, myId);
      if (!context.mounted) return;

      if (bp.isMobile) {
        context.push(AppRoutes.chatWith(chatId));
      } else {
        ref.read(selectedChatIdProvider.notifier).state = chatId;
      }
    }

    void selectChat(String chatId) {
      if (bp.isMobile) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MobileOpenChatPage(chatId: chatId)),
        );
      } else {
        ref.read(selectedChatIdProvider.notifier).state = chatId;
      }
    }

    void deselectChat() {
      ref.read(selectedChatIdProvider.notifier).state = null;
    }

    return ResponsiveLayout(
      mobile: ContactsMobileLayout(
        pageTitle: l10n.contacts,
        userData: userData,
        chats: chatsListState.chats,
        onPressed: () {}, //=> openChatWith(),
      ),
      tablet: ContactsTabletLayout(
        pageTitle: l10n.contacts,
        userData: userData,
        chats: chatsListState.chats,
        selectedChatId: selectedChatId ?? '',
        onPressed: () {}, //openChattingPage(),
        onChatSelected: selectChat,
        messageController: messageController,
        onSendMessage: () {
          if (selectedChatId != null) sendMessage(selectedChatId);
        },
        onDeselectChat: () => deselectChat(),
      ),
      desktop: ContactsDesktopLayout(
        pageTitle: l10n.contacts,
        userData: userData,
        chats: chatsListState.chats,
        onPressed: () {}, //openChattingPage(),
        onChatSelected: selectChat,
        messageController: messageController,
        onSendMessage: () {
          if (selectedChatId != null) sendMessage(selectedChatId);
        },
      ),
    );
  }
}
