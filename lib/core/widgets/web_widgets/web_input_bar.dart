import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class WebInputBar extends StatelessWidget {
  final bool? textNewLineOrSend;
  final TextEditingController controller;
  final VoidCallback onPressedAttachment;
  final VoidCallback onPressedEmoji;
  final VoidCallback onPressedTextNewLine;
  final VoidCallback onPressedSend;
  final VoidCallback? onPressedFAQ;

  const WebInputBar({
    super.key,
    this.textNewLineOrSend = true,
    required this.controller,
    required this.onPressedAttachment,
    required this.onPressedEmoji,
    required this.onPressedTextNewLine,
    required this.onPressedSend,
    this.onPressedFAQ,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 48,
      decoration: BoxDecoration(
        color: colors.bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border2),
      ),
      child: Row(
        children: [
          if (onPressedFAQ != null) ...[
            AppSpacing.p8.gapH,
            MessIconButton(
              SvgIcons.help,
              borderWidth: 0,
              iconSize: 18,
              buttonSize: 30,
              onPressed: onPressedFAQ,
            ),
          ],
          MessIconButton(
            SvgIcons.attachment,
            borderWidth: 0,
            iconSize: 18,
            buttonSize: 30,
            onPressed: onPressedAttachment,
          ),
          AppSpacing.p16.gapH,
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Type here...",
                border: .none,
              ),
            ),
          ),

          MessIconButton(
            SvgIcons.emoji,
            borderWidth: 0,
            iconSize: 18,
            buttonSize: 30,
            onPressed: onPressedEmoji,
          ),

          AppSpacing.p8.gapH,

          GestureDetector(
            onTap: textNewLineOrSend == true
                ? onPressedSend
                : onPressedTextNewLine,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: colors.icon1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: MessIcon(
                  textNewLineOrSend == true
                      ? SvgIcons.send
                      : SvgIcons.textNewLine,
                  size: 18,
                  color: colors.bg,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
