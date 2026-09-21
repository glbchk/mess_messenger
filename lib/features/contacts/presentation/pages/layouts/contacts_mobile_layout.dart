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
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_leter_list_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ContactsMobileLayout extends ConsumerStatefulWidget {
  final String pageTitle;
  final UserModel userData;
  final List<ChatModel> chats;
  final VoidCallback onPressed;

  const ContactsMobileLayout({
    super.key,
    required this.pageTitle,
    required this.userData,
    required this.chats,
    required this.onPressed,
  });

  @override
  ConsumerState<ContactsMobileLayout> createState() =>
      _ContactsMobileLayoutState();
}

class _ContactsMobileLayoutState extends ConsumerState<ContactsMobileLayout> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final bp = ResponsiveBreakpoints.of(context);

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

      if (bp.isMobile || bp.isTablet) {
        context.push(AppRoutes.chatWith(chatId));
      } else {
        ref.read(selectedChatIdProvider.notifier).state = chatId;
      }
    }

    // List<({ChatModel chat, String peerId, UserModel? peer})> sortContactsByName(
    //   List<({ChatModel chat, String peerId, UserModel? peer})> entries,
    // ) {
    //   final sorted = [...entries];
    //   sorted.sort((a, b) {
    //     final nameA = (a.peer?.name ?? a.peerId).toUpperCase();
    //     final nameB = (b.peer?.name ?? b.peerId).toUpperCase();
    //     return nameA.compareTo(nameB);
    //   });
    //   return sorted;
    // }
    //
    // String letterOf(({ChatModel chat, String peerId, UserModel? peer}) entry) {
    //   final name = entry.peer?.name ?? '';
    //   return name.isNotEmpty ? name[0].toUpperCase() : '#';
    // }
    //
    // final resolved = chats.map((chat) {
    //   final peerId = chat.peerId(myId) ?? '';
    //   final peer = ref.watch(watchedUserProvider(peerId)).value;
    //   return (chat: chat, peerId: peerId, peer: peer);
    // }).toList();
    //
    // final entries = sortContactsByName(resolved);

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: MobileAppBar(
        appBarBackgroundColor: colors.transparent,
        resizeToAvoidBottomInset: false,
        showAppBarContent: false,
        title: widget.pageTitle,
        actions: [
          MessIconButton(
            SvgIcons.add,
            onPressed: () async {
              await widget.onPressed;
            },
          ),
          AppSpacing.p16.gapH,
          UserAvatarWidget(
            userName: widget.userData.email ?? 'Joe Doe',
            photoPath: widget.userData.avatarUrl,
          ),
          AppSpacing.p16.gapH,
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 10, right: 16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            MessTextField(
              height: 56,
              radius: 24,
              hint: l10n.searchHere,
              prefixIcon: SvgIcons.search,
              onTap: () => context.push(AppRoutes.userSearch),
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
    );
  }
}
