import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/app_bar/mobile_app_bar.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/mobile_navigation_bar.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/mobile_open_chat_page.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chats_block_widget.dart';
import 'package:mess_messenger_app/features/profile/data/models/user_model.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ChatsMobileLayout extends ConsumerStatefulWidget {
  final UserModel userData;
  final List<ChatModel> chats;
  final Future<void> Function() onPressed;

  const ChatsMobileLayout({
    super.key,
    required this.userData,
    required this.chats,
    required this.onPressed,
  });

  @override
  ConsumerState<ChatsMobileLayout> createState() => _ChatsMobileLayoutState();
}

class _ChatsMobileLayoutState extends ConsumerState<ChatsMobileLayout> {
  int _selectedIndex = 1;

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
        title: 'Chats',
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () =>
                widget.onPressed, //ref.read(authProvider.notifier).logout(),
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
              hint: l10n.searchHere,
              prefixIcon: SvgPicture.asset(
                SvgIcons.search,
                height: 24,
                width: 24,
              ),
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
                          for (final groupChat in groupChats)
                            ChatsSectionWidget(
                              //TODO: Need to fix
                              chatId: groupChat.id,
                              sectionTitle: l10n.groups,
                              messageTitle:
                                  'In future should be group messages!', //groupChat.id.substring(0, 42)
                              messageSubtitle: '', //groupChat.lastMessage,
                              onPressed: () {},
                            ),

                          for (final directChat in directChats)
                            ChatsSectionWidget(
                              chatId: directChat.id,
                              sectionTitle: l10n.chat,
                              messageTitle: directChat.id.substring(0, 12),
                              messageSubtitle: directChat.lastMessage,
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
                            'assets/images/empty_screen_logo.png',
                            // fit: BoxFit.fitHeight,
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
      bottomNavigationBar: MobileNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
