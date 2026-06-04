import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/color_extension.dart';

class MessMainButton extends StatelessWidget {
  final String label;
  final double? width;
  final VoidCallback? onPressed;
  final bool? isLoading;
  final Icon? icon;
  final Color? iconColor;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? buttonShadow;

  const MessMainButton({
    super.key,
    required this.label,
    this.width,
    this.onPressed,
    this.isLoading,
    this.icon,
    this.iconColor,
    this.textColor,
    this.backgroundColor,
    this.buttonShadow,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: width ?? double.infinity,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: buttonShadow ?? colors.text1.withAlpha(76),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: FilledButton.icon(
        icon: icon,
        label: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor ?? colors.textInverse,
          ),
        ),
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? colors.text1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ),
    );
  }
}
