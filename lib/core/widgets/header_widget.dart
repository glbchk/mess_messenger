import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback? onPressed;

  const HeaderWidget({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
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
              child: Center(child: MessIcon(iconPath, size: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
