import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? extendBodyBehindAppBar;
  final bool? resizeToAvoidBottomInset;

  final double? toolBarHeight;
  final bool showAppBarContent;
  final bool showBackButton;
  final UserModel? userData;
  final String? appBarUserPhotoPath;
  final String? title;
  final bool? centerTitle;
  final TextStyle? titleTextStyle;
  final Color? titleColor;
  final Color? foregroundColor;
  final Color? appBarBackgroundColor;
  final Color? shadowColor;
  // final double? blurRadius;
  final List<Widget>? actions;
  // final double? kToolbarHeight;
  final VoidCallback? onPressedBack;
  final bool? showBottomLine;

  const MobileAppBar({
    super.key,
    this.extendBodyBehindAppBar,
    this.resizeToAvoidBottomInset,
    // this.showLeadingIcon = true,
    this.toolBarHeight,
    required this.showAppBarContent,
    this.showBackButton = false,
    this.userData,
    this.appBarUserPhotoPath,
    this.title,
    this.centerTitle,
    this.titleTextStyle,
    this.titleColor,
    this.foregroundColor,
    this.appBarBackgroundColor,
    this.shadowColor,
    // this.blurRadius,
    this.actions,
    // this.kToolbarHeight,
    this.onPressedBack,
    this.showBottomLine,
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
          ? Row(
              spacing: 12,
              children: [
                UserAvatarWidget(
                  userName: userData?.name ?? 'Joe Doe',
                  photoPath: appBarUserPhotoPath,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData?.name ?? 'Some Cool Name',
                      style: textTheme.headlineMedium?.copyWith(
                        color: colors.text1,
                      ),
                    ),
                    Text(
                      userData?.phoneNumber ?? '+419901250285',
                      style: textTheme.bodyLarge?.copyWith(color: colors.text2),
                    ),
                  ],
                ),
              ],
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
