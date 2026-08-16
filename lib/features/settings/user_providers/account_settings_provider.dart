import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class FieldSaveState {
  final String? message;
  final bool isError;
  const FieldSaveState({this.message, this.isError = false});
}

class AccountSettingsNotifier extends Notifier<Map<String, FieldSaveState>> {
  final Map<String, Timer> _debounceTimers = {};
  final Map<String, Timer> _clearTimers = {};

  @override
  Map<String, FieldSaveState> build() {
    ref.onDispose(() {
      for (final t in _debounceTimers.values) {
        t.cancel();
      }
      for (final t in _clearTimers.values) {
        t.cancel();
      }
    });
    return {};
  }

  void setStatus(
    String fieldKey,
    FieldSaveState status, {
    Duration clearAfter = const Duration(seconds: 2),
  }) {
    _debounceTimers[fieldKey]?.cancel();
    _clearTimers[fieldKey]?.cancel();

    state = {...state, fieldKey: status};

    _clearTimers[fieldKey] = Timer(clearAfter, () {
      state = {...state, fieldKey: const FieldSaveState()};
    });
  }

  void onFieldChanged(
    String fieldKey,
    String value,
    Future<void> Function(String value) saveFn, {
    Duration debounce = const Duration(milliseconds: 600),
    Duration clearAfter = const Duration(seconds: 2),
  }) {
    _debounceTimers[fieldKey]?.cancel();
    _clearTimers[fieldKey]?.cancel();

    state = {
      ...state,
      fieldKey: const FieldSaveState(),
    }; // clear message while typing

    _debounceTimers[fieldKey] = Timer(debounce, () async {
      try {
        await saveFn(value);
        state = {...state, fieldKey: const FieldSaveState(message: 'Saved')};
      } catch (_) {
        state = {
          ...state,
          fieldKey: const FieldSaveState(
            message: 'Failed to save',
            isError: true,
          ),
        };
      }

      _clearTimers[fieldKey] = Timer(clearAfter, () {
        state = {...state, fieldKey: const FieldSaveState()};
      });
    });
  }

  FieldSaveState statusFor(String fieldKey) =>
      state[fieldKey] ?? const FieldSaveState();
}

final accountFieldsProvider =
    NotifierProvider<AccountSettingsNotifier, Map<String, FieldSaveState>>(
      AccountSettingsNotifier.new,
    );
