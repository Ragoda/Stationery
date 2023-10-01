// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(child: Image.asset('assets/images/profile_pic.png')),
//           const Text(
//             "Hello Anoos!",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset('assets/images/github.png', width: 60),
//               const SizedBox(width: 10),
//               const Text(
//                 "https://github.com/SinaSys",
//                 style: TextStyle(fontSize: 20),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
// ignore_for_file: unused_import, file_names, override_on_non_overriding_member, prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously, non_constant_identifier_names, deprecated_member_use, unused_local_variable, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:stationery/src/view/screen/home_screen.dart';

import '../../../style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var box = GetStorage();
  // final AuthenticationManager _auth = AuthenticationManager();
  final _Name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final picker = ImagePicker();

  // final lowyerController _controller = Get.put(lowyerController());
  File? imgFile;
  final imgPicker = ImagePicker();
  bool change_image = false;
  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Options"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Capture Image From Camera"),
                    onTap: () {
                      openCamera(context);
                      setState(() {
                        change_image = true;
                      });
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Take Image From Gallery"),
                    onTap: () {
                      openGallery(context);
                      setState(() {
                        change_image = true;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openCamera(context) async {
    var imgCamera = await imgPicker.pickImage(source: ImageSource.camera);
    setState(() {
      imgFile = File(imgCamera!.path);
    });

    Navigator.of(context).pop();
  }

  void openGallery(context) async {
    var imgGallery = await imgPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgFile = File(imgGallery!.path);
    });
    Navigator.of(context).pop();
  }

  Widget displayImage() {
    if (imgFile == null) {
      return Text("No Image Selected!");
    } else {
      return Image.file(imgFile!, width: 350, height: 350);
    }
  }

  Future pickImage(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        setState(() {
                          final pickedFile =
                              picker.pickImage(source: ImageSource.gallery);
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        // openCamera(context);
                        setState(() {
                          final pickedFile =
                              picker.pickImage(source: ImageSource.camera);
                        });
                      },
                    )
                  ],
                ),
              ));
        });
  }

  String profilePicLink = "";

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    // Reference ref =
    //     FirebaseStorage.instance.ref().child("images/profile_image");

    // await ref.putFile(File(image!.path));

    // ref.getDownloadURL().then((value) async {
    //   setState(() {
    //     profilePicLink = value;
    //   });
    //});
  }

  //Reference ref = FirebaseStorage.instance.ref().child("images/profile_image");

  @override
  initState() {
    setState(() {
      //   _controller.check_internet();
    });
    super.initState();
    //_auth.downloadedUrl.toString();
  }

  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // AuthenticationManager auth = Get.put(AuthenticationManager());
    // final storageRef = FirebaseStorage.instance.ref();
    // final imageRef = storageRef
    //     .child("images/profile_image/${_firebaseAuth.currentUser!.uid}");
    var email = box.read('email').toString();
    //  var name = box.read("name").toString();
    var myimage = box.read("myimage");
    var myphone = box.read("myphone");
    var id = box.read("id");
    // name == "null" ? name = " " : name = box.read("name").toString();
    myphone.toString() != "null" && myphone.toString() != ""
        ? myphone = box.read("myphone").toString()
        : "";
    // _auth.downloadedUrl.toString;
    // Future<dynamic> imaaaage = _auth.download_profile_image();

    return Scaffold(
      //  endDrawer: ClientDrawer(),
      // appBar: AppBar(
      //   elevation: 0,
      //   actions: [
      //  Builder(
      //   builder: (context) => IconButton(
      //     icon: const Icon(Icons.list, color: primaryColor),
      //     onPressed: () => Scaffold.of(context).openEndDrawer(),
      //     tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      //   ),
      // ),
      //  ],
      //   centerTitle: true,
      //   title: Text(
      //     "MyProfile".tr,
      //     style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
      //   ),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios),
      //     iconSize: 20.0,
      //     onPressed: () {
      //       Get.to(() => HomeScreen());
      //     },
      //   ),
      //   backgroundColor: SecondaryColor,
      // ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
          padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: primaryColor,
                    child: ClipOval(
                      child: SizedBox(
                        width: 110.0,
                        height: 110.0,
                        child: (imgFile != null)
                            ? Image.file(
                                imgFile!,
                                fit: BoxFit.fill,
                              )
                            : Image.asset('assets/images/profile_pic.png'),

                        // Image.network(
                        //     "https://cdn-icons-png.flaticon.com/512/1184/1184379.png?w=740&t=st=1685025419~exp=1685026019~hmac=a880cd9928c2fe54f9c8c4c849240bcce1934f9583771e22dca1968b117e5002",
                        //     fit: BoxFit.fill,
                        //   )
                        // : FutureBuilder(
                        //     future: auth.download_profile_image(),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasData) {
                        //         return CachedNetworkImage(
                        //           imageUrl:
                        //               auth.downloadedUrl.toString(),
                        //           imageBuilder:
                        //               (context, imageProvider) =>
                        //                   Container(
                        //             decoration: BoxDecoration(
                        //               image: DecorationImage(
                        //                 image: imageProvider,
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ),
                        //           placeholder: (context, url) =>
                        //               CircularProgressIndicator(
                        //             color: SecondaryColor,
                        //           ),
                        //           errorWidget: (context, url, error) =>
                        //               Icon(Icons.error),
                        //         );
                        //       } else {
                        //         return Image.network(
                        //           "https://cdn-icons-png.flaticon.com/512/1184/1184379.png?w=740&t=st=1685025419~exp=1685026019~hmac=a880cd9928c2fe54f9c8c4c849240bcce1934f9583771e22dca1968b117e5002",
                        //           fit: BoxFit.fill,
                        //         );
                        //       }
                        //     }),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.camera,
                    size: 30.0,
                  ),
                  onPressed: () {
                    showOptionsDialog(context);
                    //   pickImage(context);
                  },
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                ...ListTile.divideTiles(
                                  color: Colors.grey,
                                  tiles: [
                                    TextFormField(
                                        controller: _Name,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  20.0, 15.0, 20.0, 15.0),
                                          // hintText: auth
                                          //     .get_user_name()
                                          //     .toString(),
                                          hintText: "Anoss",
                                          suffixIcon: Icon(Icons.person),
                                        )),
                                    TextField(
                                        enabled: false,
                                        controller: _email,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  20.0, 15.0, 20.0, 15.0),
                                          hintText: "anoss@gmail.com",
                                          //("$email".tr),
                                          suffixIcon: Icon(Icons.email),
                                        )),
                                    TextFormField(
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        controller: _phone,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  20.0, 15.0, 20.0, 15.0),
                                          hintText: '0000000000',
                                          // ("${myphone}"),
                                          suffixIcon: Icon(Icons.phone),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // Obx(() => _auth.isLoading.value
                //     ? const Center(
                //         child: CircularProgressIndicator(
                //           color: primaryColor,
                //         ),
                //       )
                //     : Container(
                //         decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(25),
                //       ))),
                SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: SecondaryColor,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      // _auth.isLoading.value = true;
                      // _auth.get_user_name().toString();

                      // _auth.updateuserProfile(
                      //   displayName: _Name.text.isEmpty
                      //       ? auth.get_user_name().toString()
                      //       : _Name.text,
                      // );

                      // final result = await FirebaseFirestore.instance
                      //     .collection('users')
                      //     .doc(id)
                      //     .update({
                      //   'phone': _phone.text == "null" || _phone.text == ""
                      //       ? myphone.toString()
                      //       : _phone.text,
                      // }).then((value) => box.write(
                      //         "myphone",
                      //         _phone.text == "null" || _phone.text == ""
                      //             ? myphone.toString()
                      //             : _phone.text));

                      // try {
                      //   var metadata = SettableMetadata(
                      //     contentType: "image/jpeg",
                      //   );

                      //   if (imgFile != null && change_image == true) {
                      //     File selectedImagePath = File(imgFile!.path);
                      //     _auth.updateuserProfile(
                      //       displayName: _Name.text.isEmpty
                      //           ? auth.get_user_name().toString()
                      //           : _Name.text,
                      //     );
                      //     await imageRef
                      //         .putFile(selectedImagePath, metadata)
                      //         .whenComplete(() {
                      //       setState(() {
                      //         auth.download_profile_image();
                      //       });
                      //     });
                      //   } else {
                      //     change_image == true
                      //         ? showerrorAlert(
                      //             context,
                      //             "",
                      //             ("No_Image_selected").tr,
                      //             () => Get.back())
                      //         : null;
                      //   }
                      // } on FirebaseException catch (e) {
                      //   showerrorAlert(context, "", "$e", () => Get.back());
                      // }

                      // showAlert(context, "Updated_Successfully".tr, "",
                      //     () => Get.to(() => Home(0)));
                    },
                    child: Text(
                      "Update_profile".tr,
                      style: TextStyle(color: whiteColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        //    Obx(() => errmsg("No_Internet".tr, _controller.isoffline.value)),
      ),
    );
  }
}
