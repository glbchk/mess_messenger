import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat/chats_header_section_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat/header_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/chat_tile_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/direct_chat_tile_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/empty_screen.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';

class ChatListWidget extends ConsumerWidget {
  const ChatListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final userData = ref.watch(userNotifierProvider).userData;

    final chats = ref.watch(userChatsNotifierProvider).chats;

    final directChats = chats.where((c) => !c.isGroup).toList();
    final groupChats = chats.where((c) => c.isGroup).toList();

    return Column(
      children: [
        HeaderWidget(
          title: l10n.chats,
          iconPath: SvgIcons.add,
          onPressed: userData == null
              ? null
              : () async {
                  final chatId = await ref
                      .read(userChatsNotifierProvider.notifier)
                      .getOrCreateChatWithUser(userData.id);
                  if (chatId != null && context.mounted) {
                    context.go(AppRoutes.chatsWithSelection(chatId));
                  }
                },
        ),
        MessTextField(
          height: 56,
          radius: 24,
          hint: l10n.searchHere,
          prefixIcon: SvgIcons.search,
        ),
        AppSpacing.p12.gapV,
        Expanded(
          child: groupChats.isNotEmpty || directChats.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      //Groups
                      ChatsHeaderSectionWidget(
                        sectionTitle: l10n.groups,
                        onPressed: () {},
                      ),
                      for (final groupChat in groupChats)
                        ChatTileWidget(
                          iconPath: SvgIcons.folders,
                          chatId: groupChat.id,
                          title: 'In future should be group messages!',
                          subtitle: groupChat.lastMessage,
                          onPressed: () {},
                        ),

                      //Chats
                      ChatsHeaderSectionWidget(
                        sectionTitle: l10n.chats,
                        onPressed: () {},
                      ),
                      for (final directChat in directChats)
                        DirectChatTile(
                          chat: directChat,
                          onPressed: () => context.go(
                            AppRoutes.chatsWithSelection(directChat.id),
                          ),
                        ),
                    ],
                  ),
                )
              : EmptyScreenWidget(),
        ),
      ],
    );
  }
}
