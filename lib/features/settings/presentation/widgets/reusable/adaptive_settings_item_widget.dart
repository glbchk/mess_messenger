import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AdaptiveSettingsItemWidget extends StatelessWidget {
  final String label;
  final Color? textColor;
  final Widget control;
  final double? labelWidth;

  const AdaptiveSettingsItemWidget({
    super.key,
    required this.label,
    this.textColor,
    required this.control,
    this.labelWidth,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final bp = ResponsiveBreakpoints.of(context);
    final isWide = bp.isDesktop || bp.isTablet;
    final safeLabelWidth =
        labelWidth ?? (bp.screenWidth * 0.2).clamp(150.0, 300.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Flex(
        direction: isWide ? .horizontal : .vertical,
        crossAxisAlignment: .start,
        children: [
          SizedBox(
            width: isWide ? safeLabelWidth : double.infinity,
            child: Padding(
              padding: EdgeInsets.only(bottom: isWide ? 0 : 12.0),
              child: Text(
                label,
                style: textTheme.titleMedium?.copyWith(
                  color: textColor ?? colors.text2,
                ),
              ),
            ),
          ),

          Expanded(
            flex: isWide ? 1 : 0,
            child: Align(alignment: .centerLeft, child: control),
          ),
        ],
      ),
    );
  }
}
