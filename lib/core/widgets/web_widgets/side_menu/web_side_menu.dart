import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/menu_entry.dart';
import 'package:mess_messenger_app/features/profile/data/models/user_model.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class WebSideMenu extends StatefulWidget {
  final UserModel userData;

  const WebSideMenu({super.key, required this.userData});

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
                      child: MessIcon(
                        SvgIcons.logo,
                        size: 28,
                        color: Colors.red,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 150),
                      opacity: _isHovered ? 1.0 : 0.0,
                      child: MessIcon(SvgIcons.menu, size: 28),
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

  Widget buildMenuItem(MenuItem item) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final isSelected = _selectedId == item.id;

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
              child: MessIcon(item.iconPath),
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

    final l10n = AppLocalizations.of(context)!;

    final List<MenuEntry> _menuItems = [
      MenuItem(id: 'chats', iconPath: SvgIcons.chats, label: l10n.chats),
      MenuItem(id: 'calls', iconPath: SvgIcons.calls, label: l10n.calls),
      MenuItem(
        id: 'contacts',
        iconPath: SvgIcons.contacts,
        label: l10n.contacts,
      ),
      const FlexSpacer(),
      MenuItem(
        id: 'favorites',
        iconPath: SvgIcons.favorites,
        label: l10n.favorites,
      ),
      MenuItem(id: 'archive', iconPath: SvgIcons.archive, label: l10n.archive),
      MenuItem(
        id: 'settings',
        iconPath: SvgIcons.settings,
        label: l10n.settings,
      ),
      const ColumnExtension(),
    ];

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
                MenuItem() => buildMenuItem(entry),
                FlexSpacer() => const Spacer(),
                ColumnExtension() => Column(
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
                          UserAvatarWidget(
                            userName:
                                widget.userData.email ?? 'Joe Doe', //'Joe Doe',
                            photoPath:
                                'assets/images/user_images/avatar_image.png',
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
                                  children: [
                                    Text(
                                      widget.userData.email ?? 'Joe Doe',
                                      overflow: TextOverflow.clip,
                                      softWrap: false,
                                    ),
                                    const Text(
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
          ],
        ),
      ),
    );
  }
}
