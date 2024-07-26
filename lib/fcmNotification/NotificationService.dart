import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:s_box/modules/home_screen/home_view.dart';

import '../main.dart';
import '../modules/home_screen/home_controller.dart';



enum NotificationType {  chat}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.notification != null) {
    RemoteNotification? notification = message.notification;
    log("Notification: $notification");
  }
  print('_firebaseMessagingBackgroundHandler');
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print('notificationBackGround(${notificationResponse.id}) action tapped: ''${notificationResponse.actionId} with'' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print('notificationBackGround action tapped with input: ${notificationResponse.input}');
  }
}

class NotificationService{

  late FlutterLocalNotificationsPlugin _fltNotification;
  final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initMessaging() async {
    var androidInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInit = const DarwinInitializationSettings(defaultPresentSound: true);
    var initSetting = InitializationSettings(android: androidInit, iOS: iosInit);
    _fltNotification = FlutterLocalNotificationsPlugin();
    _fltNotification.initialize(initSetting, onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            selectNotificationStream.add(notificationResponse.payload);
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    await _firebaseMessaging.requestPermission();
    //***********************************************************//

    _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    ///=========message handler==========

    remoteMessageHandler(RemoteMessage message) {
      if (message.notification != null) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        log("Notification: ${message.notification?.toMap()}");
        print('notification received');

        if (notification != null) {
          print("Notification Show  '${message.data}'");
          print("Notification notificationType  '${message.data['notificationType']}'");

          _fltNotification.show(
              notification.hashCode,
              notification.title,
              notification.body,
              const NotificationDetails(
                  android: AndroidNotificationDetails(
                    'high_importance_channel',
                    'High Importance Notifications',
                    priority: Priority.high,
                    importance: Importance.max,
                    playSound: true,
                  )),
              payload: json.encode(message.data));

          // liveJobData(message.data);
        }
      }
    }
    FirebaseMessaging.onMessage.listen(remoteMessageHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("Notification onMessageOpenedApp Show  '${message.data}");
        // if (message.data['notificationType'] == NotificationType.job.name || message.data['notificationType'] == NotificationType.profile.name) {
        //   jobClickHandle(message.data);
        //   return;
        // }
        // if (message.data['notificationType'] == NotificationType.chat.name ) {
          chatClickHandle(message.data);
          // return;
        // }

      }
    });
    //****************************************************************//
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _configureSelectNotificationSubject();
  }
  //****************************************************************//

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      if (payload == null) return;
      log('payload:${payload}');
      Map<String, dynamic> valueMap = jsonDecode(payload);
      String notificationType = valueMap['notificationType'];

      // if (notificationType == NotificationType.job.name || notificationType == NotificationType.profile.name) {
      //   jobClickHandle(valueMap);
      //   return;
      // }
     // else
       if (notificationType == NotificationType.chat.name) {
        chatClickHandle(valueMap);
        return;
      }


    });
  }

//***********************************************************//
  jobClickHandle(Map valueMap) {
    // MyApp.getNavigatorKey().currentState?.push(MaterialPageRout  e(builder: (context) => Dashboard()));
  }

//**********************Job*************************************//
  chatClickHandle(Map<String, dynamic> valueMap) {

    // String conversationId=valueMap["conversationId"];
    // Map<String, dynamic> receiverMap = json.decode(valueMap['reciever'].toString());
    //
    // UserModel receiver = UserModel.fromJson(receiverMap);
    // print("${receiver.toJson()}-->conversationID:${conversationId}"); // Access receiver's properties
    //
    var homecont= Get.find<MainScreenController>();
    homecont.tabIndex.value=2;
    homecont.update();
    MyApp.getNavigatorKey().currentState?.push(MaterialPageRoute(builder: (context) =>(HomeScreenView())));

  }


}