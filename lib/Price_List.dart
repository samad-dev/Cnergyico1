import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cnergyico/HistoryPage.dart';
import 'package:cnergyico/Price_List.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:cnergyico/LoginPage.dart';
import 'package:cnergyico/MapPage.dart';
import 'package:cnergyico/OrderPage.dart';
import 'package:cnergyico/TripsPage.dart';
import 'package:cnergyico/addusers.dart';
import 'package:cnergyico/bycouserlist.dart';
import 'package:cnergyico/utils/album.dart';
import 'package:cnergyico/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PriceList extends StatefulWidget {
  const PriceList({Key? key}) : super(key: key);

  @override
  _PriceList createState() => _PriceList();
}

class _PriceList extends State<PriceList> {
  final postref = FirebaseDatabase.instance.reference().child('posts');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;

  File? _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("no image selected");
      }
    });
  }

  Future getCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
      } else {
        print("no image selected");
      }
    });
  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getImage();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("Gallery"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getCamera();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text("Camera"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  uploaddata(String id, String url) async {
    var jsonResponse = null;

    var response = await http.post(Uri.parse(
      "http://151.106.17.246:8080/byco/api/orderimages.php?accesskey=12345&orderid=" +
          id +
          "&imgurl=" +
          url,
    ));

    jsonResponse = json.decode(response.body);

    print(response);

    if (jsonResponse == null) {
      setState(() {
        print("Jawad Ahmed");
        Fluttertoast.showToast(
            msg: "Image not save ",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // _isLoading = false;
        // Toast.show("Something went wrong", context,
        //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      });
    } else {
      setState(() {
        toastMessage("Image Saved...");
        print("Image Saved...");
      });
    }
  }

  void uploadimage() async {
    try {
      int date = DateTime.now().microsecondsSinceEpoch;
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('/bycopay$date');
      UploadTask uploadtask = ref.putFile(_image!.absolute);
      await Future.value(uploadtask);
      var newUrl = await ref.getDownloadURL();

      print(newUrl.toString());

      final User? user = _auth.currentUser;
      postref.child('Post List').child(date.toString()).set({
        'pId': date.toString(),
        'pImage': newUrl.toString(),
        'ptime': date.toString(),
        'uid': user!.uid.toString(),
      }).then((value) {
        toastMessage("Image Upload");
      }).onError((error, stackTrace) {
        toastMessage(error.toString());
      });
    } catch (e) {
      toastMessage("Image Upload");
    }
  }

  void toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Business',
      style: optionStyle,
    ),
    Text(
      'Index 1: School',
      style: optionStyle,
    ),
    Text(
      'Index 2: Home',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 0) {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const OrderScreen(),
          ),
        );
      }

      else if (index == 1) {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const HistoryScreen(),
          ),
        );
      }
      else if (index == 2) {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const BycoUserScreens(),
          ),
        );
      }
      else if (index == 3) {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const PriceList(),
          ),
        );
      }
    });
  }

  signout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('code');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
  }

  var userid;
  void shprefer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userid = sharedPreferences.get("id");
      // oid = sharedPreferences.get("orderid");
    });
  }

  List _loadedPhotos = [];
  // var statusactive;

  Future<void> _fetchData() async {
    String API_URL = "http://151.106.17.246:8080/byco/api/testing.php?cus_id=" +
        userid.toString() +
        "&accesskey=12345";

    HttpClient client = new HttpClient();
    client.autoUncompress = true;

    print(userid.toString());

    final HttpClientRequest request = await client.getUrl(Uri.parse(API_URL));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    final HttpClientResponse response = await request.close();

    final String content = await response.transform(utf8.decoder).join();

    final List data = json.decode(content);
    print(data);
    print("API DATA:");

    setState(() {
      _loadedPhotos = data;
    });

    // if('${_loadedPhotos[10]["status"]}' == 0) {
    //   statusactive = "Pending";
    // }
  }

  @override
  void initState() {
    shprefer();
    setState(() {
      _fetchData();
    });
    listscrrr();
    // _fetchData();
    // super.initState();
    // print(_loadedPhotos.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                "Price List",
                style: TextStyle(
                  color: Constants.primaryorrange,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                signout();
              },
              child: Container(
                child: Icon(
                  Icons.logout,
                  color: Constants.primaryorrange,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Constants.primarygreen,
      ),
      body: Container(
        child: listscrrr(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home,),
          //   label: 'Trips',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border,
              color: Colors.black45,),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history,
              color: Colors.black45,),
            label: 'History',

          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.accessibility_new_outlined,
              color: Colors.black45,
            ),
            label: 'UniForm',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.price_change_outlined,
              color: Color(0xFFFF8F00)
            ),
            label: 'Price List',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.access_time_outlined,
                color: Colors.black45
            ),
            label: 'Lube',
          ),
        ],
        currentIndex: 3 ,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget listscrrr() {
    return Container(
      child: SafeArea(
        child:  ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      // margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        // color: Colors.black,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ListTile(
                          // leading: Image.network(
                          //   _loadedPhotos[index]["thumbnailUrl"],
                          //   width: 150,
                          //   fit: BoxFit.cover,
                          // ),
                          title: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text('Product Price',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold))),
                          subtitle: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Pump: ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    'Wheel Filling Station',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Product Name: ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text('PMG',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),


                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Amount: ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text('215',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget listscrgreencar(String date, String time, String vno, String spoint,
      String epoint, String pname) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        // color: Colors.black,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(
                    date,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(
                    time,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  // color: Colors.blue,
                  width: 70,
                  // height: 50,
                  child: Text(
                    spoint,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(
                    vno,
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 50),
                  padding: EdgeInsets.only(left: 8),
                  // color: Colors.black,
                  height: 80,
                  width: 150,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          // Icon(
                          //   Icons.circle,
                          //   size: 10,
                          //   color: Colors.red,
                          // ),
                          // Icon(
                          //   Icons.car_repair,
                          //   size: 20,
                          //   color: Colors.red,
                          // )
                        ],
                      ),
                      Column(
                        children: [
                          // Container(
                          //   margin: EdgeInsets.only(top: 3),
                          //   width: 60,
                          //   height: 2,
                          //   color: Colors.green,
                          // ),
                          // Container(
                          //   margin: EdgeInsets.only(top: 3),
                          //   width: 60,
                          //   height: 2,
                          //   color: Colors.green,
                          // ),
                          //
                          // Container(
                          //   margin: EdgeInsets.only(top: 3),
                          //   width: 5,
                          //   height: 5,
                          //   color: Colors.green,
                          // ),
                        ],
                      ),
                      Column(
                        children: [
                          //
                          // Icon(
                          //   Icons.circle,
                          //   size: 10,
                          //   color: Colors.blue,
                          // ),
                          // Icon(
                          //   Icons.car_repair,
                          //   size: 20,
                          //   color: Colors.blue,
                          // )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                width: 55,
                                height: 2,
                                color: Colors.green,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                width: 50,
                                height: 2,
                                color: Colors.green,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 105),
                            child: Icon(
                              Icons.car_repair,
                              size: 20,
                              color: Colors.green,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 3),
                            child: Text(
                              "Complete",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(
                    date,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(
                    time,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(
                    epoint,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(
                    "Product: " + pname,
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  updatestatus(String ooid) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var jsonResponse = null;

    var response = await http.put(Uri.parse(
      "http://151.106.17.246:8080/byco/api/orderstatus.php?accesskey=12345&orderid=" +
          ooid,
    ));
    // var response = await http.delete(Uri.parse("http://151.106.17.246:8080/byco/api/deleteuser.php?id=22",));

    // print(userid.toString());
    // jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      print("updated order Successfully");
      print(ooid);
      print(jsonResponse);
      return jsonResponse = json.decode(response.body);
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('not uploaded order.');
    }
  }

}
