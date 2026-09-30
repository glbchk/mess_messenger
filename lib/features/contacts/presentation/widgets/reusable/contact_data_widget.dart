import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ContactDataWidget extends StatelessWidget {
  final UserModel? otherUserData;
  final String? photoPath; //Temporary property
  final String? iconPath;
  final String title;
  final String subtitle;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  const ContactDataWidget({
    super.key,
    this.otherUserData,
    this.photoPath,
    this.iconPath,
    required this.title,
    required this.subtitle,
    this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          color: colors.transparent,
          child: Row(
            spacing: 8,
            children: [
              SizedBox(
                width: 32,
                height: 32,
                child: CircleAvatar(
                  backgroundColor: backgroundColor ?? colors.transparent,
                  child: iconPath != null
                      ? Center(child: MessIcon(iconPath ?? '', size: 20))
                      : UserAvatarWidget(
                          userName: 'Some name',
                          testingPhotoPath:
                              photoPath, //otherUserData?.avatarUrl ?? 'No path found',
                        ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        color: colors.text1,
                      ),
                      maxLines: 1,
                      overflow: .ellipsis,
                    ),
                    Text(
                      subtitle,
                      style: textTheme.bodySmall?.copyWith(color: colors.text2),
                      maxLines: 1,
                      overflow: .ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
