import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/providers/data_providers/global_providers.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
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

  Future<void> setThemeByLabel(String label) {
    final l10n = ref.read(_appL10nProvider);
    return setTheme(_labelToThemeMode(label, l10n));
  }
}

@riverpod
AppLocalizations _appL10n(Ref ref) =>
    lookupAppLocalizations(ref.watch(appLanguageProvider));

@riverpod
List<String> themeModeOptions(Ref ref) {
  final l10n = ref.watch(_appL10nProvider);
  return ThemeMode.values.map((m) => _themeModeToLabel(m, l10n)).toList();
}

@riverpod
String currentThemeModeLabel(Ref ref) {
  final l10n = ref.watch(_appL10nProvider);
  return _themeModeToLabel(ref.watch(appThemeProvider), l10n);
}

String _themeModeToLabel(ThemeMode mode, AppLocalizations l10n) =>
    switch (mode) {
      ThemeMode.system => l10n.systemDefault,
      ThemeMode.light => l10n.changeToLight,
      ThemeMode.dark => l10n.changeToDark,
    };

ThemeMode _labelToThemeMode(String label, AppLocalizations l10n) {
  if (label == l10n.changeToLight) return ThemeMode.light;
  if (label == l10n.changeToDark) return ThemeMode.dark;
  return ThemeMode.system;
}
