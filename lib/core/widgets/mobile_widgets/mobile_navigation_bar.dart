import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MobileNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const MobileNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ColoredBox(
      color: colors.surface0,
      child: Container(
        padding: EdgeInsets.only(top: 8.0, bottom: 10),
        decoration: BoxDecoration(
          color: colors.surface0,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SizedBox(
          height: 76,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: SvgPicture.asset(SvgIcons.logo, height: 40, width: 40),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: _buildNavItem(SvgIcons.chats, 1, context)),
                    Expanded(child: _buildNavItem(SvgIcons.calls, 2, context)),
                    Expanded(
                      child: _buildNavItem(SvgIcons.contacts, 3, context),
                    ),
                    Expanded(
                      child: _buildNavItem(SvgIcons.settings, 4, context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, int index, BuildContext context) {
    final isSelected = selectedIndex == index;
    final colors = context.colors;

    return GestureDetector(
      onTap: () => onItemTapped(index),
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
          child: Center(child: SvgPicture.asset(icon, height: 24, width: 24)),
        ),
      ),
    );
  }
}
