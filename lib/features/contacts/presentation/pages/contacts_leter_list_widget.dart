import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/letter_widget.dart';
import 'package:mess_messenger_app/features/contacts/presentation/widgets/contact_tile_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class ContactsLetterList extends ConsumerWidget {
  final List<ChatModel> chats;
  final String myId;
  final void Function(ChatModel chat) onContactTap;

  const ContactsLetterList({
    super.key,
    required this.chats,
    required this.myId,
    required this.onContactTap,
  });

  List<({ChatModel chat, String peerId, UserModel? peer})> sortContactsByName(
    List<({ChatModel chat, String peerId, UserModel? peer})> entries,
  ) {
    final sorted = [...entries];
    sorted.sort((a, b) {
      final nameA = (a.peer?.name ?? a.peerId).toUpperCase();
      final nameB = (b.peer?.name ?? b.peerId).toUpperCase();
      return nameA.compareTo(nameB);
    });
    return sorted;
  }

  String letterOf(({ChatModel chat, String peerId, UserModel? peer}) entry) {
    final name = entry.peer?.name ?? '';
    return name.isNotEmpty ? name[0].toUpperCase() : '#';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resolved = chats.map((chat) {
      final peerId = chat.peerId(myId) ?? '';
      final peer = ref.watch(watchedUserProvider(peerId)).value;
      return (chat: chat, peerId: peerId, peer: peer);
    }).toList();

    final entries = sortContactsByName(resolved);

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        final letter = letterOf(entry);
        final showHeader = index == 0 || letter != letterOf(entries[index - 1]);

        final tile = ContactTileWidget(
          contactId: entry.peerId,
          title: entry.peer?.name ?? 'Loading…',
          subtitle: entry.peer?.email ?? '',
          photoPath: entry.peer?.avatarUrl,
          onPressed: () => onContactTap(entry.chat),
        );

        if (!showHeader) return tile;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: LetterWidget(letter: letter),
            ),
            tile,
          ],
        );
      },
    );
  }
}
