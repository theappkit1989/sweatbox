
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsSubscription {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> showNotificationPermission() async {
    await _firebaseMessaging.requestPermission();
  }

  static void fcmSubscribe(String? topic) {
    _firebaseMessaging.subscribeToTopic(topic ?? "").onError((error, stackTrace) => print('error in subscription$error')).whenComplete(() =>print('topis subscribed $topic'));
    
  }

  static void fcmUnSubscribe(String? topic) {
    _firebaseMessaging.unsubscribeFromTopic(topic ?? "");
  }

  static initialNotificationHandle() async {
    final RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if (initialMessage.data.isNotEmpty) {
        print("initalNotificationHandle:${initialMessage.data}");
      }
    }
  }
}