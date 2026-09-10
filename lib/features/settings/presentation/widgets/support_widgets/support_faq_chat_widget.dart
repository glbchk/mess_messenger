import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/core/constants/support_faq_list.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SupportFaqPanel extends StatelessWidget {
  final List<SupportFaqItem> items;
  final ValueChanged<SupportFaqItem> onSelectQuestion;
  final VoidCallback? onClose;

  const SupportFaqPanel({
    super.key,
    required this.items,
    required this.onSelectQuestion,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Container(
      constraints: const BoxConstraints(maxWidth: 420),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.surface2),
        boxShadow: [
          BoxShadow(
            color: colors.shadowColor.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'SELECT MOST REPETITIVE\nQUESTIONS AND ANSWERS',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.text2,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              if (onClose != null)
                MessIconButton(
                  isButtonFilled: true,
                  SvgIcons.close,
                  buttonSize: 32,
                  iconSize: 16,
                  onPressed: onClose,
                ),
            ],
          ),
          AppSpacing.p12.gapV,
          for (final item in items) ...[
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onSelectQuestion(item),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: .start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors.surface2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        SvgIcons.chats,
                        width: 16,
                        height: 16,
                      ),
                    ),
                    AppSpacing.p12.gapH,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            item.question,
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colors.text1,
                            ),
                          ),
                          Text(
                            'Select to see answer',
                            style: textTheme.bodySmall?.copyWith(
                              color: colors.text2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (item != items.last) Divider(height: 1, color: colors.surface2),
          ],
        ],
      ),
    );
  }
}
