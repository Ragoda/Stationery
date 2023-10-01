import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/authentication.dart';

import '../../compon.dart';
import '../../style.dart';
import '../themeh.dart';
import 'LoginPage.dart';
import 'widgets/header_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  // final _controller = Get.put(AuthenticationManager());
  @override
  Widget build(BuildContext context) {
    double headerHeight = 280;
    return Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: headerHeight,
              //   child: HeaderWidget(
              //     headerHeight,
              //     true,
              //   ),
              // ),
              SafeArea(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(25, 1, 25, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Forgot_password'.tr,
                              style: const TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Enter_email_associated_account'.tr,
                              style: const TextStyle(
                                  // fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'We_will_email'.tr,
                              style: const TextStyle(
                                color: Colors.black38,
                                // fontSize: 20,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              // decoration:
                              //     ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextFormField(
                                controller: _email,
                                // decoration: ThemeHelper()
                                //     .textInputDecoration("Email".tr, ""),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "can_not_empty".tr;
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                    return "not_valid_email_address".tr;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 40.0),
                            Container(
                              // decoration:
                              //     ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    "Send".tr.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // _controller.isLoading.value = true;
                                    // _controller
                                    //     .resetpassword(_email.text)
                                    //     .then((value) {
                                    //   _controller.isLoading.value = false;
                                    //   showAlert(
                                    //     context,
                                    //     "Successfully_Done".tr,
                                    //     "email_sent_successfully".tr,
                                    //     () {
                                    //       Get.off(() => const LoginPage());
                                    //   },
                                    // );
                                    // });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            // Obx(() => _controller.isLoading.value
                            //     ? const Center(
                            //         child: CircularProgressIndicator(
                            //           color: primaryColor,
                            //         ),
                            //       )
                            //     : Container(
                            //         decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(25),
                            //       ))),
                            const SizedBox(height: 25.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Remember_password".tr),
                                  TextSpan(
                                    text: 'Login'.tr,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(() => const LoginPage());
                                      },
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
