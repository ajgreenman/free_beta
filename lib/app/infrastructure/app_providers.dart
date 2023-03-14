import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/app/infrastructure/email_api.dart';
import 'package:free_beta/app/infrastructure/media_api.dart';
import 'package:free_beta/app/infrastructure/messaging_api.dart';

final mediaApiProvider = Provider(
  (ref) => MediaApi(FirebaseStorage.instance, ref.read(crashlyticsApiProvider)),
);

final emailApiProvider = Provider(
  (ref) => EmailApi(ref.read(crashlyticsApiProvider)),
);

final crashlyticsApiProvider = Provider(
  (_) => CrashlyticsApi(FirebaseCrashlytics.instance),
);

final messagingApiProvider = Provider(
  (_) => MessagingApi(FirebaseMessaging.instance),
);
