import 'dart:convert';
import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cnergyico/HistoryPage.dart';
import 'package:cnergyico/LoginPage.dart';
import 'package:cnergyico/OrderPage.dart';
import 'package:cnergyico/Uniform.dart';
import 'package:cnergyico/addusers.dart';
import 'package:cnergyico/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BycoUserScreens extends StatefulWidget {
  const BycoUserScreens({Key? key}) : super(key: key);

  @override
  _BycoUserScreensState createState() => _BycoUserScreensState();
}

class _BycoUserScreensState extends State<BycoUserScreens> {
  var uid, uname, upass, ucnic, uphone;
  late String _mySelection;
  File? _image ;
  List<File?> selectedImage = [];
  File? _image1;
  UploadTask? task;
  late String basename;
  List<String> selectedItemValue = [];
  int _counter = 0;

  // File _image;
  late String _uploadedFileURL;
  String isLoading = "false";

  String checkloadbtn = "Confirm";

  String isLoadingCircle = "false";
  // ignore: deprecated_member_use
  List<TextEditingController> amountController = [];
  void shprefer1() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      uid = sharedPreferences.get("id");
      uname = sharedPreferences.get("username");
      uphone = sharedPreferences.get("phone");
      upass = sharedPreferences.get("pasword");
      ucnic = sharedPreferences.get("CNIC");
    });
  }

  @override
  void initState() {
    // shprefer();
    //getSWData();
    this.getSWData();
    shprefer1();
    _fetchData();
    //checkfields();
    //checkLogin();
  }
  String dropdownValue = "Normal Uniform";
  String dropdownValue1 = "Small";
  String dropdownValue2 = "Refinery";
  String dropdownValue3 = "NA";
  int _selectedIndex = 0;
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
  List data = [];

  Future<String> getSWData() async {
    var res = await http.get(
        Uri.parse("http://151.106.17.246:8080/byco/api/uni_size.php"),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
  }
  bool post_clicked = false;
  Future<void> request(String orderid,String amount) async {
    print(dropdownValue3);
    // print(amountController.text.toString());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int date = DateTime.now().microsecondsSinceEpoch;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/bycopay$date');
    UploadTask uploadtask = ref.putFile(_image!.absolute);
    await Future.value(uploadtask);
    var newUrl = await ref.getDownloadURL();
    print(newUrl.toString());
    print(
        'http://151.106.17.246:8080/byco/api/update_order_image_account.php?image=${newUrl.toString()}&amount=${amount}&orderid=${orderid}');
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://151.106.17.246:8080/byco/api/update_order_image_account.php?image=${newUrl.toString()}&bank=${dropdownValue3}&amount=${amount}&orderid=${orderid}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Order Updated Successfully");
    } else {
      Fluttertoast.showToast(msg: response.statusCode.toString());
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // if(index == 2){
      //   // Navigator.of(context).push(
      //   //   MaterialPageRoute(
      //   //       builder: (context) => TripsScreen()
      //   //   ),
      //   // );
      //   Navigator.pushReplacement<void, void>(
      //     context,
      //     MaterialPageRoute<void>(
      //       builder: (BuildContext context) => const TripsScreen(),
      //     ),
      //   );
      // }
      // else
      if (index == 0) {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //       builder: (context) => OrderScreen()
        //   ),
        // );
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const UniformScreen(),
          ),
        );
      } else if (index == 1) {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //       builder: (context) => HistoryScreen()
        //   ),
        // );
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const BycoUserScreens(),
          ),
        );
      } else if (index == 2) {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //       builder: (context) => HistoryScreen()
        //   ),
        // );
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const BycoUserScreens(),
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

  List _loadedPhotos = [];

  Future<void> _fetchData() async {
    String API_URL = 'http://151.106.17.246:8080/byco/api/unilist.php?userid=' +
        uid.toString();
    // const API_URL = 'https://jsonplaceholder.typicode.com/photos';

    print(API_URL);
    HttpClient client = new HttpClient();
    client.autoUncompress = true;

    final HttpClientRequest request = await client.getUrl(Uri.parse(API_URL));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    final HttpClientResponse response = await request.close();

    final String content = await response.transform(utf8.decoder).join();

    final List data = json.decode(content);
    print("User ID " + uid.toString());

    setState(() {
      _loadedPhotos = data;
    });
  }

  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _fetchData();
  //   // print(_loadedPhotos.toString());
  // }

  @override
  Widget build(BuildContext context) {
    List cardList = [];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                "Invoice List",
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.bookmark_border),
          //   label: 'Order',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new_outlined,color: Colors.grey,),
            label: 'Uniform',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history,color: Colors.amber,),
            label: 'Invoice',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget listscrrr() {
    return Container(
      child: SafeArea(
        child: _loadedPhotos.length == 0
            ? Center(
          child: ElevatedButton(
            child: Text('Load Data...'),
            onPressed: _fetchData,
          ),
        )
        // The ListView that displays photos
            : ListView.builder(
          itemCount: _loadedPhotos.length,
          itemBuilder: (BuildContext ctx, index) {
            amountController!.add(new TextEditingController());
            for (int i = 0; i < _loadedPhotos.length; i++) {
              selectedItemValue.add("NA");
              selectedImage.add(_image);
            }
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
                        child: Text(" Details",
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
                            Text('Uniform Type: ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              '${_loadedPhotos[index]["type"]}',
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
                            Text('Small Quantity: ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Text('${_loadedPhotos[index]["size_1"]}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Medium Quantity: ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Text('${_loadedPhotos[index]["size_2"]}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Large Quantity: ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Text('${_loadedPhotos[index]["size_3"]}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text('X-Large Quantity: ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Text('${_loadedPhotos[index]["size_4"]}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Status: ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            if(_loadedPhotos[index]["status"]=='0')
                              Text('Pending',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            if(_loadedPhotos[index]["status"]=='1')
                              Text('Completed',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            if(_loadedPhotos[index]["status"]=='2')
                              Text('Cancelled',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Amount: ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Text('${_loadedPhotos[index]["total_amount"]}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Select Bank",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Container(
                          width: double.infinity,
                          child: DropdownButton<String>(
                            value: selectedItemValue[index].toString(),
                            // value: "HBL Bank Ltd.",
                            hint: Text('Select bank'),
                            // icon: const Icon(Icons.arrow_downward),
                            // iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 18),
                            // underline: Container(
                            //   height: 2,
                            //   color: Colors.deepPurpleAccent,
                            // ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedItemValue[index] = newValue!;
                              });
                            },
                            // value: dropdownValue3.toString(),
                            items: _dropDownItem(),

                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),


                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Enter Amount",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: TextField(
                            inputFormatters: [
                              CurrencyTextInputFormatter(
                                locale: 'ko',
                                decimalDigits: 0,
                                symbol: ' ',
                              )
                            ],
                            controller: amountController[index],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Amount',
                                hintText: 'Enter Amount',
                                labelStyle: TextStyle(
                                    fontSize: 18, letterSpacing: 1)),
                          ),
                        ),
                        SizedBox(
                          height: 05,
                        ),

                        InkWell(
                          onTap: () {
                            dialog(context,index);
                          },
                          child: Column(
                            children: [
                              // Icon(Icons.camera_alt),
                              Center(
                                child: Container(
                                  // height: MediaQuery.of(context).size.height * .2,
                                  // width: MediaQuery.of(context).size.width * 1,
                                  height: 150,
                                  width: double.infinity,
                                  child: selectedImage[index] != null
                                      ? ClipRect(
                                    child: Image.file(
                                      selectedImage[index]!.absolute,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                                      : Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white60,
                                      border: Border.all(width: 3),
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Constants.primarygreen,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 05,
                        ),

                        GestureDetector(
                          onTap: () {
                            request(_loadedPhotos[index]["id"],amountController[index].text.toString());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 50,
                            child: Text(
                              "Place Order",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Constants.primaryorrange,
                                fontSize: 20,
                                letterSpacing: 5,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Constants.primarygreen,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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

  final picker = ImagePicker();

  Future getImage(index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        selectedImage[index] = File(pickedFile.path);
        print(selectedImage[index]);
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
      } else {
        print("no image selected");
      }
    });
  }

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> ddl = ['NA',
      'HBL Bank Ltd.',
      'Bank AL Habib',
      'MCB',
      'Silk Bank',
      'Askari Bank',
      'Bank Alfalah Limited',
      'National Bank',
      'Meezan Bank',
      'Faysal Bank (Islamic)',
      'Other'];
    return ddl
        .map((value) => DropdownMenuItem(
      value: value,
      child: Text(value),
    ))
        .toList();
  }
  void dialog(context,index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 60,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getImage(index);
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("Gallery"),
                    ),
                  ),
                  /*InkWell(
                    onTap: () {
                      getCamera();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text("Camera"),
                    ),
                  ),*/
                ],
              ),
            ),
          );
        });
  }

  deleteusers(String userid) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var jsonResponse = null;

    var response = await http.delete(Uri.parse(
      "http://151.106.17.246:8080/byco/api/deleteuser.php?id=" + userid,
    ));
    // var response = await http.delete(Uri.parse("http://151.106.17.246:8080/byco/api/deleteuser.php?id=22",));

    print(userid.toString());
    // jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      print("Deleted User Successfully");
      return jsonResponse = json.decode(response.body);
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete User.');
    }
  }
}
