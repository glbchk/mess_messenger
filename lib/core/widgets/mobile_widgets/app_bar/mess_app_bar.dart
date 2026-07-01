import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;

  // final bool showLeadingIcon;
  final bool showAppBarContent;
  // final Image? profileImagePath;
  // final String? userName;
  // final String? phoneNumber;
  final Widget? appBarContent;
  final String? title;
  final bool? centerTitle;
  final TextStyle? titleTextStyle;
  final Color? titleColor;
  final Color? foregroundColor;
  final Color? appBarBackgroundColor;
  final Color? shadowColor;
  // final double? blurRadius;
  final List<Widget>? actions;
  final double? kToolbarHeight;

  const MessAppBar({
    super.key,
    this.extendBodyBehindAppBar,
    required this.resizeToAvoidBottomInset,
    // this.showLeadingIcon = true,
    required this.showAppBarContent,
    // this.profileImagePath,
    // this.userName,
    // this.phoneNumber,
    this.appBarContent,
    this.title,
    this.centerTitle,
    this.titleTextStyle,
    this.titleColor,
    this.foregroundColor,
    this.appBarBackgroundColor,
    this.shadowColor,
    // this.blurRadius,
    this.actions,
    this.kToolbarHeight,
  });

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface0,
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? colors.border2,
              blurRadius: 0,
              spreadRadius: 0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: colors.surface0,
          elevation: 0,
          toolbarHeight: 58,
          leading: showAppBarContent == true
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: ColoredBox(
                          color: colors.surface2,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back, color: colors.icon1),
                            onPressed: () {
                              // Handle back action
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : null,
          title: showAppBarContent == true
              ? appBarContent
              : Text(
                  title ?? '',
                  style: textTheme.displaySmall?.copyWith(color: titleColor),
                ),
          centerTitle: showAppBarContent == true ? null : false,
          actions: actions,
          // [
          // IconButton(
          //   icon: const Icon(Icons.logout, color: Colors.red),
          //   onPressed: () => ref.read(authProvider.notifier).logout(),
          // ),
          // ],
        ),
      ),
    );
  }
}
