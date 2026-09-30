import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

enum SearchResultType { recentSearch, contact, message }

class SearchResultTileWidget extends StatefulWidget {
  final SearchResultType type;
  final String? photoPath;
  final String contactId;
  final String title;
  final VoidCallback onPressed;

  const SearchResultTileWidget({
    super.key,
    required this.type,
    this.photoPath,
    required this.contactId,
    required this.title,
    required this.onPressed,
  });

  @override
  State<SearchResultTileWidget> createState() => _SearchResultTileWidgetState();
}

class _SearchResultTileWidgetState extends State<SearchResultTileWidget> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    Color backgroundColor = colors.transparent;
    if (_isPressed) {
      backgroundColor = colors.surface4;
    } else if (_isHovered) {
      backgroundColor = colors.surface3;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      hitTestBehavior: HitTestBehavior.opaque,
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (_) => setState(() => _isPressed = true),
        onPointerUp: (_) => setState(() => _isPressed = false),
        onPointerCancel: (_) => setState(() => _isPressed = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onPressed,
          child: Container(
            color: backgroundColor,
            height: 48,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                spacing: 8,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: widget.type == SearchResultType.contact
                          ? colors.surface4
                          : colors.transparent,
                    ),
                    child: Center(
                      child: switch (widget.type) {
                        SearchResultType.recentSearch => MessIcon(
                          SvgIcons.recentlyViewed,
                          size: 16,
                        ),
                        SearchResultType.contact => UserAvatarWidget(
                          userName: widget.title,
                          photoPath: widget.photoPath,
                        ),
                        SearchResultType.message => const Center(
                          child: MessIcon(SvgIcons.message),
                        ),
                      },
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: textTheme.titleMedium?.copyWith(
                        color: colors.text1,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
