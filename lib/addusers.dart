import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cnergyico/HistoryPage.dart';
import 'package:cnergyico/LoginPage.dart';
import 'package:cnergyico/OrderPage.dart';
import 'package:cnergyico/bycouserlist.dart';
import 'package:cnergyico/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:pk_cnic_input_field/pk_cnic_input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddUsers extends StatefulWidget {
  const AddUsers({Key? key}) : super(key: key);

  @override
  _AddUsersState createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {

  var user_id, user_name, user_pass;
  var uid, uname, upass, ucnic, uphone;

  TextEditingController inputoneController = new TextEditingController();
  TextEditingController inputtwoController = new TextEditingController();
  TextEditingController inputthreeController = new TextEditingController();
  TextEditingController inputfourController = new TextEditingController();


  void shprefer() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.get("id");
      user_name = sharedPreferences.get("consignee_name");
      user_pass = sharedPreferences.get("pass");
    });
  }

  void shprefer1() async{
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
    shprefer();
    //getSWData();
    shprefer1();
    //checkfields();
    //checkLogin();
  }

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController cnic = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  signout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('code');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
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

      if(index == 2){
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const BycoUserScreens(),
          ),
        );
      }
      else if(index == 0){
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const OrderScreen(),
          ),
        );
      }
      else if(index == 1){
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const HistoryScreen(),
          ),
        );
      }
    });
  }

  var size,height,width;

  // String listuname = 'username';
  //
  // var _mySelection;
  //
  // final String url = "http://151.106.17.246:8080/byco/api/userbyco_list.php?id=2";
  //
  // List data = [];
  //
  // var resBody = null;
  //
  // Future<String> getSWData() async {
  //   // var res = await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
  //   var res = await http.get(Uri.parse(url));
  //   print(res.body);
  //   resBody = json.decode(res.body);
  //   print(resBody.toString());
  //   // jsonResponce = json.decode(responce.body);
  //   setState(() {
  //     data = resBody;
  //   });
  //   print(resBody);
  //   return "Success";
  // }
  //
  // void checkfields(){
  //   if(listuname == uname){
  //     username.text = uname;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Container(
              child: Text("Add Users", style: TextStyle(color: Constants.primaryorrange),),
            ),

            Row(
              children: [
                GestureDetector(onTap: (){Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const BycoUserScreens(),
                  ),
                );}, child: Container(child: Icon(Icons.list_alt_outlined, color: Constants.primaryorrange,))),
                // GestureDetector(onTap: (){ upload(username.text, password.text, cnic.text, phone.text); }, child: Container(margin: EdgeInsets.only(left: 20), child: Icon(Icons.delete, color: Constants.primaryColor,)))
              ],
            ),

            GestureDetector(
              onTap: (){
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
                    child: Column(
                      children: [

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     FlatButton(onPressed: (){}, child: Row(
                        //       children: [
                        //         Text("Add"),
                        //         Icon(Icons.add),
                        //       ],
                        //     ), color: Colors.green,),
                        //     FlatButton(onPressed: (){}, child: Row(
                        //       children: [
                        //         Text("Delete"),
                        //         Icon(Icons.delete),
                        //       ],
                        //     ), color: Colors.red,),
                        //   ],
                        // ),
                        //
                        //
                        // Container(
                        //   width: double.infinity,
                        //   height: 70,
                        //   // color: Colors.blueGrey,
                        //
                        //   child: Center(
                        //     child: Row(
                        //       children: [
                        //         Container(
                        //           alignment: Alignment.center,
                        //           width: 150,
                        //           height: 70,
                        //           color: Colors.green,
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //             children: [
                        //               Text("Create User"),
                        //               Icon(Icons.add),
                        //             ],
                        //           ),
                        //         ),
                        //
                        //         Container(
                        //           width: 150,
                        //           height: 70,
                        //           color: Colors.red,
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //             children: [
                        //               Text("Delete User"),
                        //               Icon(Icons.delete),
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        //
                        // ),
                        //
                        // SizedBox(
                        //   height: 10,
                        // ),

                        Container(alignment: Alignment.centerLeft, child: Text("User Information", style: TextStyle(fontSize: 25, color: Constants.primaryorrange),)),

                        SizedBox(
                          height: 10,
                        ),

                        // ...textwidget,


                        // Center(
                        //   child: DropdownButton(
                        //     elevation: 16,
                        //     items: data.map((item) {
                        //       return new DropdownMenuItem(
                        //         child: new Text(item[listuname]),
                        //         value: item['id'].toString(),
                        //       );
                        //     }).toList(),
                        //     onChanged: (newVal) {
                        //       setState(() {
                        //         _mySelection = newVal.toString();
                        //       });
                        //     },
                        //     value: _mySelection,
                        //   ),
                        // ),

                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("User Name", style: TextStyle(fontSize: 18),),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Center(
                          child: TextField (
                            controller: username,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Enter Username',
                                hintText: 'Enter Username',
                                labelStyle: TextStyle(fontSize: 18, letterSpacing: 1)
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Phone ", style: TextStyle(fontSize: 18),),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Center(
                          child: TextField (
                            maxLength: 11,
                            controller: phone,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Enter Number',
                                hintText: 'Enter Number',
                                labelStyle: TextStyle(fontSize: 18, letterSpacing: 1),
                              counterText: "",
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("CNIC Number ", style: TextStyle(fontSize: 18),),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Center(
                          child: TextField (
                            maxLength: 13,
                            controller: cnic,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Enter CNIC',
                                hintText: 'Enter CNIC',
                                labelStyle: TextStyle(fontSize: 18, letterSpacing: 1),
                              counterText: "",
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Password ", style: TextStyle(fontSize: 18),),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Center(
                          child: TextField (
                            obscureText: true,
                            // keyboardType: TextInputType.number,
                            controller: password,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Enter Password',
                                hintText: 'Enter Password',
                                labelStyle: TextStyle(fontSize: 18, letterSpacing: 1)
                            ),
                          ),
                        ),


                        SizedBox(
                          height: 30,
                        ),



                        GestureDetector(
                          onTap: () {
                            // if (username.text != Null && password.text != Null && phone.text != Null && cnic.text != Null){
                            //   upload(username.text, password.text, cnic.text, phone.text, user_id.toString());
                            //   toastMessage("User Generated Successfully");
                            //   Navigator.pushReplacement<void, void>(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //   builder: (BuildContext context) => const AddUsers(),
                            //   ),
                            //  );
                            // }
                            // else{
                            //   toastMessage("Fill Check Your All Fields..!");
                            // }
                            if (username.text != "" && password.text != "" && phone.text != "" && cnic.text != ""){
                              dialog(context);
                            }
                            else{
                              toastMessage("Please Check all your Fields");
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 50,
                            child: Text("Add User", textAlign: TextAlign.center, style: TextStyle(color: Constants.primaryorrange, fontSize: 20, letterSpacing: 5),),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Constants.primarygreen,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
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
            icon: Icon(Icons.bookmark_border),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Users',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  upload(String uname, String upass, String ucnic, String uphone, String mainuser) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Map data = {'name': email, 'pass': pass};
    var jsonResponse = null;

    // var response = await http.post(Uri.parse("https://gariwala.pk/appapi/api/login.php?name=" +
    //     email +
    //     "&pass=" +
    //     pass +
    //     "&accesskey=12345",));

    // var response = await http.post(Uri.parse("http://151.106.17.246:8080/gotrack/api/orderlogin.php?name=" +
    //     email +
    //     "&pass=" +
    //     pass +
    //     "&accesskey=12345",));
    var response = await http.post(Uri.parse("http://151.106.17.246:8080/byco/api/unser_upload.php?username=" + uname + "&phone=" +uphone+
        "&pass=" +upass+ "&cnic=" +ucnic+ "&mainuser=" +mainuser + "&accesskey=12345",));

    jsonResponse = json.encode(response.body);

    print("http://151.106.17.246:8080/byco/api/unser_upload.php?username=" +uname+ "&phone=" +uphone+ "&pass=" +upass+ "&cnic=" +ucnic+ "&mainuser=" +mainuser+ "&accesskey=12345");

    print(response);

    if (jsonResponse == "") {
      setState(() {
        print("Jawad Ahmed");
        Fluttertoast.showToast(
            msg: "Incorrect Email or Password",
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
    }
    else{
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => AddUsers()),
                (Route<dynamic>route) => false);
        Fluttertoast.showToast(
            msg: "User Add Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
    }
    // else {
    //   setState(() {
    //     print(jsonResponse);
    //
    //
    //     // var u_username = jsonResponse["data"][0]["user"]["username"];
    //     // var u_uphone = jsonResponse["data"][0]["user"]["phone"];
    //     // var u_upassword = jsonResponse["data"][0]["user"]["pasword"];
    //     // var u_ucnic = jsonResponse["data"][0]["user"]["CNIC"];
    //     // var u_id = jsonResponse["data"][0]["user"]["id"];
    //     // // print(Name);
    //     // // print(city);
    //     // // print(u_id);
    //     //
    //     // // sharedPreferences.setString("email", emailCustomer);
    //     // sharedPreferences.setString("username", u_username);
    //     // sharedPreferences.setString("phone", u_uphone);
    //     // sharedPreferences.setString("pasword", u_upassword);
    //     // sharedPreferences.setString("CNIC", u_ucnic);
    //     // sharedPreferences.setString("id", u_id);
    //
    //     // var a = sharedPreferences.get("name");
    //
    //     // print(a.toString()+"Jawad Ahmed");
    //     // print(emailController.text);
    //
    //     if(username.text == "" && password.text == "" && cnic.text == "" && phone.text == ""){
    //       Fluttertoast.showToast(
    //           msg: "Email or password field is empty",
    //           toastLength: Toast.LENGTH_LONG,
    //           gravity: ToastGravity.BOTTOM,
    //           timeInSecForIosWeb: 1,
    //           backgroundColor: Colors.red,
    //           textColor: Colors.white,
    //           fontSize: 16.0);
    //     }
    //     else{
    //       Navigator.of(context).pushAndRemoveUntil(
    //           MaterialPageRoute(
    //               builder: (BuildContext context) => AddUsers()),
    //               (Route<dynamic>route) => false);
    //       Fluttertoast.showToast(
    //           msg: "User Add Successfully",
    //           toastLength: Toast.LENGTH_LONG,
    //           gravity: ToastGravity.BOTTOM,
    //           timeInSecForIosWeb: 1,
    //           backgroundColor: Colors.red,
    //           textColor: Colors.white,
    //           fontSize: 16.0);
    //     }
    //   });
    // }
  }

  update(String uname, String upass, String ucnic, String uphone, String mainuser) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Map data = {'name': email, 'pass': pass};
    var jsonResponse = null;

    // var response = await http.post(Uri.parse("https://gariwala.pk/appapi/api/login.php?name=" +
    //     email +
    //     "&pass=" +
    //     pass +
    //     "&accesskey=12345",));

    // var response = await http.post(Uri.parse("http://151.106.17.246:8080/gotrack/api/orderlogin.php?name=" +
    //     email +
    //     "&pass=" +
    //     pass +
    //     "&accesskey=12345",));
    var response = await http.post(Uri.parse("http://151.106.17.246:8080/byco/api/unser_upload.php?username=" + uname+ "&phone=" +uphone+
        "&pass=" +upass+ "&cnic=" +ucnic+ "&mainuser=" +mainuser + "&accesskey=12345",));

    jsonResponse = json.decode(response.body);
    // jsonResponse = json.decode("http://151.106.17.246:8080/byco/api/unser_upload.php?username=" + uname+ "&phone=" +uphone+
    //     "&pass=" +upass+ "&cnic=" +ucnic+ "&mainuser=" +mainuser + "&accesskey=12345");

    print(response);

    if (jsonResponse == null) {
      setState(() {
        print("Jawad Ahmed");
        Fluttertoast.showToast(
            msg: "User Not Generated",
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
    }
    else {
      setState(() {
        // _isLoading = false;
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
        //         (Route<dynamic> route) => false);
        // Toast.show("Welcome Back", context,
        //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        print(jsonResponse);


        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => AddUsers()),
                (Route<dynamic>route) => false);
        Fluttertoast.showToast(
            msg: "User Generated Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // var u_username = jsonResponse["data"][0]["user"]["username"];
        // var u_uphone = jsonResponse["data"][0]["user"]["phone"];
        // var u_upassword = jsonResponse["data"][0]["user"]["pasword"];
        // var u_ucnic = jsonResponse["data"][0]["user"]["CNIC"];
        // var u_id = jsonResponse["data"][0]["user"]["id"];
        // // print(Name);
        // // print(city);
        // // print(u_id);
        //
        // // sharedPreferences.setString("email", emailCustomer);
        // sharedPreferences.setString("username", u_username);
        // sharedPreferences.setString("phone", u_uphone);
        // sharedPreferences.setString("pasword", u_upassword);
        // sharedPreferences.setString("CNIC", u_ucnic);
        // sharedPreferences.setString("id", u_id);
        //
        // var a = sharedPreferences.get("name");

        // print(a.toString()+"Jawad Ahmed");
        // print(emailController.text);

        // if(username.text == "" && password.text == "" && cnic.text == "" && phone.text == ""){
        //   Fluttertoast.showToast(
        //       msg: "All Fields aremendatory to fill...",
        //       toastLength: Toast.LENGTH_LONG,
        //       gravity: ToastGravity.BOTTOM,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        // }
        // else{
        //   Navigator.of(context).pushAndRemoveUntil(
        //       MaterialPageRoute(
        //           builder: (BuildContext context) => AddUsers()),
        //           (Route<dynamic>route) => false);
        //   Fluttertoast.showToast(
        //       msg: "User Generated Successfully",
        //       toastLength: Toast.LENGTH_LONG,
        //       gravity: ToastGravity.BOTTOM,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        // }
      });
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

  void dialog(context) {
    showDialog(
        context: context, builder: (BuildContext context) {
      return AlertDialog(
        // backgroundColor: Color.fromRGBO(11, 108, 25, 1.0),
        content: Container(
          height: 250,
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height: 20,),


                Container(
                  child: Text("Enter Pin Code", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                ),

            SizedBox(height: 20),

                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 4,
                    obscureText: true,
                    obscuringCharacter: '*',
                    // obscuringWidget: FlutterLogo(
                    //   size: 24,
                    // ),
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 4) {
                        return "Fill Your Pincode";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      inactiveColor: Colors.black,
                      inactiveFillColor: Colors.white,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,
                    // errorAnimationController: errorController,
                    controller: inputoneController,
                    keyboardType: TextInputType.number,
                    boxShadows: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      print("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        // currentText = value;
                      });
                    },
                  ),
                ),

                SizedBox(height: 20,),

                GestureDetector(
                  onTap: (){
                    try{
                      if (user_pass == inputoneController.text){
                        upload(username.text, password.text, cnic.text, phone.text, user_id.toString());
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => AddUsers()),
                                (Route<dynamic>route) => false);
                        toastMessage("User Generated Successfully");
                        cleartext();
                        pincodeclear();
                      }
                      else{
                        toastMessage("Please Check your Pin Code Again..!");
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => AddUsers()),
                                (Route<dynamic>route) => false);
                      }
                    }catch(e){
                      print(e.toString());
                    }
                    // Navigator.of(context).pushAndRemoveUntil(
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => AddUsers()),
                    //         (Route<dynamic>route) => false);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      // color: Colors.black,
                        color: Constants.gray,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Center(
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    );
  }

  void pincodeclear(){
    inputoneController.text = "";
    inputtwoController.text = "";
    inputthreeController.text = "";
    inputfourController.text = "";
  }

  void cleartext(){
    username.text = "";
    phone.text = "";
    cnic.text = "";
    password.text = "";
  }
}
