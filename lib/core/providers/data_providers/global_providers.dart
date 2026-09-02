import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/providers/data_providers/firebase_provider.dart';
import 'package:mess_messenger_app/localization/localization_provider/app_language_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appLanguageProvider = NotifierProvider<AppLanguageNotifier, Locale>(() {
  return AppLanguageNotifier();
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final currentUserIdProvider = Provider<String?>((ref) {
  return ref.watch(firebaseAuthStateChangesProvider).value?.uid;
});
