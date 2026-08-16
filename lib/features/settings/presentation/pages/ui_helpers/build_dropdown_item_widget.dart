import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/ui_helpers/fade_animation.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class BuildDropdownItemWidget extends StatelessWidget {
  final String value;
  final String selectedValue;
  final double constraintSize;
  final Color? textColor;
  final VoidCallback onPressed;

  const BuildDropdownItemWidget({
    super.key,
    required this.value,
    required this.selectedValue,
    required this.constraintSize,
    this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final isSelected = selectedValue == value;

    return SizedBox(
      width: constraintSize,
      child: FadeInMenuItem(
        child: MenuItemButton(
          style: MenuItemButton.styleFrom(
            backgroundColor: colors.bg,
            overlayColor: colors.surface4,
            minimumSize: const Size.fromHeight(50),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onPressed: onPressed,
          child: Row(
            children: [
              Text(
                value,
                style: textTheme.bodyLarge?.copyWith(
                  color: textColor ?? colors.text1,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              const Spacer(),
              if (isSelected) MessIcon(SvgIcons.verifiedCheckmark),
            ],
          ),
        ),
      ),
    );
  }
}
