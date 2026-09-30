import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/navigation_bar/build_nav_item_widget.dart';
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

    final List<String> icons = [
      SvgIcons.chats,
      SvgIcons.calls,
      SvgIcons.contacts,
      SvgIcons.settings,
    ];

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
            mainAxisAlignment: .start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: MessIcon(SvgIcons.logo, size: 40),
              ),
              Expanded(
                child: Row(
                  children: [
                    for (int i = 0; i < 4; i++)
                      Expanded(
                        child: NavItemWidget(
                          icon: icons[i],
                          index: i,
                          selectedIndex: selectedIndex,
                          onTap: (int index) {
                            onItemTapped(index);
                          },
                        ),
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
}
