import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const MessNavigationBar({
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
        padding: EdgeInsets.only(
          top: 16.0,
          bottom: MediaQuery.paddingOf(context).bottom + 4.0,
        ),
        decoration: BoxDecoration(
          color: colors.surface0,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: SvgPicture.asset(
                  context.icons.logo,
                  height: 40,
                  width: 40,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildNavItem(context.icons.chats, 1, context),
                    ),
                    Expanded(
                      child: _buildNavItem(context.icons.phone, 2, context),
                    ),
                    Expanded(
                      child: _buildNavItem(context.icons.contacts, 3, context),
                    ),
                    Expanded(
                      child: _buildNavItem(context.icons.settings, 4, context),
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
