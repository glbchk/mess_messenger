import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessIcon extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color? color;

  const MessIcon(this.svgAsset, {super.key, this.size = 24, this.color});

  @override
  Widget build(BuildContext context) {
    Color? filterColor;

    if (!svgAsset.contains('colored')) {
      filterColor = color ?? context.colors.icon1;
    }

    return SvgPicture.asset(
      svgAsset,
      width: size,
      height: size,
      colorFilter: filterColor != null
          ? ColorFilter.mode(filterColor, BlendMode.srcIn)
          : null,
    );
  }
}
