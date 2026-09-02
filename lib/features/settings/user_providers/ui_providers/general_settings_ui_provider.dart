import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/localization/supported_locales.dart';

class GeneralSettingsUiNotifier {
  final bool isOn;
  final bool isPhotoChecked;
  final bool isAudioChecked;
  final bool isVideoChecked;
  final bool isDocumentChecked;
  final String currentLanguageDisplay;

  const GeneralSettingsUiNotifier({
    required this.isOn,
    required this.isPhotoChecked,
    required this.isAudioChecked,
    required this.isVideoChecked,
    required this.isDocumentChecked,
    required this.currentLanguageDisplay,
  });
}

GeneralSettingsUiNotifier buildGeneralSettingsView(
  UserModel? userData,
  AppLocalizations l10n,
) {
  final s = userData?.generalSettings;
  final languages = getSupportedLanguages(l10n);
  final code = s?.language;
  final display = code == null
      ? l10n.systemDefault
      : (languages.where((l) => l.code == code).firstOrNull?.displayName ??
            l10n.systemDefault);

  return GeneralSettingsUiNotifier(
    isOn: s?.isLoggedIn ?? false,
    isPhotoChecked: s?.isPhotoPasswordProtected ?? false,
    isAudioChecked: s?.isAudioPasswordProtected ?? false,
    isVideoChecked: s?.isVideoPasswordProtected ?? false,
    isDocumentChecked: s?.isDocumentPasswordProtected ?? false,
    currentLanguageDisplay: display,
  );
}

String? resolveLanguageCode(
  String selectedLanguage,
  List<SupportedLanguage> languages,
  AppLocalizations l10n,
) {
  if (selectedLanguage == l10n.systemDefault) return null;
  return languages
      .where((l) => l.displayName == selectedLanguage)
      .firstOrNull
      ?.code;
}
