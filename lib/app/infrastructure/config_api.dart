import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigApi {
  ConfigApi(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;

  bool get showResetSchedule => _remoteConfig.getBool('show_reset_schedule');
}
