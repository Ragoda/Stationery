// ignore: file_names
// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously, non_constant_identifier_names, file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/authentication.dart';

import '../../compon.dart';
import '../../style.dart';
import '../themeh.dart';
import 'LoginPage.dart';
import 'widgets/header_widget.dart';

class RegisterationPage extends StatefulWidget {
  final Function? toggleView;
  const RegisterationPage({super.key, this.toggleView});

  @override
  State<StatefulWidget> createState() {
    return _Register();
  }
}

class _Register extends State<RegisterationPage> {
  // final AuthenticationManager _auth = Get.put(AuthenticationManager());
  bool _Checkbox = false;
  final double _headerHeight = 180;
  bool _obscureText = true;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _Name = TextEditingController();
  var local = Get.locale.toString();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      body: Stack(children: [
        SizedBox(
          height: _headerHeight,
        ),
        SafeArea(
            child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: ListView(
            // physics: const NeverScrollableScrollPhysics(),
            children: [
              Center(
                child: Image.asset(
                  'assets/logo.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                ),
              ),
              Center(
                child: Text(
                  'Register'.tr,
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                // autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20.0),
                      Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                              cursorColor: blackColor,
                              textAlign: local == "ar_Sa" || local == "ar_ar"
                                  ? TextAlign.right
                                  : TextAlign.left,
                              controller: _Name,
                              autofocus: false,
                              validator: (key) =>
                                  validations.validateName(context, key!),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: primaryColor),
                                    //  borderRadius: BorderRadius.circular(32.0),
                                  ),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: "User_Name".tr,
                                  border: OutlineInputBorder(
                                      //    borderRadius: BorderRadius.circular(32.0),
                                      )))),
                      const SizedBox(height: 25.0),
                      EmailTextField(_email, context),
                      const SizedBox(height: 25.0),
                      passwordTextField(_password, context),
                      InkWell(
                        onTap: () {
                          //    Get.to(() => const TermsConditions(false));
                        },
                        child: Text(
                          "terms_conditions".tr,
                          style: const TextStyle(
                            color: blackColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      CheckboxListTile(
                        title: Text(
                          'agree_terms_conditions'.tr,
                        ),
                        // subtitle:
                        //     const Text('remove the trach + clean your cloths'),
                        activeColor: SecondaryColor,
                        checkColor: primaryColor,
                        value: _Checkbox,
                        selected: _Checkbox,
                        onChanged: ((value) {
                          setState(() {
                            _Checkbox = value!;
                          });
                        }),
                      ),
                      const SizedBox(height: 5.0),
                      TextButton(
                          onPressed: () {
                            //  widget.toggleView!();
                            Get.to(() => const LoginPage());
                          },
                          child: Text(
                            'Go_to_login'.tr,
                            style: const TextStyle(color: primaryColor),
                          )),
                      const SizedBox(height: 20.0),
                      // Obx(() => _auth.isLoading.value
                      //     ? const Column(
                      //         children: [
                      //           Center(
                      //             child: CircularProgressIndicator(
                      //               color: primaryColor,
                      //             ),
                      //           ),
                      //           SizedBox(height: 10.0),
                      //         ],
                      //       )
                      //     : Container(
                      //         decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(25),
                      //       ))),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: SecondaryColor,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () async {
                            if (_Checkbox == true) {
                              if (_formKey.currentState!.validate()) {
                                // _auth.isLoading.value = true;
                                // dynamic result =
                                //     await _auth.registerEmailPassword(
                                //         LoginUser(
                                //             email: _email.text,
                                //             password: _password.text),
                                //         _Name.text);
                                // if (result.uid == null) {
                                //   _auth.isLoading.value = false;
                                //   showerrorAlert(context, "", "${result.code}",
                                //       () => Get.back());
                                // }
                              } else {
                                //   _auth.isLoading.value = false;
                              }
                            } else {
                              showerrorAlert(context, "", "must_agree".tr,
                                  () => Get.back());
                            }
                          },
                          child: Text(
                            "Register".tr,
                            style: const TextStyle(color: whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ))
      ]),
    );
  }
}
