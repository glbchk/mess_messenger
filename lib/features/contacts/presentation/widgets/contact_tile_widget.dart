import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ContactTileWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: colors.transparent,
        height: 56,
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
              child: UserAvatarWidget(userName: title, photoPath: photoPath),
            ),
            Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 1,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(color: colors.text1),
                ),
                Text(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(color: colors.text2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Row(
// spacing: 12,
// children: [
// UserAvatarWidget(
// userName: appBarUserName ?? 'Joe Doe',
// photoPath: appBarUserPhotoPath,
// ),
// Column(
// crossAxisAlignment: .start,
// children: [
// Text(
// appBarUserName ?? 'Some Cool Name',
// style: textTheme.headlineMedium?.copyWith(
// color: colors.text1,
// ),
// ),
// Text(
// appBarPhoneNumber ?? '+419901250285',
// style: textTheme.bodyLarge?.copyWith(
// color: colors.text2,
// ),
// ),
// ],
// ),
// ],
// )
