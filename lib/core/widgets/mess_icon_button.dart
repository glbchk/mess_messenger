import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessIconButton extends StatelessWidget {
  final String svgAsset;
  final double iconSize;
  final double buttonSize;
  final Color? iconColor;
  final double? borderWidth;
  final VoidCallback? onPressed;
  final bool isButtonFilled;

  const MessIconButton(
    this.svgAsset, {
    super.key,
    this.iconSize = 24,
    this.buttonSize = 44,
    this.iconColor,
    this.borderWidth,
    this.onPressed,
    this.isButtonFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final effectiveBorderWidth = borderWidth ?? 1.0;

    return Material(
      shape: effectiveBorderWidth > 0
          ? CircleBorder(
              side: BorderSide(
                color: !isButtonFilled ? colors.border2 : colors.transparent,
                width: effectiveBorderWidth,
              ),
            )
          : const CircleBorder(),
      color: isButtonFilled ? colors.surface2 : colors.bg,
      child: InkWell(
        onTap: onPressed,
        hoverColor: isButtonFilled ? colors.surface4 : colors.surface2,
        splashColor: colors.surface4,
        customBorder: const CircleBorder(),
        child: SizedBox(
          height: buttonSize,
          width: buttonSize,
          child: Center(
            child: MessIcon(svgAsset, size: iconSize, color: iconColor),
          ),
        ),
      ),
    );
  }
}

// Padding(
// padding: const EdgeInsets.only(left: 16.0),
// child: Center(
// child: SizedBox(
// width: 40,
// height: 40,
// child: ClipRRect(
// borderRadius: BorderRadius.circular(50),
// child: ColoredBox(
// color: colors.surface2,
// child: IconButton(
// icon: Icon(Icons.more_vert, color: colors.icon1),
// onPressed: () {},
// ),
// ),
// ),
// ),
// ),
// ),
