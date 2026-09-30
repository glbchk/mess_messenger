import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/menu_entry.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MenuItemWidget extends StatelessWidget {
  final MenuItem item;

  final String selectedId;
  final VoidCallback? onTap;
  final bool isExpanded;
  final Duration menuDuration;

  const MenuItemWidget({
    super.key,
    required this.item,
    required this.selectedId,
    this.onTap,
    required this.isExpanded,
    required this.menuDuration,
  });

  @override
  Widget build(BuildContext context) {
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
}
