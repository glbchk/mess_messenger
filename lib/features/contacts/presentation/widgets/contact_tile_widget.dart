import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ContactTileWidget extends StatefulWidget {
  final String? photoPath;
  final String contactId;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const ContactTileWidget({
    super.key,
    this.photoPath,
    required this.contactId,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  State<ContactTileWidget> createState() => _ContactTileWidgetState();
}

class _ContactTileWidgetState extends State<ContactTileWidget> {
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
      backgroundColor = colors.surfaceAccent2;
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
            height: 56,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                spacing: 8,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: colors.surface4,
                    ),
                    child: UserAvatarWidget(
                      userName: widget.title,
                      photoPath: widget.photoPath,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: .start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 1,
                    children: [
                      Text(
                        widget.title,
                        style: textTheme.titleMedium?.copyWith(
                          color: colors.text1,
                        ),
                      ),
                      Text(
                        widget.subtitle,
                        style: textTheme.bodySmall?.copyWith(
                          color: colors.text2,
                        ),
                      ),
                    ],
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
