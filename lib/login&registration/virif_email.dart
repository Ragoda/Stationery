// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stationery/compon.dart';
import 'package:stationery/src/view/screen/home_screen.dart';

import '../style.dart';
import 'pages/LoginPage.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final double _headerHeight = 180;
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    // FirebaseAuth.instance.currentUser?.sendEmailVerification();
    // timer =
    //     Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    // await FirebaseAuth.instance.currentUser?.reload();

    // setState(() {
    //   isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    //});

    if (isEmailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email Successfully Verified")));
      Get.to(() => const HomeScreen());

      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: whiteColor,
            body: Column(children: [
              // SizedBox(
              //   height: _headerHeight,
              //   child: HeaderWidget(
              //     _headerHeight,
              //     true,
              //   ), //let's create a common header widget
              // ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      'Verifying_Email'.tr,
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 35),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Center(
                        child: Text(
                          'Check_your_Email'.tr,
                          style: textStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                    const Center(
                        child: CircularProgressIndicator(
                      color: primaryColor,
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 70),
              Text(
                "didn_receive_code".tr,
                style: textStyle,
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: SecondaryColor,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      try {
                        // FirebaseAuth.instance.currentUser
                        //     ?.sendEmailVerification();
                        showAlert(
                            context,
                            "",
                            "veri_email_resend_successfully".tr,
                            () => Get.back());
                      } catch (e) {
                        debugPrint('$e');
                      }
                    },
                    child: Text('resend'.tr,
                        style: const TextStyle(color: whiteColor),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
              InkWell(
                child: Text(
                  'Go_to_login'.tr,
                  style: const TextStyle(color: primaryColor),
                ),
                onTap: () {
                  Get.to(() => const LoginPage());
                },
              )
            ])));
  }
}
