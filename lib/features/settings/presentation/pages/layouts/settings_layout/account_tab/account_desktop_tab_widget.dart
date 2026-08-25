import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/errors/auth_failure.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/date_picker_dropdown_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_alert.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_title_widget.dart';
import 'package:mess_messenger_app/features/settings/user_providers/account_settings_provider.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:mess_messenger_app/localization/errors/auth_failure_l10n.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AccountDesktopTabWidget extends ConsumerStatefulWidget {
  final AppLocalizations l10n;
  final UserModel? userData;
  final TextEditingController nameController;
  final MenuController birthdayController;
  final DateTime? selectedDate;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;

  const AccountDesktopTabWidget({
    super.key,
    required this.l10n,
    this.userData,
    required this.nameController,
    required this.birthdayController,
    required this.selectedDate,
    required this.emailController,
    required this.phoneNumberController,
    required this.currentPasswordController,
    required this.newPasswordController,
  });

  @override
  ConsumerState<AccountDesktopTabWidget> createState() =>
      _AccountDesktopTabWidgetState();
}

class _AccountDesktopTabWidgetState
    extends ConsumerState<AccountDesktopTabWidget> {
  final _emailFocusNode = FocusNode();
  final _currentPasswordFieldController = TextEditingController();
  final _newPasswordFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleEmailChangeTap() async {
    final saved = ref.read(userNotifierProvider).userData?.email;
    final typed = widget.emailController.text;
    final fieldsNotifier = ref.read(accountFieldsProvider.notifier);

    if (typed.isEmpty) {
      fieldsNotifier.setStatus(
        'email',
        const FieldSaveState(message: 'Enter an email first', isError: true),
      );
      return;
    }

    if (typed == saved) {
      fieldsNotifier.setStatus(
        'email',
        const FieldSaveState(
          message: "That's already your email",
          isError: true,
        ),
      );
      return;
    }

    await MessAlertWidget.show(
      textfieldController: _currentPasswordFieldController,
      context: context,
      ref: ref,
      title: 'Confirm your password',
      message: 'Enter your current password to change your email.',
      buttonLabel: widget.l10n.saveChanges,
      onConfirm: () async {
        final currentPassword = _currentPasswordFieldController.text;

        try {
          await ref
              .read(userNotifierProvider.notifier)
              .updateUserEmail(currentPassword);

          if (!mounted) return;
          fieldsNotifier.setStatus(
            'email',
            const FieldSaveState(
              message: 'Confirmation email sent — check your inbox',
            ),
            clearAfter: const Duration(seconds: 5),
          );
          // That's it. No second dialog. Next time this screen rebuilds
          // (or the app resumes), the app-level gate will redirect them
          // to ConfirmEmailPage on its own — nothing more to do here.
        } on AuthFailure catch (e) {
          if (mounted) {
            fieldsNotifier.setStatus(
              'email',
              FieldSaveState(message: e.message(widget.l10n), isError: true),
            );
            widget.emailController.text = saved ?? '';
          }
        } catch (e) {
          if (mounted) {
            fieldsNotifier.setStatus(
              'email',
              const FieldSaveState(
                message: 'Something went wrong',
                isError: true,
              ),
            );
            widget.emailController.text = saved ?? '';
          }
        }
      },
    );
  }

  void _showChangePasswordDialog() {
    //TODO: Still need to fix, errors are not displaying properly and also it saves anything now
    String? newPasswordError;
    String? currentPasswordError;

    MessAlertWidget.show(
      textfieldController: _currentPasswordFieldController,
      textfield2Controller: _newPasswordFieldController,
      context: context,
      ref: ref,
      title: 'Confirm your password',
      message: 'Enter your current password to set a new one.',
      textfieldLabel: widget.l10n.currentPassword,
      textfieldHint: widget.l10n.passwordHint,
      textfieldError: currentPasswordError,
      textfield2Label: widget.l10n.newPassword,
      textfield2Hint: widget.l10n.passwordHint,
      textfield2Error: newPasswordError,
      buttonLabel: widget.l10n.saveChanges,
      onConfirm: () async {
        final currentPassword = _currentPasswordFieldController.text;
        final newPassword = _newPasswordFieldController.text;

        if (newPassword.isEmpty) {
          newPasswordError = 'Enter a new password first';
        } else {
          newPasswordError = null;
        }

        if (newPassword == currentPassword) {
          newPasswordError = 'Enter a new password first';
        } else {
          newPasswordError = null;
        }

        try {
          await ref
              .read(authNotifierProvider.notifier)
              .updatePassword(newPassword, currentPassword);

          _newPasswordFieldController.clear();
          _currentPasswordFieldController.clear();
        } on AuthFailure catch (e) {
          if (mounted) {
            newPasswordError = e.message(widget.l10n);
          }
        } catch (e) {
          if (mounted) {
            newPasswordError = e.toString();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final bp = ResponsiveBreakpoints.of(context);
    final labelColumnWidth = (bp.screenWidth * 0.2).clamp(240.0, 380.0);
    final fieldsWidth = bp.isDesktop
        ? bp.screenWidth * 0.25
        : bp.screenWidth * 0.4;

    final userNotifier = ref.read(userNotifierProvider.notifier);
    final fieldsNotifier = ref.watch(accountFieldsProvider.notifier);
    ref.watch(accountFieldsProvider);

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is AuthAuthenticated && next.passwordUpdateError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.passwordUpdateError!.message(widget.l10n)),
          ),
        );
      }
    });

    Color? statusColor(FieldSaveState s) => s.message == null
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

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: widget.l10n.userName),
                ),
                Expanded(
                  child: MessTextField(
                    controller: widget.nameController,
                    width: fieldsWidth,
                    hint: widget.l10n.userNameHint,
                    onChanged: (value) => fieldsNotifier.onFieldChanged(
                      'name',
                      value ?? '',
                      userNotifier.updateUserName,
                    ),
                    error: fieldsNotifier.statusFor('name').message,
                    errorColor: statusColor(fieldsNotifier.statusFor('name')),
                  ),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: widget.l10n.birthday),
                ),
                Expanded(
                  child: DatePickerDropdownWidget(
                    menuController: widget.birthdayController,
                    selectedDate: widget.selectedDate,
                    menuWidth: fieldsWidth,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    onDateSelected: (DateTime newDate) {
                      fieldsNotifier.onFieldChanged(
                        'birthday',
                        newDate.toString(),
                        userNotifier.updateUserBirthday,
                      );
                    },
                    error: fieldsNotifier.statusFor('birthday').message,
                    errorColor: statusColor(
                      fieldsNotifier.statusFor('birthday'),
                    ),
                  ),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: widget.l10n.email),
                ),
                Expanded(
                  child: MessTextField(
                    controller: widget.emailController,
                    width: fieldsWidth,
                    hint: widget.l10n.emailHint,
                    suffixIcon: SvgIcons.arrowRight,
                    onSuffixIconTap: _handleEmailChangeTap,
                    focusNode: _emailFocusNode,
                    error: fieldsNotifier.statusFor('email').message,
                    errorColor: statusColor(fieldsNotifier.statusFor('email')),
                  ),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: widget.l10n.phoneNumber),
                ),
                Expanded(
                  child: MessTextField(
                    controller: widget.phoneNumberController,
                    width: fieldsWidth,
                    hint: widget.l10n.phoneNumberHint,
                    onChanged: (value) => fieldsNotifier.onFieldChanged(
                      'phone',
                      value ?? '',
                      userNotifier.updateUserPhoneNumber,
                    ),
                    error: fieldsNotifier.statusFor('phone').message,
                    errorColor: statusColor(fieldsNotifier.statusFor('phone')),
                  ),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: widget.l10n.password),
                ),
                MessMainButton(
                  label: 'Change password',
                  width: fieldsWidth,
                  backgroundColor: colors.surface2,
                  textColor: colors.text1,
                  onPressed: _showChangePasswordDialog,
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: 'Delete account'),
                ),
                MessMainButton(
                  label: 'Delete account',
                  width: fieldsWidth,
                  backgroundColor: colors.errorColor,
                  textColor: colors.bg,
                  onPressed: () {}, //TODO: Need to finish
                ),
              ],
            ),
            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
