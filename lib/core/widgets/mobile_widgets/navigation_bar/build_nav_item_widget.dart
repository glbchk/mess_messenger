import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class NavItemWidget extends StatelessWidget {
  final String icon;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const NavItemWidget({
    super.key,
    required this.icon,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;
    final colors = context.colors;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: .opaque,
      child: Align(
        child: Container(
          width: 56,
          height: 44,
          alignment: .center,
          decoration: BoxDecoration(
            color: isSelected ? colors.textInverse : colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(child: MessIcon(icon, size: 24)),
        ),
      ),
    );
  }
}
