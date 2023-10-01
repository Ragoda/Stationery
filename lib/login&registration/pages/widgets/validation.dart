import 'package:flutter/material.dart';

class Validations {
  String? validateName(BuildContext context, String value) {
    if (value.isEmpty) return "Field is required";
    return null;
  }

  String? validateaddress(BuildContext context, String value) {
    if (value.isEmpty) return "enter_address";
    return null;
  }

  String? validatePrice(BuildContext context, String value) {
    if (value.isEmpty) return "enter_price";
    return null;
  }

  String? validateaccountnumber(BuildContext context, String value) {
    if (value.isEmpty) return "enter_accountnumber";
    return null;
  }

  String? validateEmail(BuildContext context, String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (value == "null" || value == "") {
      return null;
    }
    if (!regex.hasMatch(value)) {
      return "Validate Email";
    } else {
      return null;
    }
  }

  String? validatePassword(BuildContext context, String value) {
    if (value.isEmpty) {
      return "validatePasswordEmpty";
    }

    if (value.length < 8) {
      return "validatePassword";
    } else {
      return null;
    }
  }

  String? validateMobile(BuildContext context, String value) {
    if (value.length != 10) {
      return "Wrong Phone Number";
    } else {
      return null;
    }
  }
}
