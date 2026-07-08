import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/layouts/responsive_layout_wrapper.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/auth_page.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/layouts/chats/chats_desktop_layout.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/layouts/chats/chats_mobile_layout.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/layouts/chats/chats_tablet_layout.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/mobile_open_chat_page.dart';
import 'package:mess_messenger_app/features/profile/data/models/user_model.dart';
import 'package:mess_messenger_app/features/profile/user_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ChatsPage extends ConsumerStatefulWidget {
  const ChatsPage({super.key});

  @override
  ConsumerState<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends ConsumerState<ChatsPage> {
  int _selectedIndex = 1;
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
    final colors = context.colors;

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthUnauthenticated) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AuthPage()),
          (route) => false,
        );
      }
    });

    final userData =
        ref.watch(userNotifierProvider).userData ?? UserModel(id: '');

    final chatsListState = ref.watch(userChatsNotifierProvider);
    final selectedChatId = ref.watch(selectedChatIdProvider);
    final bp = ResponsiveBreakpoints.of(context);

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
        // Mobile: still push a full page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MobileOpenChatPage(chatId: chatId)),
        );
      } else {
        // Tablet/Desktop: just update which chat is selected — no navigation
        ref.read(selectedChatIdProvider.notifier).state = chatId;
      }
    }

    // For tapping an existing chat tile (not "start new chat")
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
        userData: userData,
        chats: chatsListState.chats,
        onPressed: () => openChattingPage(),
      ),
      tablet: ChatsTabletLayout(
        userData: userData,
        chats: chatsListState.chats,
        selectedChatId: selectedChatId,
        onPressed: () => openChattingPage(),
        onChatSelected: selectChat,
        messageController: messageController,
        onSendMessage: () {
          if (selectedChatId != null) sendMessage(selectedChatId);
        },
        onDeselectChat: () => deselectChat(),
      ),
      desktop: ChatsDesktopLayout(
        userData: userData,
        chats: chatsListState.chats,
        selectedChatId: selectedChatId,
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
