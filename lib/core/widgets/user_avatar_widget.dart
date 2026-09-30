import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class UserAvatarWidget extends StatelessWidget {
  final String userName;
  final double? size;
  final String? photoPath;
  final String? testingPhotoPath;
  final double borderWidth;
  final bool isOnline;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? backgroundColor;

  const UserAvatarWidget({
    super.key,
    required this.userName,
    this.size,
    this.photoPath,
    this.testingPhotoPath,
    this.borderWidth = 3.0,
    this.isOnline = false,
    this.onPressed,
    this.textStyle,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final hasPhoto = photoPath?.isNotEmpty ?? false;
    final initial = userName.isNotEmpty ? userName.substring(0, 1) : '?';
    final effectiveSize = size ?? 48;

    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        clipBehavior: .none,
        children: [
          Container(
            height: effectiveSize,
            width: effectiveSize,
            decoration: BoxDecoration(
              color: backgroundColor ?? colors.border2,
              shape: .circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(borderWidth),
              child: CircleAvatar(
                radius: (effectiveSize / 2) - borderWidth,
                backgroundColor: backgroundColor ?? colors.textInverse,
                backgroundImage: hasPhoto
                    ? NetworkImage(photoPath ?? '')
                    : testingPhotoPath != null
                    ? AssetImage(testingPhotoPath ?? '')
                    : null,
                child: hasPhoto
                    ? null
                    : Center(
                        child: Text(
                          initial,
                          style:
                              textStyle ??
                              textTheme.headlineLarge?.copyWith(
                                color: textColor ?? colors.text1,
                              ),
                        ),
                      ),
              ),
            ),
          ),

          if (isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(color: colors.bg, shape: .circle),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: colors.successColor,
                      shape: .circle,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
