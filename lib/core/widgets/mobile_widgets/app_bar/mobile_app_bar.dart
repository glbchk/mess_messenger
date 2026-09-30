import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? extendBodyBehindAppBar;
  final bool? resizeToAvoidBottomInset;

  final double? toolBarHeight;
  final bool showAppBarContent;
  final bool showBackButton;
  final String? userName;
  final String? userEmail;
  final String? userPhoneNumber;
  final String? appBarUserPhotoPath;
  final String? title;
  final bool? centerTitle;
  final TextStyle? titleTextStyle;
  final Color? titleColor;
  final Color? foregroundColor;
  final Color? appBarBackgroundColor;
  final Color? shadowColor;
  final List<Widget>? actions;
  final VoidCallback? onPressedBack;
  final bool? showBottomLine;
  final VoidCallback? onPressedViewProfile;

  const MobileAppBar({
    super.key,
    this.extendBodyBehindAppBar,
    this.resizeToAvoidBottomInset,
    this.toolBarHeight,
    required this.showAppBarContent,
    this.showBackButton = false,
    this.userName,
    this.userEmail,
    this.userPhoneNumber,
    this.appBarUserPhotoPath,
    this.title,
    this.centerTitle,
    this.titleTextStyle,
    this.titleColor,
    this.foregroundColor,
    this.appBarBackgroundColor,
    this.shadowColor,
    this.actions,
    this.onPressedBack,
    this.showBottomLine,
    this.onPressedViewProfile,
  });

  @override
  Size get preferredSize => Size.fromHeight(toolBarHeight ?? 72);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final currentHeight = toolBarHeight ?? 72;

    return AppBar(
      backgroundColor: appBarBackgroundColor ?? colors.surface0,
      surfaceTintColor: colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      toolbarHeight: currentHeight,
      leading: showAppBarContent == true || showBackButton == true
          ? Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: MessIconButton(
                SvgIcons.arrowLeft,
                isButtonFilled: true,
                borderWidth: 0,
                onPressed: onPressedBack,
              ),
            )
          : null,
      title: showAppBarContent == true
          ? GestureDetector(
              onTap: onPressedViewProfile,
              child: Row(
                spacing: 12,
                children: [
                  UserAvatarWidget(
                    userName: userName ?? 'Joe Doe',
                    photoPath: appBarUserPhotoPath,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          userName ?? 'Some Cool Name',
                          style: textTheme.headlineMedium?.copyWith(
                            color: colors.text1,
                          ),
                          maxLines: 1,
                          overflow: .ellipsis,
                        ),
                        Text(
                          userPhoneNumber != null
                              ? userPhoneNumber ?? ''
                              : userEmail ?? '',
                          style: textTheme.bodyLarge?.copyWith(
                            color: colors.text2,
                          ),
                          maxLines: 1,
                          overflow: .ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Text(
              title ?? '',
              style: textTheme.displaySmall?.copyWith(
                color: titleColor ?? colors.text1,
              ),
            ),
      centerTitle: showAppBarContent == true ? null : false,
      actions: actions,
      bottom: showBottomLine == true
          ? PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(color: colors.border2, height: 1.0),
            )
          : null,
    );
  }
}
