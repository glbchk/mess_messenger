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
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/account_settings_controller.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/adaptive_settings_item_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/ui_helpers/method_helpers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class AccountTabWidget extends ConsumerStatefulWidget {
  final TextEditingController nameController;
  final MenuController birthdayController;
  final DateTime? selectedDate;
  final FocusNode emailFocusNode;
  final TextEditingController emailController;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController phoneNumberController;

  const AccountTabWidget({
    super.key,
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
  ConsumerState<AccountTabWidget> createState() => _AccountTabWidgetState();
}

class _AccountTabWidgetState extends ConsumerState<AccountTabWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final accountSettingsController = ref.read(
      accountSettingsControllerProvider,
    );

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
            AppSpacing.p32.gapV,

            AdaptiveSettingsItemWidget(
              label: l10n.userName,
              labelWidth: context.getLabelWidth(),
              control: MessTextField(
                controller: widget.nameController,
                width: context.getFieldWidth(),
                hint: l10n.userNameHint,
                onChanged: (v) =>
                    accountSettingsController.onNameChanged(v ?? ''),
                error: nameStatus.message,
                errorColor: statusColor(nameStatus),
              ),
            ),
            context.getSpacer(),
            AdaptiveSettingsItemWidget(
              label: l10n.birthday,
              labelWidth: context.getLabelWidth(),
              control: DatePickerDropdownWidget(
                menuController: widget.birthdayController,
                selectedDate: widget.selectedDate,
                menuWidth: context.getFieldWidth(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                onDateSelected: accountSettingsController.onBirthdayChanged,
                error: birthdayStatus.message,
                errorColor: statusColor(birthdayStatus),
              ),
            ),
            context.getSpacer(),
            AdaptiveSettingsItemWidget(
              label: l10n.email,
              labelWidth: context.getLabelWidth(),
              control: MessTextField(
                controller: widget.emailController,
                width: context.getFieldWidth(),
                hint: l10n.emailHint,
                suffixIcon: SvgIcons.arrowRight,
                onSuffixIconTap: () =>
                    accountSettingsController.handleEmailUpdate(
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
            context.getSpacer(),
            AdaptiveSettingsItemWidget(
              label: l10n.phoneNumber,
              labelWidth: context.getLabelWidth(),
              control: MessTextField(
                controller: widget.phoneNumberController,
                width: context.getFieldWidth(),
                hint: l10n.phoneNumberHint,
                onChanged: (v) =>
                    accountSettingsController.onPhoneChanged(v ?? ''),
                error: phoneStatus.message,
                errorColor: statusColor(phoneStatus),
              ),
            ),
            context.getSpacer(),
            AdaptiveSettingsItemWidget(
              label: l10n.password,
              labelWidth: context.getLabelWidth(),
              control: MessMainButton(
                label: l10n.changePassword,
                width: context.getFieldWidth(),
                backgroundColor: colors.surface2,
                textColor: colors.text1,
                onPressed: () => accountSettingsController.handleChangePassword(
                  context: context,
                  ref: ref,
                  l10n: l10n,
                  currentPasswordController: widget.currentPasswordController,
                  newPasswordController: widget.newPasswordController,
                ),
              ),
            ),
            context.getSpacer(),
            AdaptiveSettingsItemWidget(
              label: l10n.deleteAccount,
              labelWidth: context.getLabelWidth(),
              control: MessMainButton(
                label: l10n.deleteAccount,
                width: context.getFieldWidth(),
                backgroundColor: colors.errorColor,
                textColor: colors.bg,
                onPressed: () => accountSettingsController.handleDeleteAccount(
                  context: context,
                  ref: ref,
                  l10n: l10n,
                  currentPasswordController: widget.currentPasswordController,
                ),
              ),
            ),
            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
