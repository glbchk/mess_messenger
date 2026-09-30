import 'package:flutter/cupertino.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';

sealed class ChatListItem {}

class MessageItem extends ChatListItem {
  final MessageModel message;
  MessageItem(this.message);
}

class DateSeparatorItem extends ChatListItem {
  final String label;
  DateSeparatorItem(this.label);
}

List<ChatListItem> buildChatItems(
  List<MessageModel> messages,
  BuildContext context,
) {
  final l10n = context.l10n;
  final items = <ChatListItem>[];
  final now = DateTime.now();
  var separatorInserted = false;

  for (final message in messages) {
    final createdAt = message.createdAt;
    final isToday =
        createdAt.year == now.year &&
        createdAt.month == now.month &&
        createdAt.day == now.day;

    if (isToday && !separatorInserted) {
      items.add(DateSeparatorItem(l10n.today));
      separatorInserted = true;
    }

    items.add(MessageItem(message));
  }

  return items;
}
