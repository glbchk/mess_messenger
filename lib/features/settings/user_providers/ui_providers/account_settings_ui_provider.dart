import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/errors/auth_failure.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/settings/presentation/notifiers/user_notifier.dart';
import 'package:mess_messenger_app/core/providers/ui_providers/textfield_provider.dart';
import 'package:mess_messenger_app/core/constants/textfields_ids.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/localization/errors/auth_failure_l10n.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';

class AccountSettingsUiNotifier extends Notifier<void> {
  final Map<String, Timer> _debounce = {};

  @override
  void build() {
    ref.onDispose(() {
      for (final t in _debounce.values) {
        t.cancel();
      }
    });
  }

  UserNotifier get _user => ref.read(userNotifierProvider.notifier);
  TextfieldNotifier _field(String id) =>
      ref.read(textfieldStatusProvider(id).notifier);

  void changeName(String v) =>
      _debouncedSave(TextfieldIds.accountName, v, _user.updateUserName);

  void changeBirthday(DateTime d) => _debouncedSave(
    TextfieldIds.accountBirthday,
    d.toString(),
    _user.updateUserBirthday,
  );

  void changePhone(String v) =>
      _debouncedSave(TextfieldIds.accountPhone, v, _user.updateUserPhoneNumber);

  void _debouncedSave(
    String fieldId,
    String value,
    Future<void> Function(String) save, {
    Duration wait = const Duration(milliseconds: 600),
  }) {
    _debounce[fieldId]?.cancel();
    _field(fieldId).clear();
    _debounce[fieldId] = Timer(wait, () async {
      final field = _field(fieldId);
      field.setSaving();
      try {
        await save(value);
        field.setSuccess('Saved');
      } catch (_) {
        field.setError(
          'Failed to save',
          clearAfter: const Duration(seconds: 3),
        );
      }
    });
  }

  Future<bool> submitEmailChange({
    required String typedEmail,
    required String currentPassword,
    required AppLocalizations l10n,
  }) async {
    final email = _field(TextfieldIds.accountEmail);
    final saved = ref.read(userNotifierProvider).userData?.email;

    if (typedEmail.isEmpty) {
      email.setError('Enter an email first');
      return false;
    }
    if (typedEmail == saved) {
      email.setError("That's already your email");
      return false;
    }

    email.setSaving();
    try {
      await _user.updateUserEmail(typedEmail, currentPassword: currentPassword);
      email.setSuccess(
        'Confirmation email sent — check your inbox',
        clearAfter: const Duration(seconds: 5),
      );
      return true;
    } on AuthFailure catch (e) {
      email.setError(e.message(l10n));
      return false;
    } catch (_) {
      email.setError('Something went wrong');
      return false;
    }
  }

  Future<bool> submitPasswordChange({
    required String currentPassword,
    required String newPassword,
    required AppLocalizations l10n,
  }) async {
    final field = _field(TextfieldIds.accountNewPassword);
    if (newPassword.isEmpty || newPassword == currentPassword) {
      field.setError('Enter a new password first');
      return false;
    }
    field.setSaving();
    try {
      await ref
          .read(authNotifierProvider.notifier)
          .updatePassword(newPassword, currentPassword);
      field.setSuccess('Password updated');
      return true;
    } on AuthFailure catch (e) {
      field.setError(e.message(l10n));
      return false;
    } catch (_) {
      field.setError('Something went wrong');
      return false;
    }
  }
}

final accountSettingsUiProvider =
    NotifierProvider<AccountSettingsUiNotifier, void>(
      AccountSettingsUiNotifier.new,
    );
