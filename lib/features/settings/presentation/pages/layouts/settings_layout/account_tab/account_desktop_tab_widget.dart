import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/constants/textfields_ids.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/providers/ui_providers/textfield_provider.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/date_picker_dropdown_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/account_settings_controller.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_title_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AccountDesktopTabWidget extends ConsumerStatefulWidget {
  final UserModel? userData;
  final AccountSettingsController accountSettingsController;
  final TextEditingController nameController;
  final MenuController birthdayController;
  final DateTime? selectedDate;
  final FocusNode emailFocusNode;
  final TextEditingController emailController;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController phoneNumberController;

  const AccountDesktopTabWidget({
    super.key,
    this.userData,
    required this.accountSettingsController,
    required this.nameController,
    required this.birthdayController,
    required this.selectedDate,
    required this.emailFocusNode,
    required this.emailController,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.phoneNumberController,
  });

  @override
  ConsumerState<AccountDesktopTabWidget> createState() =>
      _AccountDesktopTabWidgetState();
}

class _AccountDesktopTabWidgetState
    extends ConsumerState<AccountDesktopTabWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final bp = ResponsiveBreakpoints.of(context);
    final labelColumnWidth = (bp.screenWidth * 0.2).clamp(240.0, 380.0);
    final fieldsWidth = bp.isDesktop
        ? bp.screenWidth * 0.25
        : bp.screenWidth * 0.4;

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
          crossAxisAlignment: .start,
          children: [
            Text(
              l10n.account,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p36.gapV,

            Row(
              crossAxisAlignment: .center,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: l10n.userName),
                ),
                Expanded(
                  child: MessTextField(
                    controller: widget.nameController,
                    width: fieldsWidth,
                    hint: l10n.userNameHint,
                    onChanged: (v) =>
                        widget.accountSettingsController.onNameChanged(v ?? ''),
                    error: nameStatus.message,
                    errorColor: statusColor(nameStatus),
                  ),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: .center,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: l10n.birthday),
                ),
                Expanded(
                  child: DatePickerDropdownWidget(
                    menuController: widget.birthdayController,
                    selectedDate: widget.selectedDate,
                    menuWidth: fieldsWidth,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    onDateSelected:
                        widget.accountSettingsController.onBirthdayChanged,
                    error: birthdayStatus.message,
                    errorColor: statusColor(birthdayStatus),
                  ),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: .center,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: l10n.email),
                ),
                Expanded(
                  child: MessTextField(
                    controller: widget.emailController,
                    width: fieldsWidth,
                    hint: l10n.emailHint,
                    suffixIcon: SvgIcons.arrowRight,
                    onSuffixIconTap: () =>
                        widget.accountSettingsController.handleEmailUpdate(
                          context: context,
                          ref: ref,
                          l10n: l10n,
                          emailController: widget.emailController,
                          currentPasswordController:
                              widget.currentPasswordController,
                        ),
                    focusNode: widget.emailFocusNode,
                    error: emailStatus.message,
                    errorColor: statusColor(emailStatus),
                  ),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: .center,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: l10n.phoneNumber),
                ),
                Expanded(
                  child: MessTextField(
                    controller: widget.phoneNumberController,
                    width: fieldsWidth,
                    hint: l10n.phoneNumberHint,
                    onChanged: (v) => widget.accountSettingsController
                        .onPhoneChanged(v ?? ''),
                    error: phoneStatus.message,
                    errorColor: statusColor(phoneStatus),
                  ),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: .center,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: l10n.password),
                ),
                MessMainButton(
                  label: 'Change password',
                  width: fieldsWidth,
                  backgroundColor: colors.surface2,
                  textColor: colors.text1,
                  onPressed: () =>
                      widget.accountSettingsController.handleChangePassword(
                        context: context,
                        ref: ref,
                        l10n: l10n,
                        currentPasswordController:
                            widget.currentPasswordController,
                        newPasswordController: widget.newPasswordController,
                      ),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: .center,
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
                  onPressed: () =>
                      widget.accountSettingsController.handleDeleteAccount(
                        context: context,
                        ref: ref,
                        l10n: l10n,
                        currentPasswordController:
                            widget.currentPasswordController,
                      ),
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
