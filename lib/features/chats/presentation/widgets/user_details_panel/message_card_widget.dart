import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/user_data_content_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessageCardWidget extends StatelessWidget {
  final UserModel? otherUserData;
  final String? profileImagePath;
  final double? avatarSize;
  final TextStyle? titleSize;
  final Color? titleColor;
  final TextStyle? subtitleSize;
  final Color? subtitleColor;
  final bool? isEnabledIconButton;
  final VoidCallback? onPressedFavorites;
  final MainAxisAlignment? mainAxisAlignment;

  const MessageCardWidget({
    super.key,
    this.otherUserData,
    this.profileImagePath,
    this.avatarSize,
    this.titleSize,
    this.titleColor,
    this.subtitleSize,
    this.subtitleColor,
    this.isEnabledIconButton = false,
    this.onPressedFavorites,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colors.bg,
            borderRadius: BorderRadius.all(Radius.circular(24)),
            border: BoxBorder.all(color: colors.border2),
          ),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              UserDataContentWidget(
                otherUserData: otherUserData,
                profileImagePath: profileImagePath,
                avatarSize: 40,
                titleSize: textTheme.titleMedium,
                titleColor: colors.text1,
                subtitleSize: textTheme.bodyMedium,
                subtitleColor: colors.text2,
                mainAxisAlignment: .start,
              ),
              AppSpacing.p16.gapV,
              Text(
                'Take a look at my latest design exploration about article detail page. On this exploration I create a UI for detail page of article website.',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),

        Positioned(
          top: 24,
          right: 24,
          child: MessIconButton(
            SvgIcons.favoritesFilled,
            onPressed: onPressedFavorites,
            iconSize: 16,
            iconColor: colors.icon3,
            buttonSize: 32,
          ),
        ),
      ],
    );
  }
}
