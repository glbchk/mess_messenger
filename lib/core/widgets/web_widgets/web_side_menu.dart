import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class WebSideMenu extends StatefulWidget {
  const WebSideMenu({super.key});

  @override
  State<WebSideMenu> createState() => _WebSideMenuState();
}

class _WebSideMenuState extends State<WebSideMenu>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isHovered = false;
  String _selectedId = 'chats';

  final double _collapsedWidth = 120;
  final double _expandedWidth = 300;

  static const Duration _menuDuration = Duration(milliseconds: 150);

  final List<_MenuEntry> _menuItems = const [
    _MenuItem(
      id: 'chats',
      iconPath: 'assets/icons/nav_bar/chats_light.svg',
      label: 'Chats',
    ),
    _MenuItem(
      id: 'calls',
      iconPath: 'assets/icons/nav_bar/phone_light.svg',
      label: 'Calls',
    ),
    _MenuItem(
      id: 'contacts',
      iconPath: 'assets/icons/nav_bar/contacts_light.svg',
      label: 'Contacts',
    ),
    _FlexSpacer(),
    _MenuItem(
      id: 'favorites',
      iconPath: 'assets/icons/favorites.svg',
      label: 'Favorites',
    ),
    _MenuItem(
      id: 'archive',
      iconPath: 'assets/icons/archive.svg',
      label: 'Archive',
    ),
    _MenuItem(
      id: 'settings',
      iconPath: 'assets/icons/settings.svg',
      label: 'Settings',
    ),
    // _MenuItem(id: 'user', accountName: 'S', label: 'User Name'),
    _ColumnExtension(),
  ];

  void _toggle() => setState(() => _isExpanded = !_isExpanded);

  Widget buildHeader() {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return GestureDetector(
      onTap: _toggle,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
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
                // 24 margins + 1 safety pixel
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 150),
                      opacity: _isHovered ? 0.0 : 1.0,
                      child: SvgPicture.asset(
                        'assets/icons/mess_logo_light.svg',
                        height: 28,
                        width: 28,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 150),
                      opacity: _isHovered ? 1.0 : 0.0,
                      child: SvgPicture.asset(
                        'assets/icons/menu.svg',
                        height: 28,
                        width: 28,
                      ),
                    ),
                  ],
                ),
              ),

              if (_isExpanded) const SizedBox(width: 24),

              // Label — ClipRect hides it when collapsed
              Flexible(
                child: ClipRect(
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeInOut,
                    alignment: Alignment.centerLeft,
                    widthFactor: _isExpanded ? 1.0 : 0.0,
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

  Widget buildMenuItem(_MenuItem item) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final isSelected = _selectedId == item.id;

    // final item = items[index];
    // final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedId = item.id),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? colors.surface4 : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 35),
              child: SvgPicture.asset(item.iconPath, height: 24, width: 24),
            ),
            if (_isExpanded) const SizedBox(width: 24),
            Flexible(
              child: ClipRect(
                child: AnimatedAlign(
                  duration: _menuDuration,
                  curve: Curves.easeInOut,
                  alignment: Alignment.centerLeft,
                  widthFactor: _isExpanded ? 1.0 : 0.0,
                  child: Text(
                    item.label,
                    style: textTheme.bodyLarge?.copyWith(
                      color: isSelected ? colors.text1 : colors.text2,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                    overflow: TextOverflow.clip,
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

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return AnimatedContainer(
      duration: _menuDuration,
      curve: Curves.easeInOut,
      width: _isExpanded ? _expandedWidth : _collapsedWidth,
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────
            buildHeader(),

            const SizedBox(height: 8),

            // ── Nav Items ───────────────────────────────────
            for (final entry in _menuItems)
              switch (entry) {
                _MenuItem() => buildMenuItem(entry),
                _FlexSpacer() => const Spacer(),
                _ColumnExtension() => Column(
                  // crossAxisAlignment: _isExpanded
                  //     ? CrossAxisAlignment.start
                  //     : CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    AppSpacing.p28.gapV,
                    Padding(
                      padding: EdgeInsets.only(left: 33),
                      child: Row(
                        children: [
                          Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              color: colors.surface4,
                            ),
                            child: Center(
                              child: Text(
                                'S',
                              ), //SvgPicture.asset(iconPath, height: 20, width: 20),
                            ),
                          ),
                          if (_isExpanded) const SizedBox(width: 12),
                          Flexible(
                            // 👈 replaces the ternary
                            child: ClipRect(
                              child: AnimatedAlign(
                                duration: _menuDuration,
                                curve: Curves.easeInOut,
                                alignment: Alignment.centerLeft,
                                widthFactor: _isExpanded ? 1.0 : 0.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                      'Joe Doe',
                                      overflow: TextOverflow.clip,
                                      softWrap: false,
                                    ),
                                    Text(
                                      'fake@email.com',
                                      overflow: TextOverflow.clip,
                                      softWrap: false,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              },

            //   if (item.label == 'Contacts') {
            //     return Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         menuItem,
            //         const SizedBox(height: double.infinity),
            //       ],
            //     );
            //   }
            //
            //   return menuItem;
            // }),
            // const Spacer(),
            //
            // ...List.generate(
            //   _bottomItems.length,
            //   (index) => buildMenuItem(_bottomItems, index),
            // ),

            // Padding(padding: const EdgeInsets.all(16), child: Text('New Icon')),
          ],
        ),
      ),
    );
  }
}

sealed class _MenuEntry {
  const _MenuEntry();
}

class _MenuItem extends _MenuEntry {
  final String id;
  final String iconPath;
  // final String? accountName;
  final String label;
  const _MenuItem({
    required this.id,
    required this.iconPath,
    // this.accountName,
    required this.label,
  });
}

class _FlexSpacer extends _MenuEntry {
  const _FlexSpacer();
}

class _ColumnExtension extends _MenuEntry {
  const _ColumnExtension();
}

// class _NavItem {
//   final String iconPath;
//   final String label;
//   const _NavItem({required this.iconPath, required this.label});
// }
