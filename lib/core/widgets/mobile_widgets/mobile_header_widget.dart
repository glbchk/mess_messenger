import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MobileHeaderWidget extends ConsumerWidget {
  final String title;
  final String iconPath;
  final VoidCallback onPressed;

  const MobileHeaderWidget({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onPressed,
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
          GestureDetector(
            onTap: onPressed,
            child: Container(
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
          ),
        ],
      ),
    );
  }
}
