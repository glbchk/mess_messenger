import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class DateSeparatorWidget extends StatelessWidget {
  final String label;
  const DateSeparatorWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Divider(color: colors.surface2)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              label,
              style: textTheme.bodySmall?.copyWith(color: colors.text2),
            ),
          ),
          Expanded(child: Divider(color: colors.surface2)),
        ],
      ),
    );
  }
}
