// ignore_for_file: unused_element, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stationery/compon.dart';
import 'package:stationery/login&registration/pages/LoginPage.dart';

import '../../../../Controller/authentication.dart';
import '../../../../style.dart';
import '../../../model/langu.dart';


// final AuthenticationManager _controller = Get.find<AuthenticationManager>();

class ChoeseLang extends StatefulWidget {
  const ChoeseLang({super.key});

  @override
  _ChoeseLangState createState() => _ChoeseLangState();
}

class _ChoeseLangState extends State<ChoeseLang> {
  final double _headerHeight = 180;
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPopCallback(context),
      child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: whiteColor,
          body: Column(children: [
            SafeArea(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text(
                              'Hello'.tr,
                              style: const TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'Choose_Language'.tr,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 20.0),
                          lang_dropdown()
                        ]))),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: SecondaryColor,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () async {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => const OnBordScreen(),
                    // ));
                    Get.to(() => const LoginPage());
                  },
                  child: Text(
                    style: const TextStyle(color: whiteColor),
                    textAlign: TextAlign.center,
                    'Enter'.tr,
                    //   style: defaultProceedButtonTextStyle,
                  ),
                ),
              ),
            )
          ])),
    );
  }
}

// ignore: non_constant_identifier_names
lang_dropdown() {
  LanguageModel language = LanguageModel("عربي", "ar", "Sa");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthenticationManager auth = Get.put(AuthenticationManager());
  return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: DropdownButton(
                value: null,
                // isDense: true,
                onChanged: (newValue) {
                  language.symbol = newValue!;

                  auth.ChangeLanguages(
                      Locale(language.symbol, language.symbol));
                },
                items: languages.map((LanguageModel language) {
                  return DropdownMenuItem<String>(
                    value: language.symbol,
                    child: Text(language.language.toString()),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ));
}
