import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cnergyico/OrderPage.dart';
import 'package:cnergyico/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'DashboardPage.dart';


class Checkerslg extends StatefulWidget {
  const Checkerslg({Key? key}) : super(key: key);

  @override
  _CheckerslgState createState() => _CheckerslgState();
}

class _CheckerslgState extends State<Checkerslg> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  var  pass, address, city, user_id, name, id;

  void shprefer() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      // email = sharedPreferences.get("email");
      pass = sharedPreferences.get("pass");
      name = sharedPreferences.get("name");
      city = sharedPreferences.get("city");
      address = sharedPreferences.get("address");
      user_id = sharedPreferences.get("user_id");
      id = sharedPreferences.get("id");
    });
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.get("name") != null){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => OrderScreen()),
              (Route<dynamic>route) => false);
    }
/*    else{
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) => Login()),
            // (Route<dynamic>route => false);
      );
    }*/
  }

  @override
  void initState() {
    shprefer();
    // checkLogin();
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Constants.primaryColor,

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
                              child: Text("Pump ID", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
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
                                      hintText: 'Enter Your Pump ID',
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
                            // Container(
                            //     alignment: Alignment.centerLeft,
                            //     height: 70,
                            //     width: 20,
                            //     margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            //     padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                            //     child: TextField(
                            //       obscureText: true,
                            //
                            //       controller: passController,
                            //       // textAlign: TextAlign.center,
                            //       decoration: InputDecoration(
                            //           // hintText: 'Enter Your Pin Code',
                            //           // focusedBorder: InputBorder.none,
                            //           border: OutlineInputBorder(),
                            //           hintStyle: TextStyle(
                            //             color: Colors.black54,
                            //           )
                            //       ),
                            //       style: TextStyle(fontSize: 16,
                            //           color: Colors.black),
                            //     )),

                            SizedBox(height: 10,),





                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(30, 0, 15, 0),
                                  width: 50,
                                  child: TextField(
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  width: 50,
                                  child: TextField(
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  width: 50,
                                  child: TextField(
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  width: 50,
                                  child: TextField(
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),


                            SizedBox(
                              height: 15.0,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Forgot Pin Code?",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            GestureDetector(
                              onTap: (){
                                signIn(emailController.text, passController.text);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  // color: Colors.black,
                                    color: Constants.primaryColor,
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

                            // AppButton(
                            //   type: ButtonType.PRIMARY,
                            //   text: "Log In",
                            //   onPressed: () {
                            //     nextScreen(context, "/dashboard");
                            //   },
                            // )

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


  signIn(String email, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'name': email, 'pass': pass};
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
        // _isLoading = false;
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
        //         (Route<dynamic> route) => false);
        // Toast.show("Welcome Back", context,
        //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        print(jsonResponse);


        var Name = jsonResponse["data"][0]["user"]["consignee_name"];
        var id = jsonResponse["data"][0]["user"]["id"];
        var city = jsonResponse["data"][0]["user"]["city"];
        var u_id = jsonResponse["data"][0]["user"]["id"];
        var address = jsonResponse["data"][0]["user"]["address"];
        print(Name);
        print(city);
        print(u_id);

        // sharedPreferences.setString("email", emailCustomer);
        sharedPreferences.setString("pass", pass);
        sharedPreferences.setString("id", u_id);
        sharedPreferences.setString("name", Name);
        sharedPreferences.setString("location", address);
        sharedPreferences.setString("city", city);
        sharedPreferences.setString("id", id);

        var a = sharedPreferences.get("name");

        print(a.toString()+"Jawad Ahmed");
        print(emailController.text);

        if(emailController.text == "" && passController.text == ""){
          Fluttertoast.showToast(
              msg: "Email or password field is empty",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        else{
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => OrderScreen()),
                  (Route<dynamic>route) => false);
          Fluttertoast.showToast(
              msg: "Login Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
    }
  }
}
