import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/date_picker_dropdown_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/account_settings_controller.dart';
import 'package:mess_messenger_app/core/providers/ui_providers/textfield_provider.dart';
import 'package:mess_messenger_app/core/constants/textfields_ids.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class AccountMobileTabWidget extends ConsumerStatefulWidget {
  final AppLocalizations l10n;
  final UserModel? userData;
  final TextEditingController nameController;
  final MenuController birthdayController;
  final DateTime? selectedDate;
  final FocusNode emailFocusNode;
  final TextEditingController emailController;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController phoneNumberController;
  final AccountSettingsController accountSettingsController;

  // final FieldStatus nameStatus;
  // final FieldStatus birthdayStatus;
  // final FieldStatus emailStatus;
  // final FieldStatus phoneStatus;

  // final ValueChanged<String> onNameChanged;
  // final ValueChanged<String> onPhoneChanged;
  // final ValueChanged<DateTime> onBirthdayChanged;

  // final VoidCallback onPressedDeleteAccount;
  // final VoidCallback onPressedEmailUpdate;
  // final VoidCallback onPressedChangePassword;

  const AccountMobileTabWidget({
    super.key,
    required this.l10n,
    this.userData,
    required this.nameController,
    required this.birthdayController,
    required this.selectedDate,
    required this.emailFocusNode,
    required this.emailController,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.phoneNumberController,
    required this.accountSettingsController,
    // required this.nameStatus,
    // required this.birthdayStatus,
    // required this.emailStatus,
    // required this.phoneStatus,
    // required this.onNameChanged,
    // required this.onPhoneChanged,
    // required this.onBirthdayChanged,
    // required this.onPressedDeleteAccount,
    // required this.onPressedEmailUpdate,
    // required this.onPressedChangePassword,
  });

  @override
  ConsumerState<AccountMobileTabWidget> createState() =>
      _AccountMobileTabWidgetState();
}

class _AccountMobileTabWidgetState
    extends ConsumerState<AccountMobileTabWidget> {
  // final _emailFocusNode = FocusNode();
  // final _currentPasswordFieldController = TextEditingController();
  // final _newPasswordFieldController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _emailFocusNode.dispose();
  //   super.dispose();
  // }

  // Future<void> _handleEmailChangeTap() async {
  //   final saved = ref.read(userNotifierProvider).userData?.email;
  //   final typed = widget.emailController.text;

  //   final emailStatus = ref.watch(textfieldStatusProvider('login_email'));
  //   final fieldsNotifier = ref.read(
  //     textfieldStatusProvider('your_form_id_here').notifier,
  //   );

  //   if (typed.isEmpty) {
  //     fieldsNotifier.setStatus(
  //       'email',
  //       const FieldStatus(message: 'Enter an email first', isError: true),
  //     );
  //     return;
  //   }

  //   if (typed == saved) {
  //     fieldsNotifier.setStatus(
  //       'email',
  //       const FieldStatus(message: "That's already your email", isError: true),
  //     );
  //     return;
  //   }

  //   await MessAlertWidget.show(
  //     textfieldController: _currentPasswordFieldController,
  //     context: context,
  //     ref: ref,
  //     title: 'Confirm your password',
  //     message: 'Enter your current password to change your email.',
  //     buttonLabel: widget.l10n.saveChanges,
  //     onConfirm: () async {
  //       final currentPassword = _currentPasswordFieldController.text;

  //       try {
  //         await ref
  //             .read(userNotifierProvider.notifier)
  //             .updateUserEmail(currentPassword);

  //         if (!mounted) return;
  //         fieldsNotifier.setStatus(
  //           'email',
  //           const FieldStatus(
  //             message: 'Confirmation email sent — check your inbox',
  //           ),
  //           clearAfter: const Duration(seconds: 5),
  //         );
  //         // That's it. No second dialog. Next time this screen rebuilds
  //         // (or the app resumes), the app-level gate will redirect them
  //         // to ConfirmEmailPage on its own — nothing more to do here.
  //       } on AuthFailure catch (e) {
  //         if (mounted) {
  //           fieldsNotifier.setStatus(
  //             'email',
  //             FieldStatus(message: e.message(widget.l10n), isError: true),
  //           );
  //           widget.emailController.text = saved ?? '';
  //         }
  //       } catch (e) {
  //         if (mounted) {
  //           fieldsNotifier.setStatus(
  //             'email',
  //             const FieldStatus(message: 'Something went wrong', isError: true),
  //           );
  //           widget.emailController.text = saved ?? '';
  //         }
  //       }
  //     },
  //   );
  // }

  // void _showChangePasswordDialog() {
  //   //TODO: Still need to fix, errors are not displaying properly and also it saves anything now
  //   String? newPasswordError;
  //   String? currentPasswordError;

  //   MessAlertWidget.show(
  //     textfieldController: _currentPasswordFieldController,
  //     textfield2Controller: _newPasswordFieldController,
  //     context: context,
  //     ref: ref,
  //     title: 'Confirm your password',
  //     message: 'Enter your current password to set a new one.',
  //     textfieldLabel: widget.l10n.currentPassword,
  //     textfieldHint: widget.l10n.passwordHint,
  //     textfieldError: currentPasswordError,
  //     textfield2Label: widget.l10n.newPassword,
  //     textfield2Hint: widget.l10n.passwordHint,
  //     textfield2Error: newPasswordError,
  //     buttonLabel: widget.l10n.saveChanges,
  //     onConfirm: () async {
  //       final currentPassword = _currentPasswordFieldController.text;
  //       final newPassword = _newPasswordFieldController.text;

  //       if (newPassword.isEmpty) {
  //         newPasswordError = 'Enter a new password first';
  //       } else {
  //         newPasswordError = null;
  //       }

  //       if (newPassword == currentPassword) {
  //         newPasswordError = 'Enter a new password first';
  //       } else {
  //         newPasswordError = null;
  //       }

  //       try {
  //         await ref
  //             .read(authNotifierProvider.notifier)
  //             .updatePassword(newPassword, currentPassword);

  //         _newPasswordFieldController.clear();
  //         _currentPasswordFieldController.clear();
  //       } on AuthFailure catch (e) {
  //         if (mounted) {
  //           newPasswordError = e.message(widget.l10n);
  //         }
  //       } catch (e) {
  //         if (mounted) {
  //           newPasswordError = e.toString();
  //         }
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    // final userNotifier = ref.read(userNotifierProvider.notifier);
    // final fieldsNotifier = ref.watch(textfieldsProvider.notifier);
    // ref.watch(textfieldsProvider);

    // ref.listen<AuthState>(authNotifierProvider, (previous, next) {
    //   if (next is AuthAuthenticated && next.passwordUpdateError != null) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(next.passwordUpdateError!.message(widget.l10n)),
    //       ),
    //     );
    //   }
    // });

    final nameStatus = ref.watch(
      textfieldStatusProvider(TextfieldIds.accountName),
    );
    final birthdayStatus = ref.watch(
      textfieldStatusProvider(TextfieldIds.accountBirthday),
    );
    final emailStatus = ref.watch(
      textfieldStatusProvider(TextfieldIds.accountEmail),
    );
    final phoneStatus = ref.watch(
      textfieldStatusProvider(TextfieldIds.accountPhone),
    );

    Color? statusColor(FieldStatus s) => s.message == null
        ? null
        : (s.isError ? colors.errorColor : colors.componentSpecific);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.l10n.account,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p36.gapV,

            Text(
              widget.l10n.userName,
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p4.gapV,
            MessTextField(
              controller: widget.nameController,
              hint: widget.l10n.userNameHint,
              onChanged: (v) =>
                  widget.accountSettingsController.onNameChanged(v ?? ''),
              // (value) => textfieldStatusProvider.onFieldChanged(
              //   'name',
              //   value ?? '',
              //   userNotifier.updateUserName,
              // ),
              error: nameStatus.message,
              errorColor: statusColor(nameStatus),
            ),
            AppSpacing.p24.gapV,
            Text(
              widget.l10n.birthday,
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p12.gapV,
            DatePickerDropdownWidget(
              menuController: widget.birthdayController,
              selectedDate: widget.selectedDate,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              onDateSelected:
                  widget.accountSettingsController.onBirthdayChanged,
              error: birthdayStatus.message,
              errorColor: statusColor(birthdayStatus),
            ),
            AppSpacing.p24.gapV,
            Text(
              widget.l10n.email,
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p4.gapV,
            MessTextField(
              controller: widget.emailController,
              hint: widget.l10n.emailHint,
              suffixIcon: SvgIcons.arrowRight,
              onSuffixIconTap: () =>
                  widget.accountSettingsController.handleEmailUpdate(
                    context: context,
                    ref: ref,
                    l10n: widget.l10n,
                    emailController: widget.emailController,
                    currentPasswordController: widget.currentPasswordController,
                  ),
              focusNode: widget.emailFocusNode,
              error: emailStatus.message,
              errorColor: statusColor(emailStatus),
            ),
            AppSpacing.p24.gapV,
            Text(
              widget.l10n.phoneNumber,
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p4.gapV,
            MessTextField(
              controller: widget.phoneNumberController,
              hint: widget.l10n.phoneNumberHint,
              onChanged: (v) =>
                  widget.accountSettingsController.onPhoneChanged(v ?? ''),
              error: phoneStatus.message,
              errorColor: statusColor(phoneStatus),
            ),
            AppSpacing.p24.gapV,
            Text(
              widget.l10n.password,
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p8.gapV,
            MessMainButton(
              label: 'Change password',
              backgroundColor: colors.surface2,
              textColor: colors.text1,
              onPressed: () =>
                  widget.accountSettingsController.handleChangePassword(
                    context: context,
                    ref: ref,
                    l10n: widget.l10n,
                    currentPasswordController: widget.currentPasswordController,
                    newPasswordController: widget.newPasswordController,
                  ),
            ),
            AppSpacing.p24.gapV,
            Text(
              'Delete account',
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p8.gapV,
            MessMainButton(
              label: 'Delete account',
              backgroundColor: colors.errorColor,
              textColor: colors.bg,
              onPressed: () =>
                  widget.accountSettingsController.handleDeleteAccount(
                    context: context,
                    ref: ref,
                    l10n: widget.l10n,
                    currentPasswordController: widget.currentPasswordController,
                  ),
            ),
            AppSpacing.p32.gapV,
          ],
        ),
      ),
    );
  }
}
