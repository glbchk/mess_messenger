import 'dart:ui';

class LocalizationService {
  static const List<String> supportedCodes = ['en', 'uk'];

  static bool isSupported(Locale locale) {
    if (locale.languageCode.isEmpty) return false;
    return supportedCodes.contains(locale.languageCode);
  }

  static Locale resolveSystemLocale() {
    final systemLocale = PlatformDispatcher.instance.locale;
    return isSupported(systemLocale) ? systemLocale : const Locale('en', '');
  }
}
