import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../style.dart';
import 'drawer.dart';

class SearchPage extends StatefulWidget {
  SearchPage() : super();

  @override
  JobsState createState() => JobsState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class JobsState extends State<SearchPage> {
  final _debouncer = Debouncer();

  List<dynamic> ulist = [];
  List<dynamic> ProductLists = [];

  // String url = AppUrl.product;

  // var imguil = ImageandvidoeUrlpath.asseturl;

  getAllulistList() async {
    final response = await http.get(Uri.parse(""));
    if (response.statusCode == 200) {
      //List<SearchProductModel>
      var list = jsonDecode(response.body);
      var data = list;
      return data;
    } else {
      throw Exception('Error');
    }
  }

  // static List<SearchProductModel> parseAgents(String responseBody) {
  //   final parsed = json.decode(responseBody);

  //   return parsed
  //       .map<SearchProductModel>((json) => SearchProductModel.fromJson(json))
  //       .toList();
  // }

  @override
  void initState() {
    super.initState();
    getAllulistList().then((subjectFromServer) {
      setState(() {
        ulist = subjectFromServer;
        ProductLists = ulist;
      });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //Main Widget
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: ClientDrawer(),
      appBar: AppBar(
        title: Text("Search".tr),
        actions: [],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              textInputAction: TextInputAction.search,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                suffixIcon: InkWell(
                  child: Icon(
                    Icons.search,
                    color: primaryColor,
                  ),
                ),
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Search'.tr,
              ),
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    ProductLists = ulist
                        .where(
                          (u) => (u['name'].toLowerCase().contains(
                                string.toLowerCase(),
                              )),
                        )
                        .toList();
                  });
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.all(5),
              itemCount: ProductLists.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             Product_Details(pro_det: ProductLists[index])));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              ProductLists[index]["name"].toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                            subtitle: Text(
                              " ${ProductLists[index]["price"].toString()}" +
                                  "  SDG   ",
                              style:
                                  TextStyle(fontSize: 12, color: primaryColor),
                            ),
                            leading: Container(
                                // width: 50.w,
                                // height: 50.h,
                                child: ProductLists[index]['image'] !=
                                            "productscontrollrt/defaut.jpg" ||
                                        ProductLists[index]['image'] == null ||
                                        ProductLists[index]['image'] == ""
                                    ? Image.network(
                                        "${ProductLists[index]['image'].toString()}",
                                      )
                                    : Image.network(
                                        "https://cdn.sanity.io/images/0vv8moc6/contpeds/d198c3b708a35d9adcfa0435ee12fe454db49662-640x400.png/no-image-available-icon-6.jpg?fit=crop&auto=format")),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
