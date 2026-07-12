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
  final String? iconPath;
  final Color? iconColor;
  // final Color? textColor;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? buttonShadow;

  const MessMainButton({
    super.key,
    required this.label,
    this.height,
    this.width,
    this.onPressed,
    this.isLoading,
    this.iconPath,
    this.iconColor,
    // this.textColor,
    this.textStyle,
    this.backgroundColor,
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
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? colors.text1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: iconPath != null ? AppSpacing.p12 : 0,
          children: [
            iconPath != null
                ? MessIcon(iconPath ?? '')
                : SpacingModifier.empty(),
            Text(
              label,
              style:
                  textStyle ??
                  textTheme.labelLarge?.copyWith(color: colors.textInverse),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
