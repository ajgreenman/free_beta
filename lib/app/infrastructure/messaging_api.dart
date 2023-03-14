import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingApi {
  MessagingApi(this._firebaseMessaging);

  final FirebaseMessaging _firebaseMessaging;

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();
  }

  @pragma('vm:entry-point')
  static Future<void> handleMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
  }
}
