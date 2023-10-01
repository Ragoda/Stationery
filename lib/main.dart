import 'dart:ui' show PointerDeviceKind;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stationery/Controller/authentication.dart';
import 'package:stationery/login&registration/pages/LoginPage.dart';
import 'package:stationery/splashScreen.dart';
import '../core/app_theme.dart';
import '../src/view/screen/home_screen.dart';
import 'Localazation/local_string.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'compon.dart';

// import 'package:permission_handler/permission_handler.dart';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',
    importance: Importance.high, playSound: true);

// flutter local notification
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// firebase background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  loggerNoStack
      .i('A Background message just showed up :  ${message.messageId}');
}

late FirebaseMessaging messaging;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void notificationTapBackground(NotificationResponse notificationResponse) {
  loggerNoStack.i('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    loggerNoStack.i(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

AuthenticationManager _auth = Get.put(AuthenticationManager());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  loggerNoStack.i("FMC Token is :$fcmToken");
  _auth.fcmToken.value = fcmToken!;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // Stripe.publishableKey =
  //     "pk_test_51NpAC1Cs2smL31AiJRqaT426UhNO2eyntgBarJxE30gsAlbKMndbFK7WaXkKgMycmn3KVvehquTMzU3bJW5Mv6vI00rjimzumn";
  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  // PermissionStatus status = await Permission.notification.request();
  // await Stripe.instance.applySettings();
  // if (status.isGranted) {
  //   // notification permission is granted
  // } else {
  //   // Open settings to enable notification permission
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Get.locale,
      translations: LocaleString(),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      debugShowCheckedModeBanner: false,
      home: const
          // Splashcreen(),
          //    HomeScreen(),
          LoginPage(),
      theme: AppTheme.lightAppTheme,
    );
  }
}
