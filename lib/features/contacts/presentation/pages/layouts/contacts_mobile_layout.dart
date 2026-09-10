import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/app_bar/mobile_app_bar.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
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

    final l10n = AppLocalizations.of(context)!;

    final bp = ResponsiveBreakpoints.of(context);

    Future<void> openChatWith(String otherUserId) async {
      final myId = ref.read(userNotifierProvider).userData?.id;
      if (myId == null) return;

      final chatId = await ref
          .read(getOrCreateChatUseCaseProvider)
          .execute(myId, otherUserId);
      if (!context.mounted) return;

      if (bp.isMobile) {
        context.push(AppRoutes.chatWith(chatId));
      } else {
        ref.read(selectedChatIdProvider.notifier).state = chatId;
      }
    }

    // final directChats = widget.chats.where((c) => !c.isGroup).toList();
    // final groupChats = widget.chats.where((c) => c.isGroup).toList();

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: MobileAppBar(
        appBarBackgroundColor: colors.transparent,
        resizeToAvoidBottomInset: false,
        showAppBarContent: false,
        title: widget.pageTitle ?? 'Contacts',
        actions: [
          MessIconButton(
            SvgIcons.add,
            onPressed: () async {
              //HERE NEED TO REDIRECT TO ADD A NEW CONTACT
              await widget.onPressed;
            },
          ),
          AppSpacing.p16.gapH,
          UserAvatarWidget(
            userName: widget.userData.email ?? 'Joe Doe', //'Joe Doe',
            photoPath: 'assets/images/user_images/avatar_image.png',
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
            ),
          ),
          AppSpacing.p12.gapV,

          Expanded(
            child: ListView(
              children: [
                for (final u in kSeedUsers)
                  ListTile(
                    leading: CircleAvatar(
                      child: Text((u.name ?? '?').characters.first),
                    ),
                    title: Text(u.name ?? u.id),
                    subtitle: Text(u.email ?? ''),
                    onTap: () => openChatWith(u.id),
                  ),
              ],
            ),
          ),

          // Expanded(
          //   child: widget.chats.isNotEmpty
          //       ? SingleChildScrollView(
          //           child: Padding(
          //             padding: const EdgeInsets.only(
          //               left: 22,
          //               top: 22,
          //               right: 22,
          //             ),
          //             child: Column(
          //               crossAxisAlignment: .start,
          //               children: [
          //                 //Groups
          //                 Text(
          //                   'A',
          //                   style: textTheme.headlineMedium?.copyWith(
          //                     color: colors.text1,
          //                   ),
          //                 ),
          //                 AppSpacing.p16.gapV,
          //                 // for (final groupChat in groupChats)
          //                 ContactTileWidget(
          //                   contactId: '',
          //                   title: 'Some',
          //                   subtitle: 'Something',
          //                   onPressed: () {},
          //                 ),
          //               ],
          //             ),
          //           ),
          //         )
          //       : Center(
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 22.0),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Image.asset(
          //                   'assets/images/empty_screen_logo.png',
          //                   width: 300,
          //                   height: 300,
          //                 ),
          //                 AppSpacing.p20.gapV,
          //                 Text(
          //                   l10n.messenger,
          //                   style: textTheme.headlineLarge?.copyWith(
          //                     color: colors.text1,
          //                   ),
          //                 ),
          //                 AppSpacing.p8.gapV,
          //                 Text(
          //                   l10n.chatsEmptyScreenText,
          //                   style: textTheme.bodyLarge?.copyWith(
          //                     color: colors.text2,
          //                   ),
          //                   textAlign: TextAlign.center,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          // ),
        ],
      ),
    );
  }
}
