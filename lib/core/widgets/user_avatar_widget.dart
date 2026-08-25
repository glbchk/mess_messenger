import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class UserAvatarWidget extends StatelessWidget {
  final String userName;
  final double? size;
  final String? photoPath;

  const UserAvatarWidget({
    super.key,
    required this.userName,
    this.size,
    this.photoPath,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final hasPhoto = photoPath?.isNotEmpty ?? false;
    final initial = userName.isNotEmpty ? userName.substring(0, 1) : '?';

    return Container(
      height: size ?? 48,
      width: size ?? 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: colors.surface4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: CircleAvatar(
          radius: 96,
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
