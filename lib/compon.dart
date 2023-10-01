// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'login&registration/pages/widgets/validation.dart';
import 'style.dart';

Widget errmsg(String text, bool show) {
  //error message widget.
  if (show == true) {
    //if error is true then show error message box
    return Container(
      padding: const EdgeInsets.all(10.00),
      margin: const EdgeInsets.only(bottom: 10.00),
      color: Colors.red,
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 6.00),
          child: const Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: const TextStyle(color: Colors.white)),
        //show error message text
      ]),
    );
  } else {
    return Container();
    //if error is false, return empty container.
  }
}

Validations validations = Validations();
showAlert(context, title, desc, Function() onPressedfun) {
  return Alert(
    style: const AlertStyle(
        backgroundColor: whiteColor,
        titleStyle: TextStyle(
          color: blackColor,
        ),
        descStyle: TextStyle(
          color: blackColor,
        )),
    context: context,
    type: AlertType.success,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        color: primaryColor,
        onPressed: onPressedfun,
        width: 120,
        child: Text(
          "OK".tr,
          style: const TextStyle(color: blackColor, fontSize: 20),
        ),
      )
    ],
  ).show();
}

showerrorAlert(context, title, desc, Function() onPressedfun) {
  return Alert(
    style: const AlertStyle(
        backgroundColor: whiteColor,
        titleStyle: TextStyle(
          color: blackColor,
        ),
        descStyle: TextStyle(
          color: blackColor,
        )),
    context: context,
    type: AlertType.error,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        color: primaryColor,
        onPressed: onPressedfun,
        width: 120,
        child: Text(
          "OK".tr,
          style: const TextStyle(color: blackColor, fontSize: 20),
        ),
      )
    ],
  ).show();
}

Future<bool> willPopCallback(context) async {
  //loggerNoStack.i("fffffffffffffff");
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Alert".tr,
    desc: "sure_want_exit".tr,
    buttons: [
      DialogButton(
        color: primaryColor,
        onPressed: () {
          exit(0);
        },
        width: 120,
        child: Text(
          "YES".tr,
          style: const TextStyle(color: whiteColor, fontSize: 20),
        ),
      ),
      DialogButton(
        color: primaryColor,
        onPressed: () {
          Get.back();
        },
        width: 120,
        child: Text(
          "NO".tr,
          style: const TextStyle(color: whiteColor, fontSize: 20),
        ),
      )
    ],
  ).show();
  return false;
}

EmailTextField(_email, context) {
  var local = Get.locale.toString();
  return TextFormField(
      cursorColor: blackColor,
      textAlign: local == "ar_Sa" || local == "ar_ar"
          ? TextAlign.right
          : TextAlign.left,
      controller: _email,
      autofocus: false,
      validator: (key) => validations.validateEmail(context, key!),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: primaryColor),
            //  borderRadius: BorderRadius.circular(32.0),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email".tr,
          border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(32.0),
              )));
}

passwordTextField(_password, context) {
  var local = Get.locale.toString();
  return TextFormField(
      cursorColor: blackColor,
      textAlign: local == "ar_Sa" || local == "ar_ar"
          ? TextAlign.right
          : TextAlign.left,
      controller: _password,
      autofocus: false,
      validator: (key) => validations.validatePassword(context, key!),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: primaryColor),
            //    borderRadius: BorderRadius.circular(32.0),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password".tr,
          border: OutlineInputBorder(
              //  borderRadius: BorderRadius.circular(32.0),
              )));
}

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class FirebaseUser {
  final String? uid;
  final String? code; //code firebaseauth excemption
  FirebaseUser({this.uid, this.code});
}
class LoginUser {
  final String? email;
  final String? password;

  LoginUser({this.email, this.password});
}
