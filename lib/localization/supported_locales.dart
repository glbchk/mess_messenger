import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';

class SupportedLanguage {
  final String code;
  final String displayName;

  const SupportedLanguage({required this.code, required this.displayName});
}

List<SupportedLanguage> getSupportedLanguages(AppLocalizations l10n) {
  return [
    SupportedLanguage(code: 'en', displayName: l10n.english),
    SupportedLanguage(code: 'uk', displayName: l10n.ukrainian),
  ];
}
