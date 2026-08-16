import 'package:flutter/material.dart';
import 'package:mess_messenger_app/providers/global_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

const _themeModeKey = 'theme_mode';

@riverpod
class AppTheme extends _$AppTheme {
  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final saved = prefs.getString(_themeModeKey);
    return ThemeMode.values.firstWhere(
      (m) => m.name == saved,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_themeModeKey, mode.name);
  }
}

ThemeMode labelToThemeMode(String label) => switch (label) {
  'Light' => ThemeMode.light,
  'Dark' => ThemeMode.dark,
  _ => ThemeMode.system,
};

String themeModeToLabel(ThemeMode mode) => switch (mode) {
  ThemeMode.system => 'System Default',
  ThemeMode.light => 'Light',
  ThemeMode.dark => 'Dark',
};
