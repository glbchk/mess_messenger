import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SectionWidget extends StatelessWidget {
  final List<Widget> widgets;
  final String title;
  final TextStyle? textStyle;
  final Color? textColor;

  const SectionWidget({
    super.key,
    required this.widgets,
    required this.title,
    this.textStyle,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Column(
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Text(
          title,
          style:
              textStyle ??
              textTheme.headlineSmall?.copyWith(
                color: textColor ?? colors.text1,
              ),
        ),
        Column(
          crossAxisAlignment: .start,
          spacing: 12,
          children: [for (var widget in widgets) widget],
        ),
      ],
    );
  }
}
