import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/chat_tile_widget.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';

class DirectChatTile extends ConsumerWidget {
  final ChatModel chat;
  final VoidCallback onPressed;

  const DirectChatTile({
    super.key,
    required this.chat,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myId = ref.watch(userNotifierProvider).userData?.id ?? '';
    final peerId = chat.peerId(myId) ?? '';
    final peer = ref.watch(watchedUserProvider(peerId)).value;

    return ChatTileWidget(
      iconPath: SvgIcons.folders,
      chatId: chat.id,
      isGroup: false,
      photoPath: peer?.avatarUrl,
      title: (peer?.name?.isNotEmpty ?? false) ? peer?.name ?? '' : 'Loading…',
      subtitle: chat.lastMessage.isEmpty ? 'No messages yet' : chat.lastMessage,
      onPressed: onPressed,
    );
  }
}
