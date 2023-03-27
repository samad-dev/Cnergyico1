// ignore: file_names
// ignore: file_names
// import 'dart:html';
// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:device_info/device_info.dart';
import 'package:device_information/device_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cnergyico/AddImage.dart';
import 'package:cnergyico/addusers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:cnergyico/HistoryPage.dart';
import 'package:cnergyico/LoginPage.dart';
import 'package:cnergyico/TripsPage.dart';
import 'package:cnergyico/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:imei_plugin/imei_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage1;

import 'OrderPage.dart';
import 'bycouserlist.dart';

class UniformScreen extends StatefulWidget {
  const UniformScreen({Key? key}) : super(key: key);

  @override
  _UniformScreenState createState() => _UniformScreenState();
}

class _UniformScreenState extends State<UniformScreen> {
  bool vehiclevisible = false;
  var connectivityResult = new Connectivity().checkConnectivity();

  var user_id, user_pass, consignee_name, code;

  TextEditingController inputoneController = new TextEditingController();
  TextEditingController inputtwoController = new TextEditingController();
  TextEditingController inputthreeController = new TextEditingController();
  TextEditingController inputfourController = new TextEditingController();
  TextEditingController smallcontroller = new TextEditingController();
  TextEditingController mcontroller = new TextEditingController();
  TextEditingController lcontroller = new TextEditingController();
  TextEditingController xlcontroller = new TextEditingController();

  List data = [];
  List data2 = [];

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

  Future<String> getSWData2() async {
    var res = await http.get(
        Uri.parse("http://151.106.17.246:8080/byco/api/uni_type.php"),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data2 = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  void shprefer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      user_id = sharedPreferences.get("id");
      user_pass = sharedPreferences.get("pass");
      code = sharedPreferences.get("code");
    });
  }

  // FirebaseAuth _auth = FirebaseAuth.instance;
  var uid;

  bool showSpinner = false;
  final postref = FirebaseDatabase.instance.reference().child('posts');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;

  File? _image;
  File? _image1;
  UploadTask? task;
  late String basename;

  int _counter = 0;

  // File _image;
  late String _uploadedFileURL;
  String isLoading = "false";

  String checkloadbtn = "Confirm";

  String isLoadingCircle = "false";

  bool checkloader() {
    if (isLoadingCircle == "true") {
      return true;
    } else {
      return false;
    }
  }

  bool post_clicked = false;
  Future<void> request() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(
        'http://151.106.17.246:8080/byco/api/uniorder.php?qty1=${smallcontroller.text.toString()}&qty2=${mcontroller.text.toString()}&qty3=${lcontroller.text.toString()}&qty4=${xlcontroller.text.toString()}&userid=${sharedPreferences.get("id").toString()}&type_id=${_mySelection3}');
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://151.106.17.246:8080/byco/api/uniorder.php?qty1=${smallcontroller.text.toString()}&qty2=${mcontroller.text.toString()}&qty3=${lcontroller.text.toString()}&qty4=${xlcontroller.text.toString()}&userid=${sharedPreferences.get("id").toString()}&type_id=${_mySelection3}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Order Placed Successfully");
    } else {
      Fluttertoast.showToast(msg: response.statusCode.toString());
    }
  }

  void getimg() {
    _image = File(
        "https://www.thenews.com.pk//assets/uploads/akhbar/2018-10-27/385902_1979596_akhbar.jpg");
  }

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
      } else {
        print("no image selected");
      }
    });
  }

  // void localimage(){
  //   _image = File("https://www.thenews.com.pk//assets/uploads/akhbar/2018-10-27/385902_1979596_akhbar.jpg");
  // }

  // void shprefer() async{
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //
  //   setState(() {
  //     uid = sharedPreferences.get("id");
  //   });
  // }

  @override
  void initState() {
    shprefer();
    //checkLogin();
    this.getSWData();
    this.getSWData2();
    smallcontroller.text = "0";
    mcontroller.text = "0";
    lcontroller.text = "0";
    xlcontroller.text = "0";
    print(consignee_name.toString());
    checkloader();
    if (checkloadbtn == "upload") {
      checkloadbtn = "Uploading";
    } else {
      checkloadbtn = "Confirm";
    }
    // getimg();
    forimei();
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
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

  TextEditingController ptypeController = new TextEditingController();
  TextEditingController deliverybasedController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController depotController = new TextEditingController();
  TextEditingController bankController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();
  TextEditingController uidController = new TextEditingController();
  TextEditingController transactionController = new TextEditingController();
  TextEditingController vehicleController = new TextEditingController();
  TextEditingController quantController = new TextEditingController();

  signout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('code');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
  }

  int _selectedIndex = 2;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    // Text(
    //   'Index 0: Home',
    //   style: optionStyle,
    // ),
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

      if (index == 2) {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //       builder: (context) => TripsScreen()
        //   ),
        // );
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const BycoUserScreens(),
          ),
        );
      } else if (index == 0) {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //       builder: (context) => OrderScreen()
        //   ),
        // );
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const OrderScreen(),
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
            builder: (BuildContext context) => const HistoryScreen(),
          ),
        );
      }
      // else if(index == 2){
      //   // Navigator.of(context).push(
      //   //   MaterialPageRoute(
      //   //       builder: (context) => HistoryScreen()
      //   //   ),
      //   // );
      //   Navigator.pushReplacement<void, void>(
      //     context,
      //     MaterialPageRoute<void>(
      //       builder: (BuildContext context) => const AddUsers(),
      //     ),
      //   );
      // }
    });
  }

  int _value = 1;

  String dropdownValue = "Normal Uniform";
  String dropdownValue1 = "Small";
  String dropdownValue2 = "Refinery";
  String dropdownValue3 = "NA";

  String? _mySelection;
  String? _mySelection2;
  String? _mySelection3;

  // final String url = "http://webmyls.com/php/getdata.php";

  // ignore: deprecated_member_use
  /* List data = []; //edited line

  Future<String> getSWData() async {
    var res = await http.get(Uri.parse(
        "http://151.106.17.246:8080/byco/api/userdepot.php?accesskey=12345&cus_id=" +
            code.toString()));
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    // print(data[0]["id"]);
    print("Sapcode " + code.toString());

    return Future.value("Data download successfully");
  }*/

  // String drop(){
  //   if(dropdownValue == ""){
  //     return dropdownValue.toString();
  //   }
  // }

  // bool isLoad = false;
  // bool circlevisible(){
  //   if(isLoad == true){
  //     return true;
  //   }
  //   else{
  //     return false;
  //   }
  // }

  bool vehivisible() {
    if (dropdownValue1 == "Self") {
      return true;
    } else {
      return false;
    }
  }

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  List<Widget> textwidget = [];
  late AndroidDeviceInfo androidInfo;

  void forimei() async {
    androidInfo = await deviceInfoPlugin.androidInfo;
    setState(() {
      textwidget.add(Text('IMEI Number is: ${androidInfo.androidId}'));
      // textwidget.add(Text('android id: ${androidInfo.id}'));
    });
  }

  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                "Uniform",
                style: TextStyle(color: Constants.primaryorrange),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //       builder: (context) => LoginScreen()
                //   ),
                // );
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Uniform Details",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Constants.primaryorrange),
                              )),

                          SizedBox(
                            height: 10,
                          ),

                          // ...textwidget,

                          SizedBox(
                            height: 20,
                          ),

                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Select Uniform Type",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          Container(
                            width: double.infinity,
                            child: new DropdownButton(
                              items: data2.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item['type']),
                                  value: item['id'].toString(),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                setState(() {
                                  _mySelection3 = newVal as String?;
                                });
                              },
                              value: _mySelection3,
                            ),
                          ),

                          SizedBox(
                            height: 30,
                          ),

                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Provide Uniform Quantity",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          Container(
                            width: double.infinity,
                            child: TextField(
                              controller: smallcontroller,
                              keyboardType: TextInputType.numberWithOptions(),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text('Quantity For Small')),
                            ),

                            /*new DropdownButton(
                              items: data.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item['size']),
                                  value: item['id'].toString(),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                setState(() {
                                  _mySelection2 = newVal as String?;
                                });
                              },
                              value: _mySelection2,
                            ),*/
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          Container(
                            width: double.infinity,
                            child: TextField(
                              controller: mcontroller,
                              keyboardType: TextInputType.numberWithOptions(),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text('Quantity For Medium')),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: double.infinity,
                            child: TextField(
                              controller: lcontroller,
                              keyboardType: TextInputType.numberWithOptions(),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text('Quantity For Large')),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: double.infinity,
                            child: TextField(
                              controller: xlcontroller,
                              keyboardType: TextInputType.numberWithOptions(),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text('Quantity For Extra Large')),
                            ),
                          ),
                          /*SizedBox(
                            height: 35,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Select Uniform Quantity",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),*/

                          /*SizedBox(
                            height: 5,
                          ),

                          Container(
                            width: double.infinity,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: quantController,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Uniform Quantity',
                                  hintText: 'Uniform Quantity',
                                  labelStyle: TextStyle(
                                      fontSize: 18, letterSpacing: 1)),
                            ),
                          ),*/
                          SizedBox(
                            height: 50,
                          ),
                          Visibility(
                            visible: vehivisible(),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Select Uniform Quantity",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: TextField(
                                    controller: vehicleController,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'VehicleNumber',
                                        hintText: 'Vehicle Number',
                                        labelStyle: TextStyle(
                                            fontSize: 18, letterSpacing: 1)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Bank Information",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Constants.primaryorrange),
                              )),

                          SizedBox(
                            height: 30,
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
                              value: dropdownValue3,
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
                                  dropdownValue3 = newValue!;
                                });
                              },
                              // value: dropdownValue3.toString(),
                              items: <String>[
                                'NA',
                                'HBL Bank Ltd.',
                                'Bank AL Habib',
                                'MCB',
                                'Silk Bank',
                                'Askari Bank',
                                'Bank Alfalah Limited',
                                'National Bank',
                                'Meezan Bank',
                                'Faysal Bank (Islamic)',
                                'Other'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          // Container(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text("Enter Transaction Id", style: TextStyle(fontSize: 18),),
                          // ),
                          //
                          // SizedBox(
                          //   height: 5,
                          // ),
                          //
                          // Center(
                          //   child: TextField (
                          //     keyboardType: TextInputType.number,
                          //     controller: transactionController,
                          //     decoration: InputDecoration(
                          //         border: UnderlineInputBorder(),
                          //         labelText: 'Transaction Id',
                          //         hintText: 'Enter Transaction Id',
                          //         labelStyle: TextStyle(fontSize: 18, letterSpacing: 1)
                          //     ),
                          //   ),
                          // ),
                          //
                          // SizedBox(
                          //   height: 30,
                          // ),

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
                              controller: amountController,
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
                              dialog(context);
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
                                    child: _image != null
                                        ? ClipRect(
                                            child: Image.file(
                                              _image!.absolute,
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
                              request();
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
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: 'Trips',
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_border,
              color: Colors.black45,
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color: Colors.black45,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.accessibility_new_outlined,
              color: Colors.orange,
            ),
            label: 'UniForm',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void blank() {}

  uploaddata(
      String quantity,
      String ptype,
      String dbased,
      String depot,
      String bank,
      String amount,
      String transaction,
      String vehicle,
      String image,
      String uuuid,
      String imei) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    checkloadbtn = "upload";
    var jsonResponce = null;
    print(quantity);
    // var responce = await http.post(Uri.parse("https://gariwala.pk/appapi/api/cus_reg.php?accesskey=12345&fname="+fName+"&address="+address+"&lname="+lName+"&number="+num+"&email="+email+"&user="+user+"&pass="+pass+"&state="+state+"&city="+city,)

    if (dropdownValue1.toString() == "Self") {
      isLoadingCircle = "true";
      checkloadbtn = "upload";
      print(image.toString());
      var responce = await http.post(Uri.parse(
          "http://151.106.17.246:8080/byco/api/byco_upload.php?delivery_based=" +
              dbased +
              "&quantity=" +
              quantity +
              "&depot=" +
              depot +
              "&uid=" +
              uuuid +
              "&bank=" +
              bank +
              "&product=" +
              ptype +
              "&amount=" +
              amount +
              "&traid=" +
              transaction +
              "&vehi=" +
              vehicle +
              "&image=" +
              image +
              "&imei=" +
              imei));

      print(
          "http://151.106.17.246:8080/byco/api/byco_upload.php?delivery_based=" +
              dbased +
              "&quantity=" +
              quantity +
              "&depot=" +
              depot +
              "&uid=" +
              uuuid +
              "&bank=" +
              bank +
              "&product=" +
              ptype +
              "&amount=" +
              amount +
              "&traid=" +
              transaction +
              "&vehi=" +
              vehicle +
              "&image=" +
              image +
              "&imei=" +
              imei);

      jsonResponce = json.encode(responce.body);
      print("Jawad" + jsonResponce.toString());

      // if(jsonResponce.toString() == "{data: }"){
      if (jsonResponce.toString() == null) {
        print("if data is null :: " + jsonResponce.toString());
        setState(() {
          Fluttertoast.showToast(
              msg: "Order not Generated",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        });
      } else {
        try {
          isLoadingCircle = "true";
          checkloadbtn = "upload";
          setState(() {
            print("If data is not null :: " + jsonResponce.toString());

            var id = jsonResponce["data"][0]["user"]["id"];

            sharedPreferences.setString("orderid", id);
          });
          isLoadingCircle = "true";
          checkloadbtn = "upload";
          checkloadbtn = "upload";
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => OrderScreen()));

          toastMessage("Order Generated Successsfully");

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => OrderScreen()),
              (Route<dynamic> route) => false);
        } catch (e) {
          print(e.toString() + "erroorrrrr");
        }
      }
      // toastMessage("Order Generated Successfully");
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => OrderScreen()));
    } else {
      print(image.toString());
      isLoadingCircle = "true";
      checkloadbtn = "upload";
      var responce = await http.post(Uri.parse(
          "http://151.106.17.246:8080/byco/api/byco_upload.php?delivery_based=" +
              dbased +
              "&quantity=" +
              quantity +
              "&depot=" +
              depot +
              "&uid=" +
              uuuid +
              "&bank=" +
              bank +
              "&product=" +
              ptype +
              "&amount=" +
              amount +
              "&traid=" +
              transaction +
              "&vehi=NA" +
              "&image=" +
              image +
              "&imei=" +
              imei));
      jsonResponce = json.encode(responce.body);
      print("Jawad" + jsonResponce.toString());

      try {
        if (jsonResponce.toString() == null) {
          print("if data is null :: " + jsonResponce.toString());
          setState(() {
            Fluttertoast.showToast(
                msg: "Order not Genrated",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        } else {
          isLoadingCircle = "true";
          setState(() {
            isLoadingCircle = "true";
            checkloadbtn = "upload";
            checkloadbtn = "upload";
            isLoadingCircle = "true";
            print("If data is not null :: " + jsonResponce.toString());
            // Fluttertoast.showToast(
            //     msg: "Data upload Successfully",
            //     toastLength: Toast.LENGTH_LONG,
            //     gravity: ToastGravity.BOTTOM,
            //     timeInSecForIosWeb: 1,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     fontSize: 16.0);

            // var id = jsonResponce["data"][0]["user"]["id"];
            // var d_based = jsonResponce["data"][0]["user"]["delivery_based"];
            // var quantity = jsonResponce["data"][0]["user"]["quantity"];
            // var depot = jsonResponce["data"][0]["user"]["depot"];
            // var _date = jsonResponce["data"][0]["user"]["date"];
            // var c_id = jsonResponce["data"][0]["user"]["cus_id"];
            // var bank_info = jsonResponce["data"][0]["user"]["bank_info"];
            // var p_type = jsonResponce["data"][0]["user"]["product_type"];
            // var amount = jsonResponce["data"][0]["user"]["amount"];
            // var transaction_id = jsonResponce["data"][0]["user"]["trasection_id"];
            // var vehicle = jsonResponce["data"][0]["user"]["vehicle"];
            // var imei = jsonResponce["data"][0]["user"]["imei"];

            // var id = jsonResponce["id"];
            // var d_based = jsonResponce["delivery_based"];
            // var quantity = jsonResponce["quantity"];
            // var depot = jsonResponce["depot"];
            // var _date = jsonResponce["date"];
            // var c_id = jsonResponce["cus_id"];
            // var bank_info = jsonResponce["bank_info"];
            // var p_type = jsonResponce["product_type"];
            // var amount = jsonResponce["amount"];
            // var transaction_id = jsonResponce["trasection_id"];
            // var vehicle = jsonResponce["vehicle"];
            // var imei = jsonResponce["imei"];
            // var _imagef = jsonResponce["image"];

            // print(Name);
            // print(city);
            // print(u_id);

            // sharedPreferences.setString("id", id);
            // sharedPreferences.setString("delivery_based", d_based);
            // sharedPreferences.setString("quantity", quantity);
            // sharedPreferences.setString("depot", depot);
            // sharedPreferences.setString("date", _date);
            // sharedPreferences.setString("cus_id", c_id);
            // sharedPreferences.setString("bank_info", bank_info);
            // sharedPreferences.setString("product_type", p_type);
            // sharedPreferences.setString("amount", amount);
            // sharedPreferences.setString("trasection_id", transaction_id);
            // sharedPreferences.setString("vehicle", vehicle);
            // sharedPreferences.setString("imei", imei);
            // sharedPreferences.setString("image", _imagef);

            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => OrderScreen()));
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Login()),
            // );

            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => OrderScreen()));
            toastMessage("Order Genrated Successsfully");

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => OrderScreen()),
                (Route<dynamic> route) => false);
          });
        }
      } catch (e) {
        print(e.toString() + "errorororo");
        toastMessage("Order not Genrated");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => OrderScreen()),
            (Route<dynamic> route) => false);
      }
    }
  }

  void blank2() {}

  void uploadimage() async {
    try {
      int date = DateTime.now().microsecondsSinceEpoch;
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('/bycoapp$date');
      UploadTask uploadtask = ref.putFile(_image!.absolute);
      await Future.value(uploadtask);
      var newUrl = await ref.getDownloadURL();

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
      toastMessage(e.toString());
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

  void cleartext() {
    vehicleController.text = "";
    transactionController.text = "";
    amountController.text = "";
    quantityController.text = "";
  }

  Widget vehicle() {
    return Visibility(
      visible: false,
      child: Container(
        child: Column(
          children: [
            Center(
              child: TextField(
                controller: vehicleController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'VehicleNumber',
                    hintText: 'Vehicle Number',
                    labelStyle: TextStyle(fontSize: 15, letterSpacing: 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void dialog2(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 200,
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    child: Text(
                      "Enter Pin Code",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void dialog1(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: Color.fromRGBO(11, 108, 25, 1.0),
            content: Container(
              height: 160,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      child: Text(
                        "Are you sure you want to place an order " +
                            dropdownValue.toString() +
                            " of quantity " +
                            quantityController.text +
                            " Liters?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),

                    SizedBox(height: 10),

                    SizedBox(
                      height: 5,
                    ),

                    // isLoading == true ? CircularProgressIndicator(strokeWidth: 4,) : Container(),
                    Visibility(
                      visible: checkloader(),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                                // color: Colors.black,
                                color: Constants.gray,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Center(
                              child: Column(
                                children: const [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Yes",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        OrderScreen()),
                                (Route<dynamic> route) => false);
                            // dialog3(context);
                            // toastMessage("Loading Please Wait");
                          },
                          child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                                // color: Colors.black,
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Center(
                              child: Column(
                                children: const [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "No",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void dialog3(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: Color.fromRGBO(11, 108, 25, 1.0),
            content: Container(
              height: 170,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      child: Text(
                        "Are you sure you want to place an order of quantity " +
                            quantityController.text +
                            "?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),

                    SizedBox(height: 10),

                    SizedBox(
                      height: 5,
                    ),

                    // isLoading == true ? CircularProgressIndicator(strokeWidth: 4,) : Container(),
                    Visibility(
                      visible: checkloader(),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                            dialog3(context);
                            toastMessage("Loading Please Wait");

                            setState(() {
                              isLoadingCircle = "true";
                              checkloadbtn = "upload";
                            });

                            isLoadingCircle = "true";
                            checkloadbtn = "upload";

                            DeviceInfoPlugin deviceInfoPlugin =
                                DeviceInfoPlugin();
                            AndroidDeviceInfo andinfo =
                                await deviceInfoPlugin.androidInfo;
                            int date = DateTime.now().microsecondsSinceEpoch;
                            firebase_storage1.Reference ref = firebase_storage1
                                .FirebaseStorage.instance
                                .ref('/bycoappss$date');
                            UploadTask uploadtask;
                            String ch = "null";
                            //print(_image!.path);
                            if (_image != null) {
                              uploadtask = ref.putFile(_image!.absolute);
                              await Future.value(uploadtask);
                              String newUrl = await ref.getDownloadURL();
                              print(newUrl);
                              setState(() {
                                checkloader();
                                if (checkloadbtn == "upload") {
                                  checkloadbtn = "Uploading";
                                } else {
                                  checkloadbtn = "Confirm";
                                }
                              });
                              try {
                                isLoadingCircle = "true";
                                checkloadbtn = "upload";

                                uploaddata(
                                    quantityController.text,
                                    dropdownValue,
                                    dropdownValue1,
                                    _mySelection.toString(),
                                    dropdownValue3,
                                    amountController.text,
                                    transactionController.text,
                                    vehicleController.text,
                                    newUrl.toString(),
                                    user_id.toString(),
                                    androidInfo.androidId);
                                // toastMessage("Order Generated Successfully");
                                print("url 3 of image");
                                // print(newUrl);
                                //  Navigator.pop(context);
                              } catch (e) {
                                print("Error in upload");
                                print(e.toString());
                              }
                              isLoadingCircle = "true";
                              checkloadbtn = "upload";
                              // Navigator.of(context).pushAndRemoveUntil(
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) => OrderScreen()),
                              //         (Route<dynamic>route) => false);

                            } else {
                              setState(() {
                                checkloader();
                              });
                              try {
                                print(checkloadbtn);
                                isLoadingCircle = "true";
                                checkloadbtn = "upload";

                                uploaddata(
                                    quantityController.text,
                                    dropdownValue,
                                    dropdownValue1,
                                    _mySelection.toString(),
                                    dropdownValue3,
                                    amountController.text,
                                    transactionController.text,
                                    vehicleController.text,
                                    "https://www.thenews.com.pk//assets/uploads/akhbar/2018-10-27/385902_1979596_akhbar.jpg",
                                    user_id.toString(),
                                    androidInfo.androidId);
                                // toastMessage("Order Generated Successfully");
                                print("url 3 of image");
                                //print(newUrl);
                                // Navigator.pop(context);
                              } catch (e) {
                                isLoadingCircle = "true";
                                checkloadbtn = "upload";
                                print("Error in upload");
                                print(e.toString());
                              }
                            }

                            isLoadingCircle = "true";
                            checkloadbtn = "upload";

                            // if(user_pass == inputoneController.text){
                            //   DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
                            //   AndroidDeviceInfo andinfo = await deviceInfoPlugin.androidInfo;
                            //   int date = DateTime.now().microsecondsSinceEpoch;
                            //   firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/bycoapp$date');
                            //   UploadTask uploadtask;
                            //   String ch = "null";
                            //   //print(_image!.path);
                            //   if(_image != null){
                            //     uploadtask = ref.putFile(_image!.absolute);
                            //     await Future.value(uploadtask);
                            //     String newUrl = await ref.getDownloadURL();
                            //     print(newUrl);
                            //     setState(() {
                            //       checkloader();
                            //       if(checkloadbtn == "upload"){
                            //         checkloadbtn = "Uploading";
                            //       }
                            //       else{
                            //         checkloadbtn = "Confirm";
                            //       }
                            //     });
                            //     try{
                            //       isLoadingCircle = "true";
                            //       checkloadbtn = "upload";
                            //
                            //       uploaddata(quantityController.text, dropdownValue, dropdownValue1, dropdownValue2, dropdownValue3, amountController.text, transactionController.text, vehicleController.text, newUrl.toString(), user_id.toString(), androidInfo.androidId);
                            //       // toastMessage("Order Generated Successfully");
                            //       print("url 3 of image");
                            //      // print(newUrl);
                            //      //  Navigator.pop(context);
                            //     }
                            //     catch(e){
                            //       print("Error in upload");
                            //       print(e.toString());
                            //     }
                            //     isLoadingCircle = "true";
                            //     checkloadbtn = "upload";
                            //     // Navigator.of(context).pushAndRemoveUntil(
                            //     //     MaterialPageRoute(
                            //     //         builder: (BuildContext context) => OrderScreen()),
                            //     //         (Route<dynamic>route) => false);
                            //
                            //   }
                            //   else{
                            //     setState(() {
                            //       checkloader();
                            //
                            //     });
                            //     try{
                            //       print(checkloadbtn);
                            //       isLoadingCircle = "true";
                            //       checkloadbtn = "upload";
                            //
                            //       uploaddata(quantityController.text, dropdownValue, dropdownValue1, dropdownValue2, dropdownValue3, amountController.text, transactionController.text, vehicleController.text, "https://www.thenews.com.pk//assets/uploads/akhbar/2018-10-27/385902_1979596_akhbar.jpg", user_id.toString(), androidInfo.androidId);
                            //       // toastMessage("Order Generated Successfully");
                            //       print("url 3 of image");
                            //       //print(newUrl);
                            //       // Navigator.pop(context);
                            //     }
                            //     catch(e){
                            //       isLoadingCircle = "true";
                            //       checkloadbtn = "upload";
                            //       print("Error in upload");
                            //       print(e.toString());
                            //     }
                            //   }
                            //
                            //   isLoadingCircle = "true";
                            //   checkloadbtn = "upload";
                            //
                            //
                            //   // Navigator.of(context).pushAndRemoveUntil(
                            //   //     MaterialPageRoute(
                            //   //         builder: (BuildContext context) => OrderScreen()),
                            //   //         (Route<dynamic>route) => false);
                            //
                            //
                            // }
                            // else{
                            //   toastMessage("Please Check your Pin Code...");
                            //   Navigator.of(context).pushAndRemoveUntil(
                            //       MaterialPageRoute(
                            //           builder: (BuildContext context) => OrderScreen()),
                            //           (Route<dynamic>route) => false);
                            // }
                          },
                          child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                                // color: Colors.black,
                                color: Constants.gray,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Text(
                                  //   checkloadbtn,
                                  //   style: TextStyle(
                                  //       fontSize: 20,
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Colors.white),
                                  // ),
                                  // if(checkloadbtn == "upload")...{
                                  //   Text(
                                  //     "uploading",
                                  //     style: TextStyle(
                                  //         fontSize: 20,
                                  //         fontWeight: FontWeight.bold,
                                  //         color: Colors.white),
                                  //   ),
                                  // }
                                  // else...{
                                  //   Text(
                                  //     "Yes",
                                  //     style: TextStyle(
                                  //         fontSize: 20,
                                  //         fontWeight: FontWeight.bold,
                                  //         color: Colors.white),
                                  //   )
                                  // }
                                  Text(
                                    "Yes",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            // Navigator.pop(context);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        OrderScreen()),
                                (Route<dynamic> route) => false);
                            // dialog3(context);
                            // toastMessage("Loading Please Wait");
                          },
                          child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                                // color: Colors.black,
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "No",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
