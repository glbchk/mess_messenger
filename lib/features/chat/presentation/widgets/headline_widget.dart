import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class HeadlineWidget extends ConsumerWidget {
  final String title;
  final String iconPath;

  const HeadlineWidget({
    super.key,
    required this.title,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Container(
      color: Colors.transparent,
      height: 79,
      child: Row(
        children: [
          Text(
            title,
            style: textTheme.displaySmall?.copyWith(color: colors.text1),
          ),
          Spacer(),
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: colors.surface2,
            ),
            child: Center(
              child: SvgPicture.asset(iconPath, height: 20, width: 20),
            ),
          ),
        ],
      ),
    );
  }
}
