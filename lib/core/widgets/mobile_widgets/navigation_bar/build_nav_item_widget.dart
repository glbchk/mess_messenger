import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

Widget buildNavItem({
  required String icon,
  required int index,
  required BuildContext context,
  required int selectedIndex,
  required ValueChanged<int> onTap,
}) {
  final isSelected = selectedIndex == index;
  final colors = context.colors;

  return GestureDetector(
    onTap: () => onTap(index),
    behavior: HitTestBehavior.opaque,
    child: Align(
      child: Container(
        width: 56,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? colors.textInverse : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(child: MessIcon(icon, size: 24)),
      ),
    ),
  );
}
