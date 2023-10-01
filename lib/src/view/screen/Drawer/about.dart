// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../compon.dart';
import '../../../../style.dart';

import 'drawer.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // final lowyerController _controller = Get.put(lowyerController());
  @override
  void initState() {
    super.initState();
    // using this listiner, you can get the medium of connection as well.
    setState(() {
      //  _controller.check_internet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: const ClientDrawer(),
        appBar: AppBar(
          elevation: 0,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.list, color: primaryColor),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
          backgroundColor: SecondaryColor,
          centerTitle: true,
          title: Text(
            "About_Us".tr,
            style: const TextStyle(color: whiteColor),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Stack(children: [
          Container(
              padding:
                  const EdgeInsets.only(top: 70, bottom: 50, left: 8, right: 8),
              // width: screenWidth,
              //   padding: EdgeInsets.all(8),
              child: ListView(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/logo.jpg',
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                    ),
                  ),
                  Center(
                    child: Text(
                      'مكتبه الاخوان'.tr,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        width: double.infinity,
                        child: Center(
                          child: ListTile(
                            title: Center(
                                child: Text(
                                    "مكتبه السرور ي يمه  فيها اي شي بخيته وسعيده موفقين  "
                                        .tr)),
                            // subtitle: Text("message".toString()),
                          ),
                        ),
                      )),
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      'Contact_Us'.tr,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      launchURL(
                          'https://www.google.com/maps/search/?api=1&query=31.042850382289494,31.3831819021127');
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: primaryColor,
                      ),
                      title: Text('Egypt El Mansoura Dakahlia Governorate '),
                      subtitle: Text(' TOWER, FLOOR 1'),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: primaryColor,
                    ),
                    title: InkWell(
                        onTap: () {
                          launchURL("tel:+249929996943");
                        },
                        child: const Text('+249929996943')),
                  ),
                  InkWell(
                    onTap: () {
                      launchURL("alakhwanlibary@gmail.com");
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.email,
                        color: primaryColor,
                      ),
                      title: Text('alakhwanlibary@gmail.com'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      launchURL("https://www.alakhwanlibary.com/");
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.language,
                        color: primaryColor,
                      ),
                      title: Text('https://www.alakhwanlibary.com'),
                    ),
                  ),
                ],
              )),
          //  Obx(() => errmsg("No_Internet".tr, _controller.isoffline.value)),
        ]));
  }
}
