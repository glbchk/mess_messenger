import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SideMenuHeaderWidget extends StatelessWidget {
  final VoidCallback? toggle;
  final VoidCallback? onEnter;
  final VoidCallback? onExit;
  final bool isExpanded;
  final bool isHovered;

  const SideMenuHeaderWidget({
    super.key,
    required this.toggle,
    required this.onEnter,
    required this.onExit,
    required this.isExpanded,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return GestureDetector(
      onTap: toggle,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => onEnter?.call(),
        onExit: (_) => onExit?.call(),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisSize: .max,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 32),
                child: Stack(
                  alignment: .center,
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
              Flexible(
                child: ClipRect(
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeInOut,
                    alignment: .centerLeft,
                    widthFactor: isExpanded ? 1.0 : 0.0,
                    child: Text(
                      'Mess Messenger',
                      style: textTheme.headlineLarge?.copyWith(
                        color: colors.text1,
                      ),
                      overflow: .clip,
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
}
