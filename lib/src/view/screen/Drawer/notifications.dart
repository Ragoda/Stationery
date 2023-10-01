// ignore_for_file: unused_import, file_names, override_on_non_overriding_member, import_of_legacy_library_into_null_safe, camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names, library_private_types_in_public_api
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../style.dart';
import 'drawer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

var box = GetStorage();

class _MyAppState extends State<NotificationScreen> {
  var myNotification;
  String? token1;
  var box = GetStorage();
  //final lowyerController _controller = Get.put(lowyerController());
  @override
  void initState() {
    setState(() {
      //   _controller.check_internet();
    });
    super.initState();
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    //get token of mobile device
  }

  @override
  Widget build(BuildContext context) {
    var email = box.read('email').toString();
    // ignore: no_leading_underscores_for_local_identifiers
    // final CollectionReference _notifications =
    //     FirebaseFirestore.instance.collection('notifications');
    getdata() {
      //  return _notifications.where('user', isEqualTo: email).snapshots();
    }

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
            'Notifications'.tr,
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
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 89.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                    stream: getdata(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 50),
                          child: streamSnapshot.data!.docs.length != 0
                              ? ListView.builder(
                                  itemCount: streamSnapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot documentSnapshot =
                                        streamSnapshot.data!.docs[index];

                                    return notif_card(
                                      message: documentSnapshot,
                                    );
                                  })
                              : Center(
                                  child: Text(
                                  "No Data Yet".tr,
                                  style: TextStyle(fontSize: 20),
                                )),
                        );
                      }
                      return Container();
                    }),
              ),
            ),
            //  Obx(() => errmsg("No_Internet".tr, _controller.isoffline.value)),
          ],
        ));
  }
}

class notif_card extends StatelessWidget {
  final message;
  const notif_card({
    super.key,
    required DocumentSnapshot<Object?> this.message,
  });

  @override
  Widget build(BuildContext context) {
    var date = message['date'];
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(5),
          width: double.infinity,
          child: ListTile(
            leading: const Icon(
              Icons.notification_add_sharp,
              color: primaryColor,
            ),
            title: Text("Notifications".tr),
            subtitle: Text('${message["title"]}'.toString()),
            trailing: Text("$date"),
          ),
        ));
  }
}
