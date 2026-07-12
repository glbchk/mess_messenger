import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class UserDataContentWidget extends StatelessWidget {
  final UserModel? userData;
  final String? profileImagePath;

  const UserDataContentWidget({
    super.key,
    this.userData,
    this.profileImagePath,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // User Avatar
        Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            color: colors.surface0,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colors.surface4,
                blurRadius: 0,
                spreadRadius: 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundColor: colors.surface4, // Light blue background
            child: profileImagePath == null
                ? Text(
                    userData?.name?.substring(0, 1) ?? '?',
                    style: textTheme.headlineLarge?.copyWith(
                      color: colors.text1,
                    ),
                  )
                : UserAvatarWidget(
                    userName: userData?.name ?? '',
                    photoPath: profileImagePath ?? 'No path found',
                  ),
          ),
        ),
        AppSpacing.p16.gapH,
        // User Name and Number
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text(
              userData?.name ?? 'No name was found',
              style: textTheme.displaySmall?.copyWith(color: colors.text1),
            ),
            Text(
              '+447903754798',
              // userData?.phoneNumber ?? '+447903754798',
              style: textTheme.bodyLarge?.copyWith(color: colors.text2),
            ),
          ],
        ),
      ],
    );
  }
}
