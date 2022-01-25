// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMoZxdioDMSD8kmiq57wEwOialnRntJQg',
    appId: '1:356903882644:android:41c86bd8e85f8255798981',
    messagingSenderId: '356903882644',
    projectId: 'free-beta-d83c0',
    storageBucket: 'free-beta-d83c0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvrSonigietR5siWJQr_gsESpYGGLTYWg',
    appId: '1:356903882644:ios:1926bbbbc4963951798981',
    messagingSenderId: '356903882644',
    projectId: 'free-beta-d83c0',
    storageBucket: 'free-beta-d83c0.appspot.com',
    iosClientId: '356903882644-mu2bmme4pd87153124dq8rni1kofbm0c.apps.googleusercontent.com',
    iosBundleId: 'com.codejsoftware.freeBeta',
  );
}
