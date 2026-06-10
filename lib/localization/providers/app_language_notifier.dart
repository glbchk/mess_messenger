import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class AppLanguageNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    // Read synchronously from the overridden provider
    final prefs = ref.watch(sharedPreferencesProvider);
    final String? languageCode = prefs.getString('language_code');
    return Locale(languageCode ?? 'en');
  }

  Future<void> changeLanguage(Locale newLocale) async {
    if (state != newLocale) {
      state = newLocale;
      final prefs = ref.read(sharedPreferencesProvider);
      await prefs.setString('language_code', newLocale.languageCode);
    }
  }
}

final appLanguageProvider = NotifierProvider<AppLanguageNotifier, Locale>(() {
  return AppLanguageNotifier();
});
