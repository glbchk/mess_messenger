import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SupportRequest {
  final String name;
  final String date;

  SupportRequest({required this.name, required this.date});
}

class DetailsContentWidget extends StatelessWidget {
  final UserModel? userData;
  final String? title;
  final String? label;
  final VoidCallback onPressed;
  final bool showBackButton;
  final VoidCallback? onBackButtonPressed;
  final List<String>? tags;
  final List<String>? assigned;
  final List<SupportRequest>? pastRequests;

  const DetailsContentWidget({
    super.key,
    this.userData,
    this.title,
    this.label,
    required this.onPressed,
    this.showBackButton = false,
    this.onBackButtonPressed,
    this.tags,
    this.assigned,
    this.pastRequests,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Container(
      // height: 112,
      decoration: BoxDecoration(
        // color: Colors.red, //colors.transparent,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Row(
            children: [
              Text(
                title?.toUpperCase() ?? 'Tags'.toUpperCase(),
                style: textTheme.bodySmall?.copyWith(
                  color: context.colors.text1,
                ),
              ),
              Spacer(),
              if (label != null)
                GestureDetector(
                  onTap: onPressed,
                  child: Text(
                    label ?? 'Edit',
                    style: textTheme.labelSmall?.copyWith(
                      color: context.colors.link,
                    ),
                  ),
                ),
            ],
          ),

          Row(
            spacing: 4,
            children: [
              if (tags?.isNotEmpty ?? false) ...[
                for (final tag in tags ?? <String>[]) Chip(label: Text(tag)),
              ],
            ],
          ),

          Row(
            spacing: 8,
            children: [
              if (assigned?.isNotEmpty ?? false) ...[
                for (final entry in (assigned ?? <String>[]).asMap().entries)
                  Transform.translate(
                    offset: Offset(-entry.key * 18.0, 0),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: colors.surface4,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: colors.textInverse,
                        child: Text(entry.value.substring(0, 1)),
                      ),
                    ),
                  ),
              ],
            ],
          ),

          if (userData != null) ...[
            Column(
              children: [
                Row(
                  spacing: 8,
                  children: [
                    UserAvatarWidget(
                      userName: userData?.name ?? 'Joe Doe', //'Joe Doe',
                      photoPath:
                          userData?.avatarUrl ??
                          'assets/images/user_images/avatar_image.png',
                    ),
                    Flexible(
                      child: ClipRect(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              userData?.name ?? 'Joe Doe',
                              overflow: TextOverflow.clip,
                              softWrap: false,
                            ),
                            Text(
                              userData?.email ?? 'fake@email.com',
                              overflow: TextOverflow.clip,
                              softWrap: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],

          if (pastRequests?.isNotEmpty ?? false) ...[
            Row(
              spacing: 12,
              children: [
                MessIconButton(SvgIcons.send),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text('How to restore a deleted conversation?'),
                    Text('Help from support community'),
                  ],
                ),
              ],
            ),
          ],

          AppSpacing.p28.gapV,
        ],
      ),
    );
  }
}
