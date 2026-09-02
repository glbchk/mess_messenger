import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/settings/user_providers/ui_providers/general_settings_ui_provider.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/localization/supported_locales.dart';

class GeneralSettingsController {
  GeneralSettingsController(this._ref);
  final Ref _ref;

  void toggleLogin(bool v) =>
      _ref.read(userNotifierProvider.notifier).updateIsLoggedIn(v);
  void togglePhotoProtection(bool v) => _ref
      .read(userNotifierProvider.notifier)
      .updateIsPhotoPasswordProtected(v);
  void toggleAudioProtection(bool v) => _ref
      .read(userNotifierProvider.notifier)
      .updateIsAudioPasswordProtected(v);
  void toggleVideoProtection(bool v) => _ref
      .read(userNotifierProvider.notifier)
      .updateIsVideoPasswordProtected(v);
  void toggleDocumentProtection(bool v) => _ref
      .read(userNotifierProvider.notifier)
      .updateIsDocumentPasswordProtected(v);
  void selectLanguage(String displayName, AppLocalizations l10n) {
    final languages = getSupportedLanguages(l10n);
    final code = resolveLanguageCode(displayName, languages, l10n);
    if (displayName != l10n.systemDefault && code == null) return;
    _ref.read(userNotifierProvider.notifier).updateLanguage(code);
  }
}

final generalSettingsControllerProvider = Provider(
  (ref) => GeneralSettingsController(ref),
);
