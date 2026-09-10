import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/ui_helper/format_message_timestamp.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SentMessageWidget extends StatelessWidget {
  final String? userName;
  final MessageModel? message;
  final String? currentUserId;

  const SentMessageWidget({
    super.key,
    this.userName,
    this.message,
    this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: .stretch,
        mainAxisSize: .min,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(userName ?? 'User'),
              Text(
                formatMessageTimestamp(message?.createdAt),
                style: textTheme.bodySmall?.copyWith(color: colors.text2),
              ),
            ],
          ),
          AppSpacing.p8.gapV,
          Container(
            constraints: const BoxConstraints(minWidth: 200),
            padding: const EdgeInsets.only(
              left: 16,
              top: 12,
              bottom: 16,
              right: 16,
            ),
            decoration: BoxDecoration(
              color: colors.textInverse,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(0),
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
    );
  }
}
