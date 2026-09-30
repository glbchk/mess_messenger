import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class LetterWidget extends ConsumerWidget {
  final String letter;

  const LetterWidget({super.key, required this.letter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        letter,
        style: textTheme.headlineMedium?.copyWith(color: colors.text1),
      ),
    );
  }
}
