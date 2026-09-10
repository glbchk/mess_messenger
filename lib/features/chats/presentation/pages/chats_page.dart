import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/core/utils/layouts/responsive_layout_wrapper.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/layouts/chats_desktop_layout.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/layouts/chats_mobile_layout.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/layouts/chats_tablet_layout.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
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

  Future<void> openChatWithUser(String otherUserId) async {
    final myId = ref.read(userNotifierProvider).userData?.id;
    if (myId == null) return;

    final chatId = await ref
        .read(getOrCreateChatUseCaseProvider)
        .execute(myId, otherUserId);

    if (!mounted) return;

    final bp = ResponsiveBreakpoints.of(context);
    if (bp.isMobile) {
      context.push(AppRoutes.chatWith(chatId));
    } else {
      ref.read(selectedChatIdProvider.notifier).state = chatId;
    }

    unawaited(
      ref
          .read(chatsRemoteDataSourceProvider)
          .getOrCreateChat(myId, otherUserId),
    );
  }

  void selectChat(String chatId) {
    final bp = ResponsiveBreakpoints.of(context);
    if (bp.isMobile) {
      context.push(AppRoutes.chatWith(chatId));
    } else {
      context.go(AppRoutes.chatsWithSelection(chatId));
    }
  }

  void deselectChat() {
    context.go(AppRoutes.chats);
  }

  @override
  Widget build(BuildContext context) {
    final userData =
        ref.watch(userNotifierProvider).userData ?? UserModel(id: '');

    final chatsListState = ref.watch(userChatsNotifierProvider);
    final selectedChatId =
        GoRouterState.of(context).uri.queryParameters['c'] ?? '';

    final bp = ResponsiveBreakpoints.of(context);
    if (bp.isMobile && selectedChatId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go(AppRoutes.chatWith(selectedChatId));
        }
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final l10n = context.l10n;

    return ResponsiveLayout(
      mobile: ChatsMobileLayout(
        l10n: l10n,
        userData: userData,
        chats: chatsListState.chats,
        onCreateChatPressed: () => openChatWithUser(userData.id),
      ),
      tablet: ChatsTabletLayout(
        l10n: l10n,
        userData: userData,
        chats: chatsListState.chats,
        selectedChatId: selectedChatId,
        onPressedCreateChat: () => openChatWithUser(userData.id),
        onChatSelected: selectChat,
        messageController: messageController,
        onSendMessage: () {
          sendMessage(selectedChatId);
        },
        onDeselectChat: () => deselectChat(),
      ),
      desktop: ChatsDesktopLayout(
        l10n: l10n,
        userData: userData,
        chats: chatsListState.chats,
        selectedChatId: selectedChatId,
        onCreatedChatPressed: () => openChatWithUser(userData.id),
        onChatSelected: selectChat,
        messageController: messageController,
        onSendMessage: () {
          sendMessage(selectedChatId);
        },
      ),
    );
  }
}
