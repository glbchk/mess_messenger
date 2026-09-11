import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/web_side_menu.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat/chat_list_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat/opened_selected_chat_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/user_details_panel/user_detals_panel_widget.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ChatsTabletLayout extends ConsumerWidget {
  final TextEditingController messageController;

  const ChatsTabletLayout({super.key, required this.messageController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;

    final userData = ref.watch(userNotifierProvider).userData;
    if (userData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final selectedChatId =
        GoRouterState.of(context).uri.queryParameters['c'] ?? '';

    final isProfilesDisplayed = ref.watch(
      userChatsNotifierProvider.select((s) => s.isProfileDetailsDisplayed),
    );

    return Scaffold(
      body: Row(
        crossAxisAlignment: .stretch,
        children: [
          WebSideMenu(),

          Expanded(
            child: Container(
              color: colors.surface0,
              child: Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  color: colors.bg,
                ),
                child: selectedChatId == ''
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        child: ChatListWidget(),
                      )
                    : isProfilesDisplayed == false
                    ? OpenedSelectedChatWidget(
                        chatId: selectedChatId,
                        controller: messageController,
                      )
                    : UserDetailsPanelWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
