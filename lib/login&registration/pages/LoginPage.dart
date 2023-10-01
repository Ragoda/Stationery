// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stationery/compon.dart';
import 'package:stationery/src/view/screen/home_screen.dart';
import 'package:stationery/style.dart';

import 'Registration.dart';
import 'forgot_password_page.dart';
import 'widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  final Function? toggleView;
  const LoginPage({super.key, this.toggleView});

  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  bool _obscureText = true;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final AuthenticationManager _auth = Get.put(AuthenticationManager());
    var lan = Get.locale.toString();

    final loginEmailPasswordButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: SecondaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          //   if (_formKey.currentState!.validate()) {
          // _auth.isLoading.value = true;
          // // if (_auth.isAdmin.value == true) {
          // //   _auth.isadmin(
          // //       LoginUser(email: _email.text, password: _password.text),
          // //       context);
          // // } else {
          // dynamic result = await _auth.signInEmailPassword(
          //   LoginUser(email: _email.text, password: _password.text),
          //   context,
          // );
          // if (result.uid.toString() == "null") {
          //   _auth.isLoading.value = false;
          //   showerrorAlert(
          //       context, "", result.code.toString(), () => Get.back());
          // } else {
          //   _auth.isLoading.value = false;
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) {
          //     return const Home(0);
          //   }));
          //   //       Get.to(() => MainScreen());
          // }
          //}
          Get.to(() => HomeScreen());
        },
        child: Text(
          "Login".tr,
          style: const TextStyle(color: whiteColor),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        body:
            ListView(physics: const NeverScrollableScrollPhysics(), children: [
          // SizedBox(
          //   height: _headerHeight,
          //   child: HeaderWidget(
          //     _headerHeight,
          //     true,
          //   ), //let's create a common header widget
          // ),
          SizedBox(height: 20),
          Card(
              elevation: 0,
              shadowColor: primaryColor,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                  margin: const EdgeInsets.fromLTRB(
                      20, 0, 20, 5), // This will be the login form
                  child: Column(children: [
                    Center(
                      child: Image.asset(
                        'assets/logo.jpg',
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                      ),
                    ),
                    // Text(
                    //   'الاخوان'.tr,
                    //   style: const TextStyle(
                    //       fontSize: 60, fontWeight: FontWeight.bold),
                    // ),

                    const SizedBox(height: 20.0),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            EmailTextField(_email, context),
                            const SizedBox(height: 25.0),
                            passwordTextField(_password, context),

                            TextButton(
                                onPressed: () {
                                  //   widget.toggleView!();
                                  Get.to(() => const RegisterationPage());
                                },
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Dont_have_account".tr,
                                        style: TextStyle(color: SecondaryColor),
                                      ),
                                      Text(
                                        'Create'.tr,
                                        style: const TextStyle(
                                            color: primaryColor),
                                      ),
                                    ],
                                  ),
                                )),
                            // SizedBox(height: 2.0),

                            TextButton(
                                onPressed: () {
                                  //   widget.toggleView!();
                                  Get.to(() => const ForgotPasswordPage());
                                },
                                child: Text(
                                  "Forgot_password".tr,
                                  style: const TextStyle(color: primaryColor),
                                )),
                            const SizedBox(height: 10.0),
                            // Obx(() => _auth.isLoading.value
                            //     ? const Center(
                            //         child: CircularProgressIndicator(
                            //           color: primaryColor,
                            //         ),
                            //       )
                            //     :
                            // Container(
                            //     decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(25),
                            //   ))),
                            const SizedBox(height: 10.0),
                            loginEmailPasswordButon,
                            const SizedBox(height: 15.0),
                          ],
                        ),
                      ),
                    ),
                  ])))
        ]));
  }
}
