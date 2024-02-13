import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/app/infrastructure/email_api.dart';
import 'package:free_beta/app/infrastructure/media_api.dart';
import 'package:free_beta/app/infrastructure/messaging_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

@riverpod
MediaApi mediaApi(MediaApiRef ref) {
  return MediaApi(FirebaseStorage.instance, ref.read(crashlyticsApiProvider));
}

@riverpod
EmailApi emailApi(EmailApiRef ref) {
  return EmailApi(ref.read(crashlyticsApiProvider));
}

@riverpod
CrashlyticsApi crashlyticsApi(CrashlyticsApiRef ref) {
  return CrashlyticsApi(FirebaseCrashlytics.instance);
}

@riverpod
MessagingApi messagingApi(MessagingApiRef ref) {
  return MessagingApi(FirebaseMessaging.instance);
}

@riverpod
class BottomNav extends _$BottomNav {
  @override
  int build() => 0;

  void setIndex(int index) {
    state = index;
  }
}
