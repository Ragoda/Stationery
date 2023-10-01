// // ignore_for_file: depend_on_referenced_packages, camel_case_types, use_build_context_synchronously, non_constant_identifier_names, prefer_typing_uninitialized_variables, unnecessary_null_comparison, file_names, unused_local_variable

// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:rakadvocates/Utils/logger.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

// import '../../Utils/theme/style.dart';
// import '../Utils/tost_message.dart';
// import 'authentication.dart';

// class lowyerController extends GetxController {
//   final CollectionReference _collectionRef =
//       FirebaseFirestore.instance.collection('notifications');
//   final AuthenticationManager _auth = Get.put(AuthenticationManager());
//   final Rx<CollectionReference<Map<String, dynamic>>> _Schedule =
//       FirebaseFirestore.instance.collection('Schedule').obs;
//   StreamSubscription? internetconnection;
//   var isoffline = false.obs;
//   var counter = 0.obs;
//   var select_user = "".obs;
//   var title = "".obs;
//   var date = "".obs;
//   var selectedIndex = 0.obs;
//   @override
//   void onInit() {
//     check_internet();
//     super.onInit;
//   }

//   void gotoSchedule() {
//     selectedIndex.value = 1;
//     selectedIndex.value.obs;
//   }

//   Future<void> delete(String Id, context) async {
//     await _Schedule.value.doc(Id).delete();
//     Alert(
//       style: const AlertStyle(
//           backgroundColor: whiteColor,
//           titleStyle: TextStyle(
//             color: blackColor,
//           ),
//           descStyle: TextStyle(
//             color: blackColor,
//           )),
//       context: context,
//       type: AlertType.success,
//       title: "Successfully_Done".tr,
//       desc: "You have successfully delete an appointment".tr,
//       buttons: [
//         DialogButton(
//           color: primaryColor,
//           onPressed: () {
//             Get.back();
//           },
//           width: 120,
//           child: Text(
//             "OK".tr,
//             style: const TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         )
//       ],
//     ).show();
//   }

//   var box = GetStorage();

//   reScheduledate(BuildContext context, documentSnapshot) async {
//     var name = _auth.get_user_name().toString();
//     var result;
//     var searchResult;
//     var selected_time;
//     DateTime? startPickedDate = await showDatePicker(
//         // builder: (context, child) {
//         //   return Theme(
//         //     data: Theme.of(context).copyWith(
//         //         colorScheme: ColorScheme.light(primary: primaryColor)),
//         //     child: Container(),
//         //   );
//         // },
//         //  locale: Get.locale,
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime.now(),
//         lastDate: DateTime(2100));
//     if (startPickedDate != null) {
//       String formattedDate = DateFormat('yyyy-MM-dd').format(startPickedDate);

//       TimeOfDay? pickedTime = await showTimePicker(
//         initialTime: TimeOfDay.now(),
//         context: context,
//       );

//       if (pickedTime != null) {
//         loggerNoStack.i(pickedTime.format(context));
//         DateTime parsedTime =
//             DateFormat.jm().parse(pickedTime.format(context).toString());

//         loggerNoStack.i(parsedTime);
//         String formattedTime = DateFormat('HH:mm a').format(parsedTime);
//         loggerNoStack.i(formattedTime);

//         selected_time = formattedTime;
//       } else {
//         showerrorAlert(context, "not_selected".tr, "Time_is_not_selected".tr,
//             () => Get.back());
//         loggerNoStack.i("Time is not selected");
//       }

//       if (formattedDate != null) {
//         await _Schedule.value.doc(documentSnapshot!.id).update({
//           "time": "$formattedDate $selected_time",
//           "status": "Rescheduled"
//         }).then((value) async {
//           reschedule_Notification(name, formattedDate, selected_time);
//         });
//         showAlert(context, "", "${'Reschedule'.tr} ${"Successfully_Done".tr}",
//             () => Get.back());
//         //  });
//       }
//     }
//   }

//   reschedule_Notification(name, formattedDate, selected_time) async {
//     final result =
//         await FirebaseFirestore.instance.collection('employees').get();
//     var searchResult = result.docs.map((e) async {
//       e.data();
//       _auth.push_notifications(
//         e,
//         "Reschedule".tr,
//         "${"The Appointment has been Rescheduled by the user".tr} $name ${'To'.tr} $formattedDate $selected_time",
//       );
//     }).toList();
//   }

//   add_notif_message(
//     context,
//   ) {
//     // if (_formKey.currentState!.validate()) {
//     return _collectionRef.add({
//       'date': date.value.toString(),
//       'title': title.value.toString(),
//       'user': select_user.value.toString(),
//     }).then((value) {
//       _auth.sendPushMessageToWeb(
//           title.value.toString(), select_user.value.toString());
//       loggerNoStack.i(" Notification Sent Successfully ");
//       loggerNoStack.i(date.value.toString());
//       loggerNoStack.i(title.value.toString());
//       loggerNoStack.i(select_user.value.toString());
//       showAlert(
//           context, " Notification Sent Successfully", "", () => Get.back());
//       date.value = "";
//       title.value = "";
//       select_user.value = "";
//     }).catchError((error) {
//       showerrorAlert(context, "Error", "$error", () => Get.back());
//     });
//   }

//   void check_internet() {
//     internetconnection = Connectivity()
//         .onConnectivityChanged
//         .listen((ConnectivityResult result) {
//       // whenevery connection status is changed.
//       if (result == ConnectivityResult.none) {
//         //there is no any connection

//         isoffline.value = true;
//         isoffline.value.obs;
//       } else if (result == ConnectivityResult.mobile) {
//         //connection is mobile data network

//         isoffline.value = false;
//         isoffline.value.obs;
//       } else if (result == ConnectivityResult.wifi) {
//         //connection is from wifi

//         isoffline.value = false;
//         isoffline.value.obs;
//       }
//     });
//   }
// }
