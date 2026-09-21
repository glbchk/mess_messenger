import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/web_side_menu.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat/header_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/empty_screen.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/user_details_panel/user_detals_panel_widget.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_leter_list_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ContactsDesktopLayout extends ConsumerWidget {
  final String pageTitle;
  final UserModel userData;
  final List<ChatModel> chats;
  // final String selectedChatId;
  final VoidCallback onPressed;
  final void Function(String chatId) onChatSelected;
  final TextEditingController messageController;
  final VoidCallback onSendMessage;

  const ContactsDesktopLayout({
    super.key,
    required this.pageTitle,
    required this.userData,
    required this.chats,
    // required this.selectedChatId,
    required this.onPressed,
    required this.onChatSelected,
    required this.messageController,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final bp = ResponsiveBreakpoints.of(context);

    final sectionWidth = bp.isDesktop
        ? bp.screenWidth * 0.25
        : bp.screenWidth * 0.35;

    final l10n = context.l10n;

    final chats = ref.watch(userChatsNotifierProvider).chats;
    final myId = ref.watch(userNotifierProvider).userData?.id ?? '';

    final contactChats = chats
        .where((c) => !c.isGroup && c.status == ChatRequestStatus.accepted)
        .toList();

    Future<void> openChatWith(String otherUserId) async {
      final myId = ref.read(userNotifierProvider).userData?.id;
      if (myId == null) return;

      final chatId = await ref
          .read(getOrCreateChatUseCaseProvider)
          .execute(myId, otherUserId, myId);
      if (!context.mounted) return;

      if (bp.isMobile) {
        context.push(AppRoutes.chatWith(chatId));
      } else {
        context.go(AppRoutes.contactsWithSelection(chatId));
      }
    }

    final selectedChatId =
        GoRouterState.of(context).uri.queryParameters['c'] ?? '';

    return Scaffold(
      body: Row(
        crossAxisAlignment: .stretch,
        children: [
          WebSideMenu(),

          Container(
            width: sectionWidth,
            color: colors.surface0,
            child: Container(
              padding: EdgeInsets.only(left: 24, top: 12, right: 24),
              margin: EdgeInsets.only(left: 20, top: 20, right: 16, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                color: colors.bg,
              ),
              child: Column(
                children: [
                  HeaderWidget(
                    title: l10n.contacts,
                    iconPath: SvgIcons.add,
                    onPressed: () {}, //onPressed,
                  ),
                  MessTextField(
                    height: 56,
                    radius: 24,
                    hint: l10n.searchHere,
                    prefixIcon: SvgIcons.search,
                  ),
                  AppSpacing.p12.gapV,

                  Expanded(
                    child: ContactsLetterList(
                      chats: contactChats,
                      myId: myId,
                      onContactTap: (chat) => openChatWith(chat.id),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: selectedChatId == ''
                ? EmptyScreenWidget(
                    title: l10n.messenger,
                    subtitle: l10n.yourPersonalContacts,
                  )
                : UserDetailsPanelWidget(),
          ),
        ],
      ),
    );
  }
}
