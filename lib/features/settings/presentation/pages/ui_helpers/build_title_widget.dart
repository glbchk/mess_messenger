import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class BuildTitleWidget extends StatelessWidget {
  final String title;

  const BuildTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Text(
      title,
      style: textTheme.titleMedium?.copyWith(color: colors.text2),
    );
  }
}
