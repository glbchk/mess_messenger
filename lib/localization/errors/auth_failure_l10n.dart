import 'package:mess_messenger_app/core/errors/auth_failure.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';

extension AuthFailureL10n on AuthFailure {
  String message(AppLocalizations l10n) => switch (this) {
    WrongPasswordFailure() => l10n.incorrectPassword,
    RequiresRecentLoginFailure() => l10n.pleaseSignInAgain,
    EmailAlreadyInUseFailure() => l10n.emailAlreadyInUse,
    MissingPasswordFailure() => l10n.passwordRequired,
    UnknownAuthFailure() => l10n.somethingWentWrong,
    SessionRevokedFailure() => l10n.sessionRevoked,
  };
}
