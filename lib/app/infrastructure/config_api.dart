import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigApi {
  ConfigApi(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;

  bool get showRefreshSchedule =>
      _remoteConfig.getBool('show_refresh_schedule');
}
