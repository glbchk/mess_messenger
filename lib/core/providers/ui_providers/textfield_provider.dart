import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class FieldStatus {
  final String? message;
  final bool isError;
  final bool isSaving;
  const FieldStatus({
    this.message,
    this.isError = false,
    this.isSaving = false,
  });
  static const none = FieldStatus();
}

class TextfieldNotifier extends Notifier<FieldStatus> {
  final String fieldId;
  TextfieldNotifier(this.fieldId);

  Timer? _debounceTimer;
  Timer? _clearTimer;

  @override
  FieldStatus build() {
    ref.onDispose(() {
      _debounceTimer?.cancel();
      _clearTimer?.cancel();
    });
    return FieldStatus.none;
  }

  void setError(String msg, {Duration? clearAfter}) =>
      _set(FieldStatus(message: msg, isError: true), clearAfter);

  void setSuccess(
    String msg, {
    Duration? clearAfter = const Duration(seconds: 2),
  }) => _set(FieldStatus(message: msg), clearAfter);

  void setSaving() => _set(const FieldStatus(isSaving: true), null);
  void clear() => _set(FieldStatus.none, null);
  void saveOnChange(
    String value,
    Future<void> Function(String value) save, {
    Duration debounce = const Duration(milliseconds: 600),
    String savedMessage = 'Saved',
    String errorMessage = 'Failed to save',
  }) {
    _debounceTimer?.cancel();
    _clearTimer?.cancel();
    state = FieldStatus.none;

    _debounceTimer = Timer(debounce, () async {
      _set(const FieldStatus(isSaving: true), null);
      try {
        await save(value);
        _set(FieldStatus(message: savedMessage), const Duration(seconds: 2));
      } catch (_) {
        _set(
          FieldStatus(message: errorMessage, isError: true),
          const Duration(seconds: 3),
        );
      }
    });
  }

  void _set(FieldStatus s, Duration? clearAfter) {
    _clearTimer?.cancel();
    state = s;
    if (clearAfter != null) {
      _clearTimer = Timer(clearAfter, () {
        state = FieldStatus.none;
      });
    }
  }
}

final textfieldStatusProvider =
    NotifierProvider.family<TextfieldNotifier, FieldStatus, String>(
      TextfieldNotifier.new,
    );
