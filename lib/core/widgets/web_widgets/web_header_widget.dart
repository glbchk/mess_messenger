import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/app_bar/mobile_app_bar_content_widget.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/build_web_header_action_button.dart';
import 'package:mess_messenger_app/features/profile/data/models/user_model.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class WebHeaderWidget extends ConsumerWidget {
  final UserModel userData;
  final VoidCallback onPressed;
  final bool showBackButton;
  final VoidCallback? onBackButtonPressed;

  const WebHeaderWidget({
    super.key,
    required this.userData,
    required this.onPressed,
    this.showBackButton = false,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Container(
      height: 112,
      decoration: BoxDecoration(
        // color: Colors.red, //colors.transparent,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(bottom: BorderSide(color: colors.border2, width: 1.0)),
      ),

      // width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MobileAppBarContentWidget(userData: userData),

            // Row(
            //   children: [
            //     UserAvatarWidget(
            //       userName: userData.name ?? 'No name was found',
            //     ),
            //     Column(
            //       children: [
            //         Text(
            //           userData.name ?? 'No name was found',
            //           style: textTheme.displaySmall?.copyWith(
            //             color: colors.text1,
            //           ),
            //         ),
            //         Text(
            //           userData.phoneNumber ?? 'No phone number was found',
            //           style: textTheme.displaySmall?.copyWith(
            //             color: colors.text1,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            Spacer(),
            Row(
              spacing: 12,
              children: [
                buildWebHeaderActionButton(
                  context: context,
                  iconPath: SvgIcons.add,
                  onPressed: () {},
                ),
                buildWebHeaderActionButton(
                  context: context,
                  iconPath: SvgIcons.calls,
                  onPressed: () {},
                ),
                MessMainButton(
                  label: 'View Profile',
                  height: 32,
                  width: 126,
                  textStyle: textTheme.labelMedium?.copyWith(
                    color: colors.textInverse,
                  ),
                  onPressed: () {},
                ),
                buildWebHeaderActionButton(
                  context: context,
                  iconPath: SvgIcons.menuVert,
                  onPressed: () {},
                ),
              ],
            ),

            // Row(
            //   children: [
            //     GestureDetector(
            //       onTap: onPressed,
            //       child: Container(
            //         height: 44,
            //         width: 44,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.all(Radius.circular(30)),
            //           color: colors.surface2,
            //         ),
            //         child: Center(
            //           child: SvgPicture.asset(iconPath, height: 20, width: 20),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
