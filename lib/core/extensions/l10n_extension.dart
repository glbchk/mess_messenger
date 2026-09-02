import 'package:flutter/material.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';

extension BuildContextL10nX on BuildContext {
  AppLocalizations get l10n {
    final l10n = AppLocalizations.of(this);
    assert(
      l10n != null,
      'No AppLocalizations found in BuildContext. '
      'Ensure MaterialApp has localizationsDelegates configured.',
    );
    return l10n!;
  }

  AppLocalizations? get maybeL10n => AppLocalizations.of(this);
}
