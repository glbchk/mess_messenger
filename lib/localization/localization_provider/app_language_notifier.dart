import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/providers/data_providers/global_providers.dart';
import 'package:mess_messenger_app/localization/localization_service.dart';

class AppLanguageNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedCode = prefs.getString('language_code');
    if (savedCode != null && savedCode.isNotEmpty) {
      return Locale(savedCode);
    }
    return LocalizationService.resolveSystemLocale();
  }

  Future<void> changeLanguage(Locale newLocale) async {
    if (newLocale.languageCode.isEmpty) return;
    if (state != newLocale) {
      state = newLocale;
      final prefs = ref.read(sharedPreferencesProvider);
      await prefs.setString('language_code', newLocale.languageCode);
    }
  }

  Future<void> resetToSystemDefault() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.remove('language_code');
    state = LocalizationService.resolveSystemLocale();
  }
}
