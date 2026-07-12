import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/layouts/responsive_layout_wrapper.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/layouts/chats_desktop_layout.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/layouts/chats_mobile_layout.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/layouts/chats_tablet_layout.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/mobile_open_chat_page.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ChatsPage extends ConsumerStatefulWidget {
  const ChatsPage({super.key});

  @override
  ConsumerState<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends ConsumerState<ChatsPage> {
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

    Future<void> openChattingPage() async {
      final currentUserId = ref.read(userNotifierProvider).userData?.id;
      if (currentUserId == null) return;

      const otherUserId =
          'nBEcLiKmQER28aVpq0BlCC3b25Y2'; // the second test user

      final chatId = await ref
          .read(getOrCreateChatUseCaseProvider)
          .execute(currentUserId, otherUserId);
      print('DEBUG: chatId = $chatId');

      if (!context.mounted) return;

      if (bp.isMobile) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MobileOpenChatPage(chatId: chatId)),
        );
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
      mobile: ChatsMobileLayout(
        pageTitle: l10n.chats,
        userData: userData,
        chats: chatsListState.chats,
        onPressed: () => openChattingPage(),
      ),
      tablet: ChatsTabletLayout(
        pageTitle: l10n.chats,
        userData: userData,
        chats: chatsListState.chats,
        selectedChatId: selectedChatId ?? '',
        onPressed: () => openChattingPage(),
        onChatSelected: selectChat,
        messageController: messageController,
        onSendMessage: () {
          if (selectedChatId != null) sendMessage(selectedChatId);
        },
        onDeselectChat: () => deselectChat(),
      ),
      desktop: ChatsDesktopLayout(
        pageTitle: l10n.chats,
        userData: userData,
        chats: chatsListState.chats,
        selectedChatId: selectedChatId ?? '',
        onPressed: () => openChattingPage(),
        onChatSelected: selectChat,
        messageController: messageController,
        onSendMessage: () {
          if (selectedChatId != null) sendMessage(selectedChatId);
        },
      ),
    );
  }
}
