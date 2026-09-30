import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/app_bar/mobile_app_bar.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat/chats_header_section_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/chat_tile_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/direct_chat_tile_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/empty_screen.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ChatsMobileLayout extends ConsumerStatefulWidget {
  const ChatsMobileLayout({super.key});

  @override
  ConsumerState<ChatsMobileLayout> createState() => _ChatsMobileLayoutState();
}

class _ChatsMobileLayoutState extends ConsumerState<ChatsMobileLayout> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final userData = ref.watch(userNotifierProvider).userData;
    final chats = ref.watch(userChatsNotifierProvider).chats;
    if (userData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final colors = context.colors;

    final directChats = chats.where((c) => !c.isGroup).toList();
    final groupChats = chats.where((c) => c.isGroup).toList();

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: MobileAppBar(
        appBarBackgroundColor: colors.transparent,
        resizeToAvoidBottomInset: false,
        showAppBarContent: false,
        title: l10n.chats,
        actions: [
          MessIconButton(
            SvgIcons.add,
            isButtonFilled: true,
            onPressed: () => context.push(AppRoutes.userSearch),
          ),
          AppSpacing.p16.gapH,
          UserAvatarWidget(
            userName: userData.email ?? 'Joe Doe',
            photoPath: userData.avatarUrl,
            onPressed: () {
              context.push(AppRoutes.settings);
            },
          ),
          AppSpacing.p16.gapH,
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 10, right: 16),
            child: MessTextField(
              height: 56,
              radius: 24,
              hint: l10n.searchHere,
              prefixIcon: SvgIcons.search,
              onTap: () => context.push(AppRoutes.userSearch),
            ),
          ),
          AppSpacing.p12.gapV,

          Expanded(
            child: chats.isNotEmpty
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
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
                              onPressed: () {
                                context.push(AppRoutes.chatWith(directChat.id));
                              },
                            ),
                        ],
                      ),
                    ),
                  )
                : EmptyScreenWidget(),
          ),
        ],
      ),
    );
  }
}
