import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:free_beta/app/infrastructure/crashlytics_api.dart';
import 'package:free_beta/app/infrastructure/email_api.dart';
import 'package:free_beta/app/infrastructure/media_api.dart';
import 'package:free_beta/app/infrastructure/messaging_api.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

@Riverpod(dependencies: [crashlyticsApi])
MediaApi mediaApi(Ref ref) {
  return MediaApi(FirebaseStorage.instance, ref.read(crashlyticsApiProvider));
}

@Riverpod(dependencies: [crashlyticsApi])
EmailApi emailApi(Ref ref) {
  return EmailApi(ref.read(crashlyticsApiProvider));
}

@Riverpod(dependencies: [])
CrashlyticsApi crashlyticsApi(Ref ref) {
  return CrashlyticsApi(FirebaseCrashlytics.instance);
}

@riverpod
MessagingApi messagingApi(Ref ref) {
  return MessagingApi(FirebaseMessaging.instance);
}

@Riverpod(dependencies: [])
BaseCacheManager cacheManager(Ref ref) {
  return DefaultCacheManager();
}

@riverpod
class BottomNav extends _$BottomNav {
  @override
  int build() => 0;

  void setIndex(int index) {
    state = index;
  }
}
