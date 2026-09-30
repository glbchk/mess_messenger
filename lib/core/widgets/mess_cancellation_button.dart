import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/utils/spacing/spacing_modifier.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessCancellationButton extends StatelessWidget {
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

  const MessCancellationButton({
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
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Container(
      width: width ?? double.infinity,
      height: height ?? 48,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.hovered) && hoverColor != null) {
              return hoverColor!;
            }
            return backgroundColor ?? colors.bg;
          }),

          overlayColor: WidgetStatePropertyAll(colors.surface2),

          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          ),
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            prefixIconPath != null
                ? MessIcon(prefixIconPath ?? '', size: prefixIconSize ?? 24)
                : SpacingModifier.empty(),
            prefixIconPath != null
                ? AppSpacing.p8.gapH
                : SpacingModifier.empty(),
            Text(
              label,
              style:
                  textStyle ??
                  textTheme.labelLarge?.copyWith(
                    color: textColor ?? colors.errorColor,
                  ),
              textAlign: .center,
            ),
            suffixIconPath != null
                ? AppSpacing.p8.gapH
                : SpacingModifier.empty(),
            suffixIconPath != null
                ? MessIcon(suffixIconPath ?? '', size: suffixIconSize ?? 24)
                : SpacingModifier.empty(),
          ],
        ),
      ),
    );
  }
}
