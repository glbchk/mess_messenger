import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_title_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class AccountDesktopTabWidget extends StatelessWidget {
  final UserModel? userData;
  final TextEditingController nameController;
  final TextEditingController birthdayController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AccountDesktopTabWidget({
    super.key,
    this.userData,
    required this.nameController,
    required this.birthdayController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final double columnWidth = 320;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p36.gapV,

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: columnWidth,
                  child: BuildTitleWidget(title: 'Username'),
                ),
                Expanded(
                  child: MessTextField(
                    controller: nameController,
                    width: 312,
                    hint: 'Some Name',
                    readOnly: true,
                  ),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: columnWidth,
                  child: BuildTitleWidget(title: 'Birthday'),
                ),
                Expanded(
                  child: MessTextField(
                    controller: birthdayController,
                    width: 312,
                    hint: '19/10/1994',
                    readOnly: true,
                  ),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: columnWidth,
                  child: BuildTitleWidget(title: 'Email'),
                ),
                Expanded(
                  child: MessTextField(
                    controller: emailController,
                    width: 312,
                    hint: 'some@tmail.cp',
                    readOnly: true,
                  ),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: columnWidth,
                  child: BuildTitleWidget(title: 'Password'),
                ),
                Expanded(
                  child: MessTextField(
                    controller: passwordController,
                    width: 312,
                    hint: '**********',
                    readOnly: true,
                  ),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            MessMainButton(width: 312, label: 'Save Changes', onPressed: () {}),
            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
