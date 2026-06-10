import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/utils/spacing/spacing_modifier.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessMainButton extends StatelessWidget {
  final String label;
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

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: backgroundColor ?? colors.text1,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.p12,
          children: [
            iconPath != null
                ? SvgPicture.asset(iconPath ?? '')
                : SpacingModifier.empty(),
            Text(
              label,
              style:
                  textStyle ??
                  textTheme.labelLarge?.copyWith(color: colors.textInverse),
            ),
          ],
        ),
      ),
    );
  }
}
