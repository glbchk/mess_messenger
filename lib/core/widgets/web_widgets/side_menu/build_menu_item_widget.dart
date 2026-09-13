import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/menu_entry.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

Widget buildMenuItem({
  //TODO: NEED TO CHANGE TO WIDGET
  required BuildContext context,
  required MenuItem item,
  required String selectedId,
  required VoidCallback onTap,
  required bool isExpanded,
  required Duration menuDuration,
}) {
  final colors = context.colors;
  final textTheme = context.textStyles;
  final isSelected = selectedId == item.id;

  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? colors.surface4 : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: .max,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 35),
            child: MessIcon(item.iconPath),
          ),
          if (isExpanded) AppSpacing.p24.gapH,
          Flexible(
            child: ClipRect(
              child: AnimatedAlign(
                duration: menuDuration,
                curve: Curves.easeInOut,
                alignment: .centerLeft,
                widthFactor: isExpanded ? 1.0 : 0.0,
                child: Text(
                  item.label,
                  style: textTheme.bodyLarge?.copyWith(
                    color: isSelected ? colors.text1 : colors.text2,
                    fontWeight: isSelected ? .w600 : .normal,
                  ),
                  overflow: .clip,
                  softWrap: false,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
