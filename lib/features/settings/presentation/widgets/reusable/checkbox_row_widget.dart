import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CheckboxRowWidget extends StatelessWidget {
  final String title;
  final bool isChecked;
  final VoidCallback onTap;

  const CheckboxRowWidget({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final bp = ResponsiveBreakpoints.of(context);
    final isWide = bp.isDesktop || bp.isTablet;

    return GestureDetector(
      onTap: onTap,
      behavior: .opaque,
      child: Flex(
        direction: isWide ? .horizontal : .vertical,
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              MessIcon(
                isChecked ? SvgIcons.checkboxChecked : SvgIcons.checkbox,
                color: isChecked ? colors.icon1 : colors.text2,
                size: 20,
              ),
              AppSpacing.p8.gapH,
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(color: colors.text1),
              ),
            ],
          ),
        ],
      ),
      // bp.isMobile
      // ? Row(
      //     spacing: 8,
      //     children: [
      //       MessIcon(
      //         isChecked ? SvgIcons.checkboxChecked : SvgIcons.checkbox,
      //         color: isChecked ? colors.icon1 : colors.text2,
      //         size: 20,
      //       ),
      //       Text(
      //         title,
      //         style: textTheme.bodyMedium?.copyWith(color: colors.text1),
      //       ),
      //     ],
      //   )
      // : Row(
      //     mainAxisSize: .min,
      //     children: [
      //       MessIcon(
      //         isChecked ? SvgIcons.checkboxChecked : SvgIcons.checkbox,
      //         color: isChecked ? colors.icon1 : colors.text2,
      //         size: 20,
      //       ),
      //       AppSpacing.p8.gapH,
      //       Text(
      //         title,
      //         style: textTheme.bodyLarge?.copyWith(color: colors.text1),
      //       ),
      //     ],
      //   ),
    );
  }
}
