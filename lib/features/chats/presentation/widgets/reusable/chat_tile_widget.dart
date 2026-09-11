import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ChatTileWidget extends StatelessWidget {
  final String iconPath;
  final String? photoPath;
  final String chatId;
  final bool isGroup;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const ChatTileWidget({
    super.key,
    required this.iconPath,
    this.photoPath,
    required this.chatId,
    this.isGroup = false,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: colors.transparent,
        height: 56,
        child: Row(
          spacing: 8,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: colors.surface4,
              ),
              child: isGroup
                  ? Center(child: MessIcon(iconPath, size: 16))
                  : UserAvatarWidget(
                      userName: title,
                      photoPath: photoPath,
                      // size: 32,
                    ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 1,
                children: [
                  Text(
                    title,
                    style: textTheme.bodyMedium?.copyWith(color: colors.text1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: textTheme.bodySmall?.copyWith(color: colors.text2),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
