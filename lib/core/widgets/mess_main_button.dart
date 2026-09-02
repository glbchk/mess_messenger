import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/utils/spacing/spacing_modifier.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessMainButton extends StatelessWidget {
  final String label;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final bool? isLoading;
  final String? prefixIconPath;
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final String? suffixIconPath;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? hoverColor;
  final Color? buttonShadow;
  final Color? borderColor;

  const MessMainButton({
    super.key,
    required this.label,
    this.height,
    this.width,
    this.onPressed,
    this.isLoading,
    this.prefixIconPath,
    this.prefixIconColor,
    this.prefixIconSize,
    this.suffixIconPath,
    this.suffixIconColor,
    this.suffixIconSize,
    this.textStyle,
    this.textColor,
    this.backgroundColor,
    this.hoverColor,
    this.buttonShadow,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Container(
      width: width ?? double.infinity,
      height: height ?? 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: borderColor != null
            ? Border.all(color: borderColor ?? colors.text1, width: 1)
            : null,
        boxShadow: [
          if (buttonShadow != null)
            BoxShadow(
              color: buttonShadow?.withValues(alpha: 0.1) ?? colors.text1,
              spreadRadius: 4, // Extends the shadow past the box
              blurRadius: 6, // Softens the shadow
              offset: const Offset(0, 2), // Moves shadow x-axis and y-axis
            ),
        ],
      ),
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          // 💡 1. Dynamically swap background color with 0% default transparency
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.hovered) && hoverColor != null) {
              return hoverColor!; // Exact hover color you passed in
            }
            return backgroundColor ?? colors.text1; // Default state
          }),

          // 💡 2. Turn off Material's automatic 8% tint layer completely
          overlayColor: WidgetStatePropertyAll(colors.transparent),

          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIconPath != null
                ? MessIcon(prefixIconPath ?? '', size: prefixIconSize ?? 0)
                : SpacingModifier.empty(),
            prefixIconPath != null
                ? AppSpacing.p8.gapH
                : SpacingModifier.empty(),
            Text(
              label,
              style:
                  textStyle ??
                  textTheme.labelLarge?.copyWith(
                    color: textColor ?? colors.textInverse,
                  ),
              textAlign: TextAlign.center,
            ),
            suffixIconPath != null
                ? AppSpacing.p8.gapH
                : SpacingModifier.empty(),
            suffixIconPath != null
                ? MessIcon(suffixIconPath ?? '', size: suffixIconSize ?? 0)
                : SpacingModifier.empty(),
          ],
        ),
      ),
    );
  }
}
