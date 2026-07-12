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

    return Container(
      height: size ?? 48,
      width: size ?? 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: colors.surface4,
      ),
      child: photoPath != null
          ? Padding(
              padding: const EdgeInsets.all(3.0),
              child: ClipOval(child: Image.asset(photoPath ?? '')),
            )
          : Center(child: Text(userName.substring(0, 1))),
    );
  }
}
