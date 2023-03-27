import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cnergyico/HistoryPage.dart';
import 'package:cnergyico/LoginPage.dart';
import 'package:cnergyico/OrderPage.dart';
import 'package:cnergyico/Uniform.dart';
import 'package:cnergyico/addusers.dart';
import 'package:cnergyico/utils/constants.dart';
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
  // ignore: deprecated_member_use

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

  int _selectedIndex = 2;
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
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                "Uniform List",
                style: TextStyle(
                  color: Constants.primaryorrange,
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement<void, void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const UniformScreen(),
                        ),
                      );
                    },
                    child: Container(
                        child: Icon(
                      Icons.add,
                      color: Constants.primaryorrange,
                    ))),
                // GestureDetector(onTap: (){ upload(username.text, password.text, cnic.text, phone.text); }, child: Container(margin: EdgeInsets.only(left: 20), child: Icon(Icons.delete, color: Constants.primaryColor,)))
              ],
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
            icon: Icon(Icons.bookmark_border),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new_outlined,color: Colors.amber,),
            label: 'UniForm',
          ),
        ],
        currentIndex: _selectedIndex,
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
                              child: Text("Unifrom Orders",
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
                              /*Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Quantity: ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text('${_loadedPhotos[index]["quantity"]}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),*/

                              /* Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('CNIC: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text('${_loadedPhotos[index]["type_id"]}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),*/

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text('Bank Info: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              //     Text('${_loadedPhotos[index]["bank_info"]}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              //   ],
                              // ),

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text('Product Type: '),
                              //     Text('${_loadedPhotos[index]["product_type"]}'),
                              //   ],
                              // ),

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text('Amount: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              //     Text('${_loadedPhotos[index]["amount"]}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              //   ],
                              // ),
                              //
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text('Transaction Id: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              //     Text('${_loadedPhotos[index]["trasection_id"]}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              //   ],
                              // ),
                              //
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text('Vehicle Number: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              //     Text('${_loadedPhotos[index]["vehicle"]}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              //   ],
                              // ),

                              SizedBox(
                                height: 20,
                              ),
                              /*GestureDetector(
                          onTap: (){
                            deleteusers(_loadedPhotos[index]["id"]);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) => BycoUserScreens()),
                                    (Route<dynamic>route) => false);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Center(
                              child: Icon(Icons.delete, color: Colors.white,),
                            ),
                          ),
                        ),*/
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
