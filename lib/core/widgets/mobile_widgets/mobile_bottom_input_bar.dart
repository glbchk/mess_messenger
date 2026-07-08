import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MobileBottomInputBar extends StatelessWidget {
  final bool? textNewLineOrSend;
  final TextEditingController controller;
  final VoidCallback onPressedAttachment;
  final VoidCallback onPressedEmoji;
  final VoidCallback onPressedTextNewLine;
  final VoidCallback onPressedSend;

  const MobileBottomInputBar({
    super.key,
    this.textNewLineOrSend = true,
    required this.controller,
    required this.onPressedAttachment,
    required this.onPressedEmoji,
    required this.onPressedTextNewLine,
    required this.onPressedSend,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          top: 12,
          right: 12,
          bottom: 16,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 56,
          decoration: BoxDecoration(
            color: colors.bg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border2),
          ),
          child: Row(
            children: [
              IconButton(
                icon: MessIcon(SvgIcons.attachment),
                onPressed: onPressedAttachment,
              ),
              AppSpacing.p20.gapH,
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Type here...",
                    border: InputBorder.none,
                  ),
                ),
              ),

              IconButton(
                icon: MessIcon(SvgIcons.emoji),
                onPressed: onPressedEmoji,
              ),

              AppSpacing.p8.gapH,

              GestureDetector(
                onTap: textNewLineOrSend == true
                    ? onPressedSend
                    : onPressedTextNewLine,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.icon1,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: MessIcon(
                      textNewLineOrSend == true
                          ? SvgIcons.send
                          : SvgIcons.textNewLine,
                      color: colors.bg,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
