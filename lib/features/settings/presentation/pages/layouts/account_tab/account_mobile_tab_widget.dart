import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_password_field.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class AccountMobileTabWidget extends StatelessWidget {
  final UserModel? userData;
  final TextEditingController nameController;
  final TextEditingController birthdayController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AccountMobileTabWidget({
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

            Text(
              'Username',
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p4.gapV,
            MessTextField(
              controller: nameController,
              hint: 'Some Name',
              readOnly: true,
            ),
            AppSpacing.p24.gapV,
            Text(
              'Birthday',
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p4.gapV,
            MessTextField(
              controller: birthdayController,
              hint: '19/10/1994',
              readOnly: true,
            ),
            AppSpacing.p24.gapV,
            Text(
              'Email',
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p4.gapV,
            MessTextField(
              controller: emailController,
              hint: 'some@tmail.cp',
              readOnly: true,
            ),
            AppSpacing.p24.gapV,
            Text(
              'Password',
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p4.gapV,
            MessPasswordField(
              controller: passwordController,
              hint: '**********',
              readOnly: true,
            ),
            AppSpacing.p32.gapV,
            MessMainButton(label: 'Save Changes', onPressed: () {}),
            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
