import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final crashlyticsApiProvider =
    Provider((_) => CrashlyticsApi(FirebaseCrashlytics.instance));

class CrashlyticsApi {
  CrashlyticsApi(this._firebaseCrashlytics);

  final FirebaseCrashlytics _firebaseCrashlytics;

  Future<void> logError(
    dynamic error,
    StackTrace? stackTrace,
    String className,
    String methodName,
  ) async {
    _firebaseCrashlytics.recordError(
      error,
      stackTrace,
      reason: 'Occured in: $className.$methodName',
    );
  }
}
