import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

Widget buildHeader({
  required BuildContext context,
  required VoidCallback toggle,
  required VoidCallback onEnter,
  required VoidCallback onExit,
  required bool isExpanded,
  required bool isHovered,
}) {
  final colors = context.colors;
  final textTheme = context.textStyles;

  return GestureDetector(
    onTap: toggle,
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => onEnter, //setState(() => _isHovered = true),
      onExit: (_) => onExit, //setState(() => _isHovered = false),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Fixed icon area
            Padding(
              padding: EdgeInsets.only(left: 32),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 150),
                    opacity: isHovered ? 0.0 : 1.0,
                    child: MessIcon(SvgIcons.logo, size: 28),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 150),
                    opacity: isHovered ? 1.0 : 0.0,
                    child: MessIcon(SvgIcons.menu, size: 28),
                  ),
                ],
              ),
            ),

            if (isExpanded) AppSpacing.p24.gapH,
            // Label — ClipRect hides it when collapsed
            Flexible(
              child: ClipRect(
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                  alignment: Alignment.centerLeft,
                  widthFactor: isExpanded ? 1.0 : 0.0,
                  child: Text(
                    'Mess Messenger',
                    style: textTheme.headlineLarge?.copyWith(
                      color: colors.text1,
                    ),
                    overflow: TextOverflow.clip,
                    softWrap: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
