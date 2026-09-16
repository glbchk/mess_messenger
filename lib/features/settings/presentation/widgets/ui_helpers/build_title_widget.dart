import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class BuildTitleWidget extends StatelessWidget {
  final String title;
  final Color? textColor;

  const BuildTitleWidget({super.key, required this.title, this.textColor});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Text(
      title,
      style: textTheme.titleMedium?.copyWith(color: textColor ?? colors.text2),
    );
  }
}
