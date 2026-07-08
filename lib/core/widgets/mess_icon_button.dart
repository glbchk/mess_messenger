import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessIconButton extends StatelessWidget {
  final String svgAsset;
  final double iconSize;
  final double buttonSize;
  final Color? color;
  final VoidCallback? onPressed;

  const MessIconButton(
    this.svgAsset, {
    super.key,
    this.iconSize = 24,
    this.buttonSize = 44,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      shape: CircleBorder(side: BorderSide(color: colors.border2, width: 1.0)),
      color: colors.bg,
      child: InkWell(
        onTap: onPressed,
        hoverColor: colors.surface2,
        splashColor: colors.surface4,
        customBorder: const CircleBorder(),
        child: SizedBox(
          height: buttonSize,
          width: buttonSize,
          child: Center(
            child: SvgPicture.asset(
              svgAsset,
              width: iconSize,
              height: iconSize,
              colorFilter: ColorFilter.mode(
                color ?? context.colors.icon1,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
