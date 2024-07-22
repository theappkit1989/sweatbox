import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pay/pay.dart';
import 'package:s_box/modules/massage_booking/date_time_view.dart';
import 'package:s_box/modules/massage_booking/get_access_view.dart';
import 'package:s_box/modules/massage_booking/massage_view.dart';
import 'package:s_box/modules/massage_booking/payment_declined_view.dart';
import 'package:s_box/modules/splash/view/splash_view.dart';
import 'package:s_box/themes/colors/color_light.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'extras/constant/shared_pref_constant.dart';
import 'fcmNotification/NotificationService.dart';



@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.notification != null) {
    //No need for showing Notification manually.
    //For BackgroundMessages: Firebase automatically sends a Notification.
    //If you call the flutterLocalNotificationsPlugin.show()-Methode for
    //example the Notification will be displayed twice.
    await setupFlutterNotifications();

  }
  return;

}



 AndroidNotificationChannel channel = const AndroidNotificationChannel(
   'high_importance_channel', // id
   'High Importance Notifications', // title
   description:
   'This channel is used for important notifications.', // description
   importance: Importance.high,
 );

bool isFlutterLocalNotificationsInitialized = false;

 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }



  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
 /* await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );*/
  isFlutterLocalNotificationsInitialized = true;
}
void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBHACDBnfB893A4irs2VeAJ0d8Z2bFQu88",
      appId: "1:847542643614:android:e1bcf9d2eab0d91488c48f",
      messagingSenderId: "847542643614",
      projectId: "sbox-ac5ff",
    ),
  ): await Firebase.initializeApp();
  NotificationService().initMessaging();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
  // Pay.instance.initialize(paymentConfigurationAsset: 'payment_profile_google_pay.json');
}

class Controller extends GetxController {
  final storage = GetStorage();

  Widget getPage() {
    storage.writeIfNull(userToken, '');
    String isLoggedIn = storage.read(userToken);
    if (isLoggedIn == '') {
      return SplashView();
    } else {
      return SplashView();
    }
  }
}

class MyApp extends StatefulWidget {
  static GlobalKey<NavigatorState> getNavigatorKey() {
    return navigatorKey;
  }
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        // status bar color
        statusBarIconBrightness: Brightness.light,
        statusBarColor: ColorLight.black.withOpacity(0.25),
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
    getNotification();
    getiOSPop();
  }

  getNotification() async
  {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      // notification permission is granted
    }
    else {
      // Open settings to enable notification permission
    }
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(
            (RemoteMessage? message) {
          Future.delayed(Duration(milliseconds: 400) , () {
            print('A new onMessageOpenedApp event was published3!');
          });
        }
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      print('A new onMessageOpenedApp event was published1!');

    });
  }

  getiOSPop() async {
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    final controller = Get.put(Controller());
    return GetMaterialApp(
        defaultTransition: Transition.rightToLeftWithFade,
        debugShowCheckedModeBanner: false,
        home: controller.getPage());
  }
}
