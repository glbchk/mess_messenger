import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/build_header_widget.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/build_menu_item_widget.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/menu_entry.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<MenuEntry> menuItems = [
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
            buildHeader(
              context: context,
              toggle: () => _toggle(),
              onEnter: () => setState(() => _isHovered = true),
              onExit: () => setState(() => _isHovered = false),
              isExpanded: _isExpanded,
              isHovered: _isHovered,
            ),

            AppSpacing.p8.gapV,

            // ── Nav Items ───────────────────────────────────
            for (final entry in menuItems)
              switch (entry) {
                MenuItem() => buildMenuItem(
                  context: context,
                  item: entry,
                  selectedId: _selectedId,
                  onTap: () => setState(() => _selectedId = entry.id),
                  isExpanded: _isExpanded,
                  menuDuration: _menuDuration,
                ),
                FlexSpacer() => const Spacer(),
                ColumnExtension() => Column(
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
                          if (_isExpanded) AppSpacing.p12.gapH,
                          Flexible(
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
                                      widget.userData.name ?? 'Joe Doe',
                                      overflow: TextOverflow.clip,
                                      softWrap: false,
                                    ),
                                    Text(
                                      widget.userData.email ?? 'fake@email.com',
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
