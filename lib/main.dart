import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:free_beta/app/free_beta.dart';
import 'package:free_beta/app/initializer.dart';
import 'package:free_beta/app/theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    Initalizer(
      child: MaterialApp(
        title: 'Free Beta',
        theme: FreeBetaTheme.blueTheme,
        home: FreeBeta(),
      ),
    ),
  );
}
