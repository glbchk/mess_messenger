import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/providers/ui_providers/textfield_provider.dart';
import 'package:mess_messenger_app/features/auth/domain/auth_validators.dart';

class AuthFormController {
  AuthFormController(this._ref);
  final Ref _ref;
  Timer? _emailDebounce;
  Timer? _passwordDebounce;

  void _dispose() {
    _emailDebounce?.cancel();
    _passwordDebounce?.cancel();
  }

  void onNameChanged(String value, String fieldId) {
    _emailDebounce?.cancel();
    final field = _ref.read(textfieldStatusProvider(fieldId).notifier);
    field.clear();
    _emailDebounce = Timer(const Duration(milliseconds: 400), () {
      final error = AuthValidators.name(value);
      if (error != null) field.setError(error);
    });
  }

  void onEmailChanged(String value, String fieldId) {
    _emailDebounce?.cancel();
    final field = _ref.read(textfieldStatusProvider(fieldId).notifier);
    field.clear();
    _emailDebounce = Timer(const Duration(milliseconds: 400), () {
      final error = AuthValidators.email(value);
      if (error != null) field.setError(error);
    });
  }

  void onPasswordChanged(String value, String fieldId) {
    _passwordDebounce?.cancel();
    final field = _ref.read(textfieldStatusProvider(fieldId).notifier);
    field.clear();
    _passwordDebounce = Timer(const Duration(milliseconds: 400), () {
      final error = AuthValidators.password(value);
      if (error != null) field.setError(error);
    });
  }
}

final authFormControllerProvider = Provider<AuthFormController>((ref) {
  final controller = AuthFormController(ref);
  ref.onDispose(controller._dispose);
  return controller;
});
