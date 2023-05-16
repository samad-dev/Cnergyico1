import 'dart:convert';
// import 'package:flutter_app_byco/HistoryPage.dart';
// import 'package:flutter_app_byco/OrderPage.dart';
import 'package:cnergyico/DashboardPage.dart';
import 'package:cnergyico/OrderPage.dart';
import 'package:cnergyico/home.dart';
import 'package:cnergyico/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:flutter_app_byco/DashboardPage.dart';
// import 'package:flutter_app_byco/TripsPage.dart';
// import 'package:flutter_app_byco/utils/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  var  pass, address, city, user_id, name, id, code;

  void shprefer() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      // email = sharedPreferences.get("email");
      pass = sharedPreferences.get("pass");
      name = sharedPreferences.get("consignee_name");
      city = sharedPreferences.get("District");
      address = sharedPreferences.get("location");
      user_id = sharedPreferences.get("userid");
      id = sharedPreferences.get("id");
      code = sharedPreferences.get("code");
    });
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.get("code") != null){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen()),
              (Route<dynamic>route) => false);
    }
  }
  //
  // checkLog() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   if(prefs.get("name") != null){
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(
  //             builder: (BuildContext context) => OrderScreen()),
  //             (Route<dynamic>route) => false);
  //   }
  //   // else{
  //   //   Fluttertoast.showToast(
  //   //       msg: "Incorrect Pump-Name or Pincode",
  //   //       toastLength: Toast.LENGTH_LONG,
  //   //       gravity: ToastGravity.BOTTOM,
  //   //       timeInSecForIosWeb: 1,
  //   //       backgroundColor: Colors.red,
  //   //       textColor: Colors.white,
  //   //       fontSize: 16.0);
  //   // }
  // }

  @override
  void initState() {
    shprefer();
    checkLogin();
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Constants.primarygreen,

      body: SafeArea(
        bottom: false,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 0.0,
              top: -20.0,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  "assets/Images/washing_machine_illustration.png",
                ),
              ),
            ),


            SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 15.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen()
                                ),
                              );
                            },
                            child: Icon(
                              // FlutterIcons.keyboard_backspace_mdi,
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text("Log in to your account", style: TextStyle( fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Flexible(
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight:
                          MediaQuery.of(context).size.height - 180.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Lets make a generic input widget
                            // InputWidget(
                            //   topLabel: "Email",
                            //   hintText: "Enter your email address",
                            // ),
                            Container(
                              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              // padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Text("ID", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                                height: 70,
                                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: TextField(

                                  controller: emailController,
                                  // textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      hintText: 'Enter Your ID',
                                      // focusedBorder: InputBorder.none,
                                      // border: InputBorder.none,
                                      border: OutlineInputBorder(),
                                      hintStyle: TextStyle(
                                          color: Colors.black54
                                      )
                                  ),
                                  style: TextStyle(fontSize: 16,
                                      color: Colors.black),
                                )),
                            SizedBox(
                              height: 25.0,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              // padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Text("Pin Code", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),

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
                                  fieldWidth: 50,
                                  activeFillColor: Colors.white,
                                ),
                                cursorColor: Colors.black,
                                animationDuration: Duration(milliseconds: 300),
                                enableActiveFill: true,
                                // errorAnimationController: errorController,
                                controller: passController,
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



                            // Container(
                            //     alignment: Alignment.centerLeft,
                            //     height: 70,
                            //     margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            //     padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                            //     child: TextField(
                            //       obscureText: true,
                            //
                            //       controller: passController,
                            //       // textAlign: TextAlign.center,
                            //       decoration: InputDecoration(
                            //           hintText: 'Enter Your Password',
                            //           // focusedBorder: InputBorder.none,
                            //           border: OutlineInputBorder(),
                            //           hintStyle: TextStyle(
                            //               color: Colors.black54,
                            //           )
                            //       ),
                            //       style: TextStyle(fontSize: 16,
                            //           color: Colors.black),
                            //     )),



                            // InputWidget(
                            //   topLabel: "Password",
                            //   obscureText: true,
                            //   hintText: "Enter your password",
                            // ),
                            SizedBox(
                              height: 15.0,
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Fluttertoast.showToast(
                            //         msg: "Your pin-code is 1234",
                            //         toastLength: Toast.LENGTH_LONG,
                            //         gravity: ToastGravity.BOTTOM,
                            //         timeInSecForIosWeb: 1,
                            //         backgroundColor: Colors.red,
                            //         textColor: Colors.white,
                            //         fontSize: 16.0);
                            //   },
                            //   child: Text(
                            //     "Get New Pincode?",
                            //     textAlign: TextAlign.right,
                            //     style: TextStyle(
                            //       fontSize: 15,
                            //       color: Constants.primarygreen,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 20.0,
                            ),
                            GestureDetector(
                              onTap: (){
                                if(emailController.text == "" && passController.text == ""){
                                      Fluttertoast.showToast(
                                          msg: "fill ID and pincode fields...",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                }
                                else{
                                  signIn(emailController.text, passController.text);
                                }
                              //   if(emailController.text != "" && passController.text != ""){
                              //     signIn(emailController.text, passController.text);
                              //
                              //     checkLog();
                              //   }
                              //   else{
                              //     Fluttertoast.showToast(
                              //         msg: "Login Failed",
                              //         toastLength: Toast.LENGTH_LONG,
                              //         gravity: ToastGravity.BOTTOM,
                              //         timeInSecForIosWeb: 1,
                              //         backgroundColor: Colors.red,
                              //         textColor: Colors.white,
                              //         fontSize: 16.0);
                              //   }
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  // color: Colors.black,
                                    color: Constants.primarygreen,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Center(
                                    child: Text(
                                      'Login',
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // signIn(String email, String pass) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   Map data = {'name': email, 'pass': pass};
  //   var jsonResponse = null;
  //
  //   // var response = await http.post(Uri.parse("https://gariwala.pk/appapi/api/login.php?name=" +
  //   //     email +
  //   //     "&pass=" +
  //   //     pass +
  //   //     "&accesskey=12345",));
  //   var response = await http.post(Uri.parse("http://151.106.17.246:8080/byco/api/orderlogin.php?name=" +
  //       email +
  //       "&pass=" +
  //       pass +
  //       "&accesskey=12345",));
  //
  //   jsonResponse = json.decode(response.body);
  //
  //   print(response);
  //
  //   if (jsonResponse == null) {
  //     setState(() {
  //       print("Jawad Ahmed");
  //       Fluttertoast.showToast(
  //           msg: "Incorrect Email or Password",
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //       // _isLoading = false;
  //       // Toast.show("Something went wrong", context,
  //       //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //     });
  //   }
  //   else {
  //     setState(() {
  //       print(jsonResponse);
  //       var Name = jsonResponse["data"][0]["user"]["consignee_name"];
  //       var id = jsonResponse["data"][0]["user"]["id"];
  //       var city = jsonResponse["data"][0]["user"]["city"];
  //       var u_id = jsonResponse["data"][0]["user"]["id"];
  //       var address = jsonResponse["data"][0]["user"]["address"];
  //       print(Name);
  //       print(city);
  //       print(u_id);
  //
  //       // sharedPreferences.setString("email", emailCustomer);
  //       sharedPreferences.setString("pass", pass);
  //       sharedPreferences.setString("id", u_id);
  //       sharedPreferences.setString("name", Name);
  //       sharedPreferences.setString("location", address);
  //       sharedPreferences.setString("city", city);
  //       sharedPreferences.setString("id", id);
  //
  //       var a = sharedPreferences.get("name");
  //
  //       print(a.toString()+"Jawad Ahmed");
  //       print(emailController.text);
  //
  //
  //
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => OrderScreen()),
  //       );
  //
  //     });
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => OrderScreen()),
  //     );
  //     // Navigator.of(context).pushAndRemoveUntil(
  //     //     MaterialPageRoute(
  //     //         builder: (BuildContext context) => OrderScreen()),
  //     //         (Route<dynamic>route) => false);
  //   }
  //   // Navigator.of(context).pushAndRemoveUntil(
  //   //     MaterialPageRoute(
  //   //         builder: (BuildContext context) => OrderScreen()),
  //   //         (Route<dynamic>route) => false);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => OrderScreen()),
  //   );
  // }


  signIn(String email, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Map data = {'name': email, 'pass': pass};
    var jsonResponse = null;

    var response = await http.post(Uri.parse("http://151.106.17.246:8080/byco/api/orderlogin.php?name=" +
        email +
        "&pass=" +
        pass +
        "&accesskey=12345",));

    jsonResponse = json.decode(response.body);

    print(response);

    if (jsonResponse == null) {
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
    else {
      setState(() {
        print(jsonResponse);
        var Name = jsonResponse["data"][0]["user"]["consignee_name"];
        var id = jsonResponse["data"][0]["user"]["id"];
        var city = jsonResponse["data"][0]["user"]["District"];
        // var u_id = jsonResponse["data"][0]["user"]["id"];
        var address = jsonResponse["data"][0]["user"]["location"];
        var code = jsonResponse["data"][0]["user"]["code"];
        print(Name);
        print(city);
        print(id);
        print("Sapcode " + code.toString());


        // sharedPreferences.setString("email", emailCustomer);
        sharedPreferences.setString("pass", pass);
        // sharedPreferences.setString("id", u_id);
        sharedPreferences.setString("consignee_name", Name);
        sharedPreferences.setString("location", address);
        sharedPreferences.setString("District", city);
        sharedPreferences.setString("id", id);
        sharedPreferences.setString("code", code);

        print("Sapcode " + code.toString());

        var a = sharedPreferences.get("name");

        print(a.toString() + "Jawad Ahmed");
        print(emailController.text);


        // if (emailController.text == null && passController.text == null) {
        //   Fluttertoast.showToast(
        //       msg: "Email or password field is empty",
        //       toastLength: Toast.LENGTH_LONG,
        //       gravity: ToastGravity.BOTTOM,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        // }
        // else {
        //   Navigator.of(context).pushAndRemoveUntil(
        //       MaterialPageRoute(
        //           builder: (BuildContext context) => OrderScreen()),
        //           (Route<dynamic>route) => false);
        //   Fluttertoast.showToast(
        //       msg: "Login Successfully",
        //       toastLength: Toast.LENGTH_LONG,
        //       gravity: ToastGravity.BOTTOM,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        // }


        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), (Route<dynamic>route) => false);
        Fluttertoast.showToast(
            msg: "Login Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);





        // if(jsonResponse["data"][0]["user"]["code"] == email && jsonResponse["data"][0]["user"]["pass"] == pass){
        //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => OrderScreen()), (Route<dynamic>route) => false);
        //   Fluttertoast.showToast(
        //       msg: "Login Successfully",
        //       toastLength: Toast.LENGTH_LONG,
        //       gravity: ToastGravity.BOTTOM,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        // }
        // else{
        //   // Navigator.of(context).pushAndRemoveUntil(
        //   //     MaterialPageRoute(
        //   //         builder: (BuildContext context) => OrderScreen()),
        //   //         (Route<dynamic>route) => false);
        //   Fluttertoast.showToast(
        //       msg: "Login Failed",
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
}