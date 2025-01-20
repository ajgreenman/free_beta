import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/free_beta.dart';
import 'package:free_beta/app/infrastructure/messaging_api.dart';
import 'package:free_beta/app/initializer.dart';
import 'package:free_beta/app/presentation/app_loading.dart';
import 'package:free_beta/app/theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }

  FirebaseMessaging.onBackgroundMessage(MessagingApi.handleMessage);

  runApp(
    ProviderScope(
      child: Initializer(
        child: MaterialApp(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(1.0)),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'Climb Elev8',
          theme: FreeBetaTheme.blueTheme,
          home: App(),
        ),
      ),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _hasLoaded = false;

  @override
  Widget build(BuildContext context) {
    return _hasLoaded
        ? FreeBeta()
        : AppLoading(
            onComplete: () => setState(() => _hasLoaded = true),
          );
  }
}
