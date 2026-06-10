// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get signUp => 'Sign up';

  @override
  String get startTrial => 'Start your 30-day free trial.';

  @override
  String get nameLabel => 'Name*';

  @override
  String get nameHint => 'Enter your name';

  @override
  String get emailLabel => 'Email address*';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get passwordLabel => 'Password*';

  @override
  String get passwordHint => 'Create a password';

  @override
  String get getStarted => 'Get started';

  @override
  String get signUpWithGoogle => 'Sign up with Google';

  @override
  String get alreadyHaveAnAccount => 'Already have an account?';

  @override
  String get logIn => 'Log in';

  @override
  String get changeLanguage => 'Change language';
}
