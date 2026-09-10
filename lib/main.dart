import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mess_messenger_app/app.dart';
import 'package:mess_messenger_app/core/providers/data_providers/global_providers.dart';
import 'package:mess_messenger_app/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (FlutterErrorDetails details) {
    // Bypass presentError/dumpErrorToConsole which crashes on Flutter web
    debugPrint('╔══ FLUTTER ERROR ══════════════════════════════');
    debugPrint('${details.exceptionAsString()}');
    debugPrint('${details.stack}');
    debugPrint('╚═══════════════════════════════════════════════');
  };

  // print('🔥 Firebase Project ID: ${Firebase.app().options.projectId}');
  // print('🔥 Firebase App ID: ${Firebase.app().options.appId}');
  // print('🔥 Firebase Auth Domain: ${Firebase.app().options.authDomain}');

  // if (kDebugMode) {
  //   // Temporarily force clear the persistence cache to wipe out Release data
  //   try {
  //     await FirebaseFirestore.instance.terminate();
  //     await FirebaseFirestore.instance.clearPersistence();
  //   } catch (e) {
  //     print('Cache already clear');
  //   }
  // }

  // if (kReleaseMode) {
  //   await FirebaseFirestore.instance.terminate();
  //   await FirebaseFirestore.instance.clearPersistence();
  // }

  // if (kDebugMode) {
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  //   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //   await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  // }

  // await FirebaseAppCheck.instance.activate(
  //   providerAndroid: const AndroidDebugProvider(),
  //   providerApple: const AppleDebugProvider(),
  // );

  final sharedPreferences = await SharedPreferences.getInstance();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  if (!kIsWeb) {
    await GoogleSignIn.instance.initialize(
      serverClientId:
          '74270236491-on19an6qa9uj12kqdf2rp7oitnjv4s95.apps.googleusercontent.com',
    );
  }

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}
