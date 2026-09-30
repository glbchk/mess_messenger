import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/web_side_menu.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat/chat_list_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat/opened_selected_chat_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/empty_screen.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/user_details_panel/user_detals_panel_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ChatsDesktopLayout extends ConsumerWidget {
  final TextEditingController messageController;

  const ChatsDesktopLayout({super.key, required this.messageController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final bp = ResponsiveBreakpoints.of(context);

    final sectionWidth = bp.isDesktop
        ? bp.screenWidth * 0.25
        : bp.screenWidth * 0.35;

    final isCollapsed = ref.watch(
      userChatsNotifierProvider.select((s) => s.isChatListCollapsed),
    );

    final isProfilesDisplayed = ref.watch(
      userChatsNotifierProvider.select((s) => s.isProfileDetailsDisplayed),
    );

    final selectedChatId =
        GoRouterState.of(context).uri.queryParameters['c'] ?? '';

    return Stack(
      children: [
        Scaffold(
          body: Row(
            crossAxisAlignment: .stretch,
            children: [
              WebSideMenu(),

              if (!isCollapsed)
                Container(
                  width: sectionWidth,
                  color: colors.surface0,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 24,
                      top: 12,
                      right: 24,
                    ),
                    margin: const EdgeInsets.only(
                      left: 20,
                      top: 20,
                      right: 16,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      color: colors.bg,
                    ),
                    child: ChatListWidget(),
                  ),
                ),

              Expanded(
                child: selectedChatId == ''
                    ? EmptyScreenWidget()
                    : Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: colors.bg,
                        ),
                        child: OpenedSelectedChatWidget(
                          chatId: selectedChatId,
                          controller: messageController,
                        ),
                      ),
              ),

              if (isProfilesDisplayed) UserDetailsPanelWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
