import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/build_header_widget.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/build_menu_item_widget.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/menu_entry.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class WebSideMenu extends ConsumerStatefulWidget {
  const WebSideMenu({super.key});

  @override
  ConsumerState<WebSideMenu> createState() => _WebSideMenuState();
}

class _WebSideMenuState extends ConsumerState<WebSideMenu>
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
    final colors = context.colors;
    final userData = ref.watch(userNotifierProvider).userData;

    final l10n = context.l10n;

    final List<MenuEntry> menuItems = [
      MenuItem(
        id: 'chats',
        iconPath: SvgIcons.chats,
        label: l10n.chats,
        onTap: () {
          context.push(AppRoutes.chats);
        },
      ),
      MenuItem(
        id: 'calls',
        iconPath: SvgIcons.calls,
        label: l10n.calls,
        onTap: () {
          context.push(AppRoutes.calls);
        },
      ),
      MenuItem(
        id: 'contacts',
        iconPath: SvgIcons.contacts,
        label: l10n.contacts,
        onTap: () {
          context.push(AppRoutes.contacts);
        },
      ),
      const FlexSpacer(),
      MenuItem(
        id: 'favorites',
        iconPath: SvgIcons.favorites,
        label: l10n.favorites,
        onTap: () {
          //widget.onPressedFavorites;
        },
      ),
      MenuItem(
        id: 'archive',
        iconPath: SvgIcons.archive,
        label: l10n.archive,
        onTap: () {
          //widget.onPressedArchive;
        },
      ),
      MenuItem(
        id: 'settings',
        iconPath: SvgIcons.settings,
        label: l10n.settings,
        onTap: () {
          context.push(AppRoutes.settings);
          ;
        },
      ),
      const ColumnExtension(),
    ];

    return AnimatedContainer(
      duration: _menuDuration,
      curve: Curves.easeInOut,
      width: _isExpanded ? _expandedWidth : _collapsedWidth,
      color: colors.transparent,
      clipBehavior: .hardEdge,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            buildHeader(
              context: context,
              toggle: () => _toggle(),
              onEnter: () => setState(() => _isHovered = true),
              onExit: () => setState(() => _isHovered = false),
              isExpanded: _isExpanded,
              isHovered: _isHovered,
            ),

            AppSpacing.p8.gapV,

            for (final entry in menuItems)
              switch (entry) {
                MenuItem() => buildMenuItem(
                  context: context,
                  item: entry,
                  selectedId: _selectedId,
                  onTap: () {
                    setState(() => _selectedId = entry.id);
                    entry.onTap.call();
                  },
                  isExpanded: _isExpanded,
                  menuDuration: _menuDuration,
                ),
                FlexSpacer() => const Spacer(),
                ColumnExtension() => Column(
                  children: [
                    AppSpacing.p28.gapV,
                    GestureDetector(
                      onTap: () {
                        context.push(AppRoutes.settings);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 33),
                        child: Row(
                          children: [
                            UserAvatarWidget(
                              userName: userData?.name ?? 'Joe Doe',
                              photoPath:
                                  userData?.avatarUrl ??
                                  'assets/images/user_images/avatar_image.png',
                            ),
                            if (_isExpanded) AppSpacing.p12.gapH,
                            Flexible(
                              child: ClipRect(
                                child: AnimatedAlign(
                                  duration: _menuDuration,
                                  curve: Curves.easeInOut,
                                  alignment: .centerLeft,
                                  widthFactor: _isExpanded ? 1.0 : 0.0,
                                  child: Column(
                                    crossAxisAlignment: .start,
                                    mainAxisSize: .min,
                                    children: [
                                      Text(
                                        userData?.name ?? 'Joe Doe',
                                        overflow: .clip,
                                        softWrap: false,
                                      ),
                                      Text(
                                        userData?.email ?? 'fake@email.com',
                                        overflow: .clip,
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
