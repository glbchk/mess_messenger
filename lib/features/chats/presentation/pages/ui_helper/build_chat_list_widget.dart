import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/app_images.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/header_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat_tile_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chats_header_section_widget.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';

Widget buildChatList({
  required String pageTitle,
  required BuildContext context,
  required AppLocalizations l10n,
  required dynamic colors,
  required dynamic textTheme,
  required List<ChatModel> groupChats,
  required List<ChatModel> directChats,
  required VoidCallback onPressed,
  required void Function(String chatId) onChatSelected,
}) {
  return Column(
    children: [
      HeaderWidget(
        title: pageTitle,
        iconPath: SvgIcons.add,
        onPressed: onPressed,
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
                        onPressed: () => onChatSelected(directChat.id),
                      ),
                  ],
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
  );
}
