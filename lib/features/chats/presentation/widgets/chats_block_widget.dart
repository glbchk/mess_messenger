import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat_tile_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ChatsSectionWidget extends ConsumerWidget {
  final String chatId;
  final String sectionTitle;
  final String messageTitle;
  final String messageSubtitle;
  final VoidCallback onPressed;

  const ChatsSectionWidget({
    super.key,
    required this.chatId,
    required this.sectionTitle,
    required this.messageTitle,
    required this.messageSubtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 10),
          child: Row(
            children: [
              Center(child: MessIcon(SvgIcons.dropDownFold, size: 18)),
              AppSpacing.p8.gapH,
              Text(
                sectionTitle,
                style: textTheme.headlineMedium?.copyWith(color: colors.text1),
              ),
              Spacer(),
              Center(child: MessIcon(SvgIcons.add, size: 18)),
            ],
          ),
        ),
        ChatTileWidget(
          iconPath: SvgIcons.folders,
          chatId: chatId,
          title: messageTitle,
          subtitle: messageSubtitle,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
