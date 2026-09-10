import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class UserDataContentWidget extends StatelessWidget {
  final UserModel? otherUserData;
  final String? profileImagePath;
  final double? avatarSize;
  final TextStyle? titleSize;
  final Color? titleColor;
  final TextStyle? subtitleSize;
  final Color? subtitleColor;
  final MainAxisAlignment? mainAxisAlignment;

  const UserDataContentWidget({
    super.key,
    this.otherUserData,
    this.profileImagePath,
    this.avatarSize,
    this.titleSize,
    this.titleColor,
    this.subtitleSize,
    this.subtitleColor,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Row(
      mainAxisAlignment: mainAxisAlignment ?? .center,
      children: [
        // User Avatar
        Container(
          height: avatarSize ?? 64,
          width: avatarSize ?? 64,
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
            backgroundColor: colors.textInverse,
            child: profileImagePath == null
                ? Text(
                    otherUserData?.name?.substring(0, 1) ?? '?',
                    style: textTheme.headlineLarge?.copyWith(
                      color: colors.text1,
                    ),
                  )
                : UserAvatarWidget(
                    userName: otherUserData?.name ?? '',
                    photoPath: profileImagePath ?? 'No path found',
                  ),
          ),
        ),
        AppSpacing.p16.gapH,
        // User Name and Number
        // Expanded(
        //   child:
        Column(
          crossAxisAlignment: .start,
          spacing: 4,
          children: [
            Text(
              otherUserData?.name ?? 'No name was found',
              style:
                  titleSize ??
                  textTheme.displaySmall?.copyWith(
                    color: titleColor ?? colors.text1,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              otherUserData?.phoneNumber ?? '+447903754798',
              style:
                  subtitleSize ??
                  textTheme.bodyLarge?.copyWith(
                    color: subtitleColor ?? colors.text2,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        // ),
        //
        // if (isEnabledIconButton == true) ...[
        //   Spacer(),
        //   MessIconButton(SvgIcons.favorites, onPressed: onPressedFavorites),
        // ],
      ],
    );
  }
}
