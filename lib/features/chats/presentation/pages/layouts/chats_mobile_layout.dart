import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/app_images.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/app_bar/mobile_app_bar.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/mobile_open_chat_page.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat_tile_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chats_header_section_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ChatsMobileLayout extends ConsumerStatefulWidget {
  final String pageTitle;
  final UserModel userData;
  final List<ChatModel> chats;
  final Future<void> Function() onPressed;

  const ChatsMobileLayout({
    super.key,
    required this.pageTitle,
    required this.userData,
    required this.chats,
    required this.onPressed,
  });

  @override
  ConsumerState<ChatsMobileLayout> createState() => _ChatsMobileLayoutState();
}

class _ChatsMobileLayoutState extends ConsumerState<ChatsMobileLayout> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = AppLocalizations.of(context)!;

    final directChats = widget.chats.where((c) => !c.isGroup).toList();
    final groupChats = widget.chats.where((c) => c.isGroup).toList();

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: MobileAppBar(
        appBarBackgroundColor: colors.transparent,
        resizeToAvoidBottomInset: false,
        showAppBarContent: false,
        title: widget.pageTitle,
        actions: [
          IconButton(
            //TODO: MUST BE DELETED LATER
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () =>
                ref.read(authProvider.notifier).logout(), // widget.onPressed,
          ),
          AppSpacing.p16.gapH,
          MessIconButton(
            SvgIcons.add,
            onPressed: () async {
              await widget.onPressed();
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
            child: widget.chats.isNotEmpty
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
                              title:
                                  'In future should be group messages!', //groupChat.id.substring(0, 12),
                              subtitle: groupChat.lastMessage,
                              onPressed: () {},
                            ),

                          //Chats
                          ChatsHeaderSectionWidget(
                            sectionTitle: l10n.chats,
                            onPressed: () {},
                          ),
                          for (final directChat in directChats)
                            ChatTileWidget(
                              iconPath: SvgIcons.folders,
                              chatId: directChat.id,
                              title: directChat.id.substring(0, 12),
                              subtitle: directChat.lastMessage,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MobileOpenChatPage(
                                      chatId: directChat.id,
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.emptyScreenLogo,
                            width: 300,
                            height: 300,
                          ),
                          AppSpacing.p20.gapV,
                          Text(
                            l10n.messenger,
                            style: textTheme.headlineLarge?.copyWith(
                              color: colors.text1,
                            ),
                          ),
                          AppSpacing.p8.gapV,
                          Text(
                            l10n.chatsEmptyScreenText,
                            style: textTheme.bodyLarge?.copyWith(
                              color: colors.text2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
