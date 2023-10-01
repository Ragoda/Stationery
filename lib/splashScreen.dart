// ignore_for_file: unused_import, file_names, override_on_non_overriding_member, camel_case_types
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stationery/src/view/screen/home_screen.dart';

class Splashcreen extends StatelessWidget {
  const Splashcreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashcreen_class(),
    );
  }
}

class Splashcreen_class extends StatefulWidget {
  const Splashcreen_class({super.key});

  @override
  State<Splashcreen_class> createState() => _Splashcreen_classState();
}

var box = GetStorage();

class _Splashcreen_classState extends State<Splashcreen_class> {
  var isSeen = box.read("isSeen");
  // final AuthenticationManager _authmanager = Get.put(AuthenticationManager());
  @override
  void initState() {
    super.initState();
    box.write("isSeen", "true");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _loadDataAndNavigate();
    });
  }

  _loadDataAndNavigate() async {
    Future.delayed(const Duration(seconds: 1), () {
      // loggerNoStack
      //     .i("$isSeen ffffffffffffffffsssssssssssssaaaaaaaaaaaaaaaaaaaaaa");
      if (isSeen.toString() == "false" || isSeen == null) {
        //   Get.to(() => const ChoeseLang());
        box.write("isSeen", "true");
      } else {
        //   Get.to(() => const ChoeseLang());
        //     _authmanager.checkLoginStatus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            duration: 3000,
            // splashIconSize: 300,
            splash: Image.asset(
              'assets/logo.jpg',scale: 100,
            ),
            nextScreen: const HomeScreen(),
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: Colors.white));
  }
}
