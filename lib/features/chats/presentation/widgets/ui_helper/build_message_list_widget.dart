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

List<ChatListItem> buildChatItems(List<MessageModel> messages) {
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
      items.add(DateSeparatorItem('TODAY'));
      separatorInserted = true;
    }

    items.add(MessageItem(message));
  }

  return items;
}
