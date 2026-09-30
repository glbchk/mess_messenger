import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessTextButton extends StatelessWidget {
  final String label;
  final TextStyle? textStyle;
  final Color? textColor;
  final VoidCallback? onPressed;

  const MessTextButton({
    super.key,
    required this.label,
    this.textStyle,
    this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return GestureDetector(
      onTap: onPressed,
      child: Text(
        label,
        style:
            textStyle ??
            textTheme.labelSmall?.copyWith(color: textColor ?? colors.link),
      ),
    );
  }
}
