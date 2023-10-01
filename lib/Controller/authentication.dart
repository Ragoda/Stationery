// ignore_for_file: unused_local_variable, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, deprecated_member_use, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, avoid_types_as_parameter_names

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:stationery/compon.dart';
import 'package:stationery/login&registration/pages/LoginPage.dart';
import 'package:stationery/main.dart';
import 'package:stationery/src/view/screen/Drawer/chose_lang.dart';
import 'package:stationery/src/view/screen/home_screen.dart';

import '../login&registration/virif_email.dart';
import '../src/view/screen/Drawer/notifications.dart';
import 'cache_manager.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;
  var box = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var name = " ".obs;
  var myimage;
  var fcmToken = " ".obs;
  var mylang = Get.locale.obs;
  var isLoading = false.obs;
  var context;
  var downloadedUrl = "".obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var notification_list = <dynamic>[].obs;
  final storageRef = FirebaseStorage.instance.ref();
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  @override
  void onInit() {
    apptoken();
    //  notif_Permission();
    inial_App_Lang();
    Notificationbackgrawnd();
    // notificatia();
    // security_no_chaptions();
    super.onInit;
  }

  notif_Permission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      loggerNoStack.i('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      loggerNoStack.i('User granted provisional permission');
    } else {
      loggerNoStack.i('User declined or has not accepted permission');
    }
  }

  apptoken() async {
    final myfcmToken = await FirebaseMessaging.instance.getToken();
    var email = box.read("email");
    loggerNoStack.i("FMC Token is :$fcmToken");
    fcmToken.value = myfcmToken!;
    var search_user = await _users
        .where(
          "email",
          isEqualTo: email.toString(),
        )
        .get()
        .then((result) {
      _users.doc(result.docs[0].id).update({
        'token': myfcmToken,
      });
    });
  }

  // security_no_chaptions() async {
  //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  // }

  inial_App_Lang() {
    var applanguage = box.read('applocal');
    if (applanguage == null || applanguage == "en") {
      Get.updateLocale(const Locale("en", "Us"));
      box.write('applocal', "en");
      mylang.value = const Locale("en", "Us");
    } else {
      Get.updateLocale(const Locale("ar", "Sa"));
      box.write('applocal', "ar");
      mylang.value = const Locale("ar", "Sa");
    }
    loggerNoStack.i('App Language Is $applanguage');
  }

  // notificatia() {
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       showToast("${notification.title.toString()}");

  //       showDialog(
  //           context: context,
  //           builder: (_) {
  //             return AlertDialog(
  //               title: Text(notification.title.toString()),
  //               content: SingleChildScrollView(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [Text(notification.body.toString())],
  //                 ),
  //               ),
  //             );
  //           });
  //     }
  //   });
  // }

  Future<void> _showNotification(notification) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        1, '${notification.title}', '${notification.body}', notificationDetails,
        payload: 'item x');
  }

  Notificationbackgrawnd() {
    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        _showNotification(notification);
        AlertDialog(
          title: Text(notification.title.toString()),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(notification.body.toString())],
            ),
          ),
        );

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: 'app_icon',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NotificationScreen(),
          ));
      Get.to(() => const NotificationScreen());
    });
  }

  bool checkLoginStatus() {
    var isSeen = box.read("isSeen");
    if (isSeen.toString() == "false") {
      // Get.to(() => const OnBordScreen());

      Get.to(() => const ChoeseLang());
    }
    var islogin = box.read('isLogin');
    var isvrifEmail = box.read('EmailVerification');
    loggerNoStack.i("the EmailVerification$isvrifEmail");
    if (islogin == null ||
        islogin == "false" ||
        isvrifEmail == null ||
        isvrifEmail == "false") {
      loggerNoStack.i('User is currently signed out!');
      var isSeen = box.read("isSeen");
      Get.to(() => const LoginPage());
      return false;
    } else {
      loggerNoStack.i('User is currently signed in!');
      download_profile_image();
      Get.to(() => const HomeScreen());
      return true;
    }
  }

  ChangeLanguages(Locale) {
    Get.locale;
    Get.updateLocale(Locale);

    Get.locale;
    loggerNoStack.i('App Language save  ${Get.locale!.languageCode}');
    box.write('applocal', Get.locale!.languageCode);
    var applan = box.read('applocal');
    mylang.value = Get.locale;
    loggerNoStack.i('App Language updated to  $applan');
  }

  ChangeLanguage() {
    Get.locale == const Locale("en", "Us")
        ? Get.updateLocale(const Locale("ar", "Sa"))
        : Get.locale == const Locale("ar", "Sa")
            ? Get.updateLocale(const Locale("en", "Us"))
            : Get.locale == const Locale("en", "Us");
    Get.locale;
    loggerNoStack.i('App Language save  ${Get.locale!.languageCode}');
    box.write('applocal', Get.locale!.languageCode);
    var applan = box.read('applocal');
    mylang.value = Get.locale;
    loggerNoStack.i('App Language updated to  $applan');
  }

  FirebaseUser? _firebaseUser(User? user) {
    return user != null ? FirebaseUser(uid: user.uid) : null;
  }

  Stream<FirebaseUser?> get user {
    return _auth.authStateChanges().map(_firebaseUser);
  }

  Future signInEmailPassword(LoginUser _login, context) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _login.email.toString(),
              password: _login.password.toString());

      User? user = userCredential.user;

      if (user != null) {
        var isEmVerified = FirebaseAuth.instance.currentUser!.emailVerified;
        loggerNoStack.i("jjjjjjjjjjjjjjjjjjjjjjj");
        loggerNoStack.i(isEmVerified.toString());
        if (isEmVerified) {
          var search_user = await _users
              .where(
                "email",
                isEqualTo: _login.email.toString(),
              )
              .get()
              .then((result) {
            loggerNoStack.i(result.docs[0]["phone"].toString());
            box.write("myimage", downloadedUrl.toString());
            box.write("id", result.docs[0].id.toString());
            box.write("myphone", result.docs[0]["phone"].toString());
            box.write('EmailVerification', "true");
            box.write("open_chat", result.docs[0]["open_chat"].toString());

            _users.doc(result.docs[0].id).update({
              'token': fcmToken.value,
            }).then((value) =>
                loggerNoStack.i("token updated to:${fcmToken.value}"));
          });
          SaveUserData(
            user,
            _login.password,
          );

          return _firebaseUser(user);
        } else {
          box.write('EmailVerification', "false");
          isLoading.value = false;
          showerrorAlert(context, "Verifying_Email".tr, "Email_notVerifyed".tr,
              () => {Get.to(() => const EmailVerificationScreen())});
        }
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      return FirebaseUser(code: e.code, uid: null);
    }
  }

  Future<String> get_chat_Allow() async {
    var open_chat;
    var rr = _auth.authStateChanges().map(_firebaseUser);

    final User? user = auth.currentUser;

    var emailuser = user!.email;

    var search_user = await _users
        .where(
          "email",
          isEqualTo: emailuser.toString(),
        )
        .get()
        .then((result) {
      box.write("open_chat", result.docs[0]["open_chat"].toString());
      open_chat = result.docs[0]["open_chat"].toString();
      loggerNoStack.i("$open_chat fffffffffffffffffffff");
      return open_chat.toString();
    });

    return open_chat.toString();
  }

  SaveUserData(user, password) {
    loggerNoStack.i(user.toString());
    var addislogin = box.write('isLogin', user!.uid);
    saveToken(user.uid);
    loggerNoStack.i(box.read('isLogin'));
    box.write("name", get_user_name.toString());
    box.write("email", user.email.toString());
    box.write("password", password.toString());
  }

  String get_user_name() {
    var rr = _auth.authStateChanges().map(_firebaseUser);
    final User? user = auth.currentUser;
    final uid = user!.displayName;
    name.value = uid.toString();
    return uid
        .toString(); // here you write the codes to input the data into firestore
  }

  Future<String> download_profile_image() async {
    final FirebaseAuth _newauth = FirebaseAuth.instance;
    _newauth.currentUser!.uid;
    final imageRef =
        storageRef.child("images/profile_image/${_auth.currentUser!.uid}");
    var url = await imageRef.getDownloadURL();
    downloadedUrl.value = url;
    myimage = box.write("myimage", downloadedUrl.value.toString());

    return downloadedUrl.toString();
  }

  Future registerEmailPassword(LoginUser _login, name) async {
    try {
      box.write('EmailVerification', "false");
      loggerNoStack.i(box.read('EmailVerification'));
      isLoading.value = true;
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _login.email.toString(),
        password: _login.password.toString(),
      );

      User? user = userCredential.user;

      if (user != null) {
        _users.add({
          "email": _login.email.toString(),
          // "password": _login.password.toString(),
          "name": name,
          "phone": "",
          "image": "",
          "all_amount": "",
          "remaining": "",
          "token": fcmToken.value,
          "open_chat": "false",
        });
        Get.to(() => const EmailVerificationScreen());

        isLoading.value = false;
        box.erase;
        SaveUserData(user, _login.password);
        updateuserProfile(displayName: name).whenComplete(() {
          SaveUserData(user, _login.password);
          update();
        });
        SaveUserData(user, _login.password);
        Get.to(() => const EmailVerificationScreen());
        //Home(0));
        //}
      }
      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      return FirebaseUser(code: e.code, uid: null);
    } catch (e) {
      isLoading.value = false;
      return FirebaseUser(code: e.toString(), uid: null);
    }
  }

  sendPushMessageToWeb(lawyer_name, time) async {
    final result =
        await FirebaseFirestore.instance.collection('employees').get();
    var searchResult = result.docs.map((e) async {
      e.data();
      push_notifications(e, "NEW BOOKING".tr,
          "${"The lawyer".tr}${" $lawyer_name" "has been booked in".tr}$time");
    }).toList();
    //  showToast("The lawyer $lawyer_name has been booked in $time  Successfully");
  }

  push_notifications(e, title, body) async {
    if (fcmToken.value.toString() == "null") {
      loggerNoStack.i('Unable to send FCM message, no token exists.');
      return;
    }
    try {
      await http
          .post(
            Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization':
                  'key=AAAAojP1VYw:APA91bFacZTSkNPFbDHX6a0tGujCe6jE_YI6vopIujLeVATt8jdaDih-jUZjd2DVvGyVOyPhm8q0JIMSBmkSYwEIqUSSQt2qqB7GJ_C8jwsLZVuN-plX4UCGGd9lyU4Sf5DsJLqKigEh'
            },
            body: json.encode({
              'to': e['token'].toString(),
              "content_available": true,
              "priority": "high",
              'message': {'token': fcmToken.value.toString()},
              "notification": {"title": title, "body": body}
            }),
          )
          .then((value) => loggerNoStack.i(value.body));
      loggerNoStack.i('FCM request for web sent!');
    } catch (e) {
      loggerNoStack.i(e);
    }
  }

  updateuserProfile({String? displayName}) async {
    try {
      loggerNoStack.i("name Wants to updated to");
      loggerNoStack.i(displayName);
      User? user = _auth.currentUser;
      await user
          ?.updateProfile(
        displayName: displayName,
      )
          .then((value) async {
        refresh();
        isLoading.value = false;
        loggerNoStack.i(
            'User details updayed IS: ${_auth.currentUser!.displayName}  ${_auth.currentUser!.phoneNumber}  ');
        box.write("name", _auth.currentUser!.displayName);
        var search_user = await _users
            .where(
              "email",
              isEqualTo: box.read("email").toString(),
            )
            .get()
            .then((result) {
          _users.doc(result.docs[0].id).update({
            'name': _auth.currentUser!.displayName,
          });
        });
        // box.write("myphone", _auth.currentUser!.phoneNumber);
      });
      refresh();
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      showerrorAlert(context, "Not Updated", e.code.toString(), () => null);
      return FirebaseUser(code: e.code, uid: null);
    }
  }

  // updateuserPhone({String? phoneNumber}) async {
  //   loggerNoStack.i('User phone updayed IS:  $phoneNumber  ');

  //   await _auth
  //       .verifyPhoneNumber(
  //     timeout: const Duration(seconds: 60),
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       // Auto-resolution timed out...
  //     },
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         showToast("The provided phone number is not valid.");
  //       }
  //     },
  //     codeSent: (String verificationId, int? resendToken) {},

  //     // Sign the user in (or link) with the credential
  //   )
  //       .then((value) {
  //     refresh();

  //     loggerNoStack
  //         .i('User phone updayed IS:  ${_auth.currentUser!.phoneNumber}  ');
  //     box.write("myphone", _auth.currentUser!.phoneNumber);
  //   });
  // }

  resetpassword(_email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: "${_email}");
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      //  return FirebaseUser(code: e.code, uid: null);
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const LoginPage());
      Get.delete<AuthenticationManager>();
      Get.delete();
      await FirebaseAuth.instance.signOut();
      box.remove('isLogin');
      box.erase();
      var lang = Get.locale;
      isLogged.value = false;
      removeToken();
      FirebaseMessaging.instance.deleteToken();

      //  loggerNoStack.i("EmailVerification          :");
      box.write('applocal', lang.toString());
      box.write("isSeen", "true");
      box.write('EmailVerification', "true");
      //  loggerNoStack.i(box.read('EmailVerification'));
    } catch (e) {
      return null;
    }
  }
}
