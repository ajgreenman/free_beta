import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/free_beta.dart';
import 'package:free_beta/app/initializer.dart';
import 'package:free_beta/app/presentation/app_loading.dart';
import 'package:free_beta/app/theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      child: Initializer(
        child: MaterialApp(
          title: 'Free Beta',
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
