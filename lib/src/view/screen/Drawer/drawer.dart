// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stationery/src/view/screen/home_screen.dart';
import 'package:stationery/src/view/screen/profile_screen.dart';
import 'package:stationery/style.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../Controller/authentication.dart';
import '../../../model/langu.dart';
import '../product_list_screen.dart';
import 'about.dart';
import 'notifications.dart';

class ClientDrawer extends StatefulWidget {
  const ClientDrawer({super.key});

  @override
  _ClientState createState() => _ClientState();
}

var box = GetStorage();
launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _ClientState extends State<ClientDrawer> {
  // final AuthenticationManager auth = Get.put(AuthenticationManager());

  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  var open_chat;

  var email = box.read("email");

  // final _auth = Get.put(AuthenticationManager());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    open_chat = box.read("open_chat");

    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: Drawer(
          child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.only(left: 0, bottom: 0),
                  height: size.height,
                  child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                              ),
                            ),
                            child: SizedBox(
                                height: size.height / 5,
                                width: size.width,
                                child: Image.asset("assets/logo.jpg"))),
                        Container(
                            decoration: const BoxDecoration(
                              color: whiteColor,
                            ),
                            child: Column(children: <Widget>[
                              ListTile(
                                  leading: const Icon(
                                    Icons.home,
                                    color: primaryColor,
                                  ),
                                  title: Text(
                                    'Home_Page'.tr,
                                    style: TextStyle(fontSize: size.width / 24),
                                  ),
                                  onTap: () {
                                    Get.to(() => const HomeScreen());
                                  }),
                              //  Divider(),
                              ListTile(
                                  leading: const Icon(
                                    Icons.credit_card,
                                    color: primaryColor,
                                  ),
                                  title: Text(
                                    "payment_transactions".tr,
                                    style: TextStyle(fontSize: size.width / 24),
                                  ),
                                  onTap: () {
                                    //  Get.to(() => payment_transactions());
                                  }),
                              //   const Divider(),
                              ListTile(
                                  leading: const Icon(
                                    Icons.notifications,
                                    color: primaryColor,
                                  ),
                                  title: Text(
                                    "Notifications".tr,
                                    style: TextStyle(fontSize: size.width / 24),
                                  ),
                                  onTap: () {
                                    Get.to(() => NotificationScreen());
                                  }),

                              ListTile(
                                  leading: const Icon(
                                    Icons.info,
                                    color: primaryColor,
                                  ),
                                  title: Text(
                                    "About_Us".tr,
                                    style: TextStyle(fontSize: size.width / 24),
                                  ),
                                  onTap: () {
                                    Get.to(() => AboutUs());
                                  }),

                              ListTile(
                                  leading: const Icon(
                                    Icons.phone,
                                    color: primaryColor,
                                  ),
                                  title: Text(
                                    "All_purchases".tr,
                                    style: TextStyle(fontSize: size.width / 24),
                                  ),
                                  onTap: () {
                                    Get.to(() => ProductListScreen());
                                  }),
                              ListTile(
                                  leading: const Icon(
                                    Icons.person,
                                    color: primaryColor,
                                  ),
                                  title: Text(
                                    "MyProfile".tr,
                                    style: TextStyle(fontSize: size.width / 24),
                                  ),
                                  onTap: () async {
                                    Get.to(() => const ProfileScreen());
                                  }),
                              // ListTile(
                              //     leading: const Icon(
                              //       Icons.money_outlined,
                              //       color: primaryColor,
                              //     ),
                              //     title: Text(
                              //       "Account Statement".tr,
                              //       style: TextStyle(fontSize: size.width / 24),
                              //     ),
                              //     onTap: () async {
                              //       Get.to(() => const Account_Statement());
                              //     }),
                              ListTile(
                                  leading: const Icon(
                                    Icons.language,
                                    color: primaryColor,
                                  ),
                                  title: Text(
                                    'Language'.tr,
                                    style: TextStyle(fontSize: size.width / 24),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      //  lang_dropdown();
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            title: Text('Choose_Language'.tr),
                                            content: lang_dropdown(),
                                          );
                                        },
                                      );
                                    });
                                  }),

                              // ListTile(
                              //     leading: const Icon(
                              //       Icons.language,
                              //       color: primaryColor,
                              //     ),
                              //     title: Text(
                              //       'Language'.tr,
                              //       style: TextStyle(fontSize: size.width / 24),
                              //     ),
                              //     onTap: () {
                              //       loggerNoStack.i(Get.locale);
                              //       auth.ChangeLanguage();
                              //     }),
                              // FutureBuilder(
                              //   future: _auth.get_chat_Allow(),
                              //   builder: (BuildContext context,
                              //       AsyncSnapshot snapshot) {
                              //     if (snapshot.data.toString() != "") {
                              //       return ListTile(
                              //           leading: const Icon(
                              //             Icons.message,
                              //             color: primaryColor,
                              //           ),
                              //           title: Text(
                              //             'chat'.tr,
                              //             style: TextStyle(
                              //                 fontSize: size.width / 24),
                              //           ),
                              //           onTap: () {
                              //           //  Get.to(() => ChatScreen());
                              //           });
                              //     }
                              //     return Container();
                              //   },
                              // ),

                              ListTile(
                                  leading: const Icon(
                                    Icons.logout_rounded,
                                    color: primaryColor,
                                  ),
                                  title: Text(
                                    "Logout".tr,
                                    style: TextStyle(
                                        color: SecondaryColor,
                                        fontSize: size.width / 24),
                                  ),
                                  onTap: () {
                                    //  auth.signOut();
                                  }),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                            onTap: () async {
                                              launchURL(
                                                  'https://www.facebook.com/profile.php?id=100073949701577&mibextid=V3Yony ');
                                            },
                                            child: Hero(
                                                tag: Icon,
                                                child: FaIcon(
                                                  Icons.facebook,
                                                  color: Colors.blue,
                                                  size: 40,
                                                ))),
                                        InkWell(
                                            onTap: () {
                                              launchURL(
                                                  'https://instagram.com/alakhwanlibary?igshid=NTc4MTIwNjQ2YQ==');
                                            },
                                            child: SizedBox(
                                              width: 30,
                                              child: Image.asset(
                                                'assets/instg.jpg',
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                        InkWell(
                                            onTap: () {
                                              launchURL("tel:+249929996943");
                                            },
                                            child: SizedBox(
                                              height: 30,
                                              child: Image.network(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThY7Lf_AMY2mwPIs4j3qa_HBGsrA4tgQXGtjpe1TJ5QkNSQJhcu1eYzGma_Z0sLdubJkQ&usqp=CAU"),
                                            )),
                                        InkWell(
                                            onTap: () {
                                              launchURL(
                                                  "mailto:alakhwanlibary@gmail.com");
                                            },
                                            child: SizedBox(
                                              width: 30,
                                              child: Image.asset(
                                                'assets/mail.png',
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]))
                      ])),
            ),
          ],
        ),
      )),
    );
  }
}

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
