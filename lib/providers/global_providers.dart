import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/localization/providers/app_language_notifier.dart';

final appLanguageProvider = NotifierProvider<AppLanguageNotifier, Locale>(() {
  return AppLanguageNotifier();
});
