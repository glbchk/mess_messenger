import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/ui_helper/format_message_timestamp.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ReceivedMessageWidget extends StatelessWidget {
  final bool isOnline;
  final String? userName;
  final MessageModel? message;
  final String? currentUserId;

  const ReceivedMessageWidget({
    super.key,
    required this.isOnline,
    this.userName,
    this.message,
    this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return IntrinsicWidth(
      child: Row(
        crossAxisAlignment: .start,
        spacing: 12,
        children: [
          UserAvatarWidget(isOnline: isOnline, userName: 'Other', size: 40),
          Expanded(
            child: Column(
              crossAxisAlignment: .stretch,
              mainAxisSize: .min,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(userName ?? 'User'),

                    Text(
                      formatMessageTimestamp(message?.createdAt, context),
                      style: textTheme.bodySmall?.copyWith(color: colors.text2),
                    ),
                  ],
                ),
                AppSpacing.p4.gapV,
                Container(
                  constraints: const BoxConstraints(minWidth: 200),
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 12,
                    bottom: 16,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surface2,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    message?.text ?? '',
                    style: textTheme.bodyLarge?.copyWith(color: colors.text1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
