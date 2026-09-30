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
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/contacts/presentation/contacts_providers/contacts_providers.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_leter_list_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ContactsMobileLayout extends ConsumerStatefulWidget {
  final VoidCallback onPressed;

  const ContactsMobileLayout({super.key, required this.onPressed});

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

    final userData =
        ref.watch(userNotifierProvider).userData ?? UserModel(id: '');

    final chats = ref.watch(userChatsNotifierProvider).chats;
    final myId = userData.id;

    final contactChats = chats
        .where((c) => !c.isGroup && c.status == ChatRequestStatus.accepted)
        .toList();

    void openContactDetails(String contactUserId) {
      if (ResponsiveBreakpoints.of(context).isMobile) {
        context.push(AppRoutes.contactDetailsFor(contactUserId));
      } else {
        ref
            .read(contactsNotifierProvider.notifier)
            .selectContact(contactUserId);
      }
    }

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: MobileAppBar(
        appBarBackgroundColor: colors.transparent,
        resizeToAvoidBottomInset: false,
        showAppBarContent: false,
        title: l10n.contacts,
        actions: [
          MessIconButton(
            SvgIcons.add,
            onPressed: () async {
              await widget.onPressed;
            },
          ),
          AppSpacing.p16.gapH,
          UserAvatarWidget(
            userName: userData.email ?? 'Joe Doe',
            photoPath: userData.avatarUrl,
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
                onContactTap: (chat) {
                  final peerId = chat.peerId(myId);
                  if (peerId != null) openContactDetails(peerId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
