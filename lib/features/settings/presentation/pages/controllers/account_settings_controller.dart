import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/errors/auth_failure.dart';
import 'package:mess_messenger_app/core/widgets/mess_alert.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/core/providers/ui_providers/textfield_provider.dart';
import 'package:mess_messenger_app/core/constants/textfields_ids.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/localization/errors/auth_failure_l10n.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';

class AccountSettingsController {
  AccountSettingsController(this._ref);
  final Ref _ref;

  final Map<String, Timer> _debounceTimers = {};

  void _dispose() {
    for (final t in _debounceTimers.values) {
      t.cancel();
    }
    _debounceTimers.clear();
  }

  void _saveField(String id, String value, Future<void> Function(String) save) {
    _debounceTimers[id]?.cancel();
    final status = _ref.read(textfieldStatusProvider(id).notifier);
    status.clear();

    _debounceTimers[id] = Timer(const Duration(milliseconds: 600), () async {
      status.setSaving();
      try {
        await save(value);
        status.setSuccess('Saved');
      } catch (_) {
        status.setError(
          'Failed to save',
          clearAfter: const Duration(seconds: 3),
        );
      }
    });
  }

  void onNameChanged(String value) => _saveField(
    TextfieldIds.accountName,
    value,
    _ref.read(userNotifierProvider.notifier).updateUserName,
  );

  void onPhoneChanged(String value) => _saveField(
    TextfieldIds.accountPhone,
    value,
    _ref.read(userNotifierProvider.notifier).updateUserPhoneNumber,
  );

  void onBirthdayChanged(DateTime date) => _saveField(
    TextfieldIds.accountBirthday,
    date.toString(),
    _ref.read(userNotifierProvider.notifier).updateUserBirthday,
  );

  Future<void> handleEmailUpdate({
    required BuildContext context,
    required WidgetRef ref,
    required AppLocalizations l10n,
    required TextEditingController emailController,
    required TextEditingController currentPasswordController,
  }) async {
    final userNotifier = _ref.read(userNotifierProvider.notifier);
    final email = _ref.read(
      textfieldStatusProvider(TextfieldIds.accountEmail).notifier,
    );
    final saved = _ref.read(userNotifierProvider).userData?.email;
    final typed = emailController.text;

    if (typed.isEmpty) {
      email.setError('Enter an email first');
      return;
    }
    if (typed == saved) {
      email.setError("That's already your email");
      return;
    }

    await MessAlertWidget.show(
      textfieldController: currentPasswordController,
      context: context,
      ref: ref,
      title: 'Confirm your password',
      message: 'Enter your current password to change your email.',
      textfieldLabel: l10n.currentPassword,
      textfieldHint: l10n.passwordHint,
      buttonLabel: l10n.saveChanges,
      onConfirm: () async {
        email.setSaving();
        try {
          await userNotifier.updateUserEmail(
            typed,
            currentPassword: currentPasswordController.text,
          );
          email.setSuccess(
            'Confirmation email sent — check your inbox',
            clearAfter: const Duration(seconds: 5),
          );
        } on AuthFailure catch (e) {
          email.setError(e.message(l10n));
          emailController.text = saved ?? '';
        } catch (_) {
          email.setError('Something went wrong');
          emailController.text = saved ?? '';
        }
      },
    );
  }

  Future<void> handleChangePassword({
    required BuildContext context,
    required WidgetRef ref,
    required AppLocalizations l10n,
    required TextEditingController currentPasswordController,
    required TextEditingController newPasswordController,
  }) async {
    final field = _ref.read(
      textfieldStatusProvider(TextfieldIds.accountNewPassword).notifier,
    );

    await MessAlertWidget.show(
      textfieldController: currentPasswordController,
      textfield2Controller: newPasswordController,
      context: context,
      ref: ref,
      title: 'Confirm your password',
      message: 'Enter your current password to set a new one.',
      textfieldLabel: l10n.currentPassword,
      textfieldHint: l10n.passwordHint,
      textfield2Label: l10n.newPassword,
      textfield2Hint: l10n.passwordHint,
      buttonLabel: l10n.saveChanges,
      onConfirm: () async {
        final current = currentPasswordController.text;
        final next = newPasswordController.text;
        if (next.isEmpty || next == current) {
          field.setError('Enter a new password first');
          return;
        }
        field.setSaving();
        try {
          await _ref
              .read(authNotifierProvider.notifier)
              .updatePassword(next, current);
          field.setSuccess('Password updated');
          currentPasswordController.clear();
          newPasswordController.clear();
        } on AuthFailure catch (e) {
          field.setError(e.message(l10n));
        } catch (_) {
          field.setError('Something went wrong');
        }
      },
    );
  }

  void handleDeleteAccount({
    required BuildContext context,
    required WidgetRef ref,
    required AppLocalizations l10n,
    required TextEditingController currentPasswordController,
  }) async {
    await MessAlertWidget.show(
      textfieldController: currentPasswordController,
      context: context,
      ref: ref,
      title: 'Confirm your password',
      message: 'Enter your current password to delete your account.',
      textfieldLabel: l10n.currentPassword,
      textfieldHint: l10n.passwordHint,
      buttonLabel: 'Delete account', //l10n.deleteAccount,
      onConfirm: () async {
        // try {
        //   await _ref
        //       .read(authNotifierProvider.notifier)
        //       .deleteAccount(currentPasswordController.text);
        // } on AuthFailure catch (e) {
        //   MessAlertWidget.showError(
        //     context: context,
        //     ref: ref,
        //     title: 'Error',
        //     message: e.message(l10n),
        //   );
        // } catch (_) {
        //   MessAlertWidget.showError(
        //     context: context,
        //     ref: ref,
        //     title: 'Error',
        //     message: 'Something went wrong',
        //   );
        // }
      },
    );
  }
}

final accountSettingsControllerProvider = Provider<AccountSettingsController>((
  ref,
) {
  final controller = AccountSettingsController(ref);
  ref.onDispose(controller._dispose);
  return controller;
});
