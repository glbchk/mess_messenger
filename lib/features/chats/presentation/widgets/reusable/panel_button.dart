import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class PanelButton extends StatelessWidget {
  final String label;
  final String svgAsset;
  final double iconSize;
  final Color? iconColor;
  final double buttonSize;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  const PanelButton(
    this.svgAsset, {
    super.key,
    required this.label,
    this.iconSize = 24,
    this.iconColor,
    this.buttonSize = 44,
    this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onPressed,
      child: Column(
        spacing: 16,
        children: [
          Container(
            height: buttonSize,
            width: buttonSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: backgroundColor ?? colors.surface2,
            ),
            child: Center(
              child: MessIcon(svgAsset, size: iconSize, color: iconColor),
            ),
          ),
          Text(label),
        ],
      ),
    );
  }
}
