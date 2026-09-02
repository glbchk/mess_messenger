import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class UserAvatarWidget extends StatelessWidget {
  final String userName;
  final double? size;
  final String? photoPath;
  final double borderWidth;

  const UserAvatarWidget({
    super.key,
    required this.userName,
    this.size,
    this.photoPath,
    this.borderWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final hasPhoto = photoPath?.isNotEmpty ?? false;
    final initial = userName.isNotEmpty ? userName.substring(0, 1) : '?';
    final effectiveSize = size ?? 48;

    return Container(
      height: effectiveSize,
      width: effectiveSize,
      decoration: BoxDecoration(color: colors.surface4, shape: BoxShape.circle),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: CircleAvatar(
          radius: (effectiveSize / 2) - borderWidth,
          backgroundColor: colors.surface4,
          backgroundImage: hasPhoto ? NetworkImage(photoPath ?? '') : null,
          child: hasPhoto
              ? null
              : Center(
                  child: Text(
                    initial,
                    style: textTheme.headlineLarge?.copyWith(
                      color: colors.text1,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
