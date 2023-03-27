import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cnergyico/DashboardPage.dart';
import 'package:cnergyico/main.dart';
import 'package:cnergyico/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController sap_idcontroller = new TextEditingController();
  TextEditingController fstationcontroller = new TextEditingController();
  TextEditingController cniccontroller = new TextEditingController();
  TextEditingController cellnumbercontroller = new TextEditingController();

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

                                  controller: sap_idcontroller,
                                  // textAlign: TextAlign.scenter,
                                  decoration: InputDecoration(
                                      hintText: 'Enter ID',
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
                              child: Text("Filling Station", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                                height: 70,
                                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: TextField(

                                  controller: fstationcontroller,
                                  // textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      hintText: 'Enter Filling Station',
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
                            SizedBox(height: 25,),
                            Container(
                              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              // padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Text("CNIC", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                                height: 70,
                                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: TextField(

                                  keyboardType: TextInputType.number,
                                  maxLength: 13,
                                  controller: cniccontroller,
                                  // textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    counterText: "",
                                      hintText: 'Enter CNIC',
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
                            SizedBox(height: 25,),
                            Container(
                              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              // padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Text("Cell-Number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                                height: 70,
                                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: TextField(

                                  keyboardType: TextInputType.number,
                                  maxLength: 11,
                                  controller: cellnumbercontroller,
                                  // textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    counterText: "",
                                      hintText: 'Enter Cell-Number',
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
                            // Container(
                            //   margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            //   // padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                            //   child: Text("Pincode", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            // ),
                            // SizedBox(
                            //   height: 5.0,
                            // ),

                            // Container(
                            //   margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            //   padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                            //   child: PinCodeTextField(
                            //     appContext: context,
                            //     pastedTextStyle: TextStyle(
                            //       color: Colors.green.shade600,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //     length: 4,
                            //     obscureText: true,
                            //     obscuringCharacter: '*',
                            //     // obscuringWidget: FlutterLogo(
                            //     //   size: 24,
                            //     // ),
                            //     blinkWhenObscuring: true,
                            //     animationType: AnimationType.fade,
                            //     validator: (v) {
                            //       if (v!.length < 4) {
                            //         return "Fill Your Pincode";
                            //       } else {
                            //         return null;
                            //       }
                            //     },
                            //     pinTheme: PinTheme(
                            //       inactiveColor: Colors.black,
                            //       inactiveFillColor: Colors.white,
                            //       shape: PinCodeFieldShape.box,
                            //       borderRadius: BorderRadius.circular(5),
                            //       fieldHeight: 50,
                            //       fieldWidth: 50,
                            //       activeFillColor: Colors.white,
                            //     ),
                            //     cursorColor: Colors.black,
                            //     animationDuration: Duration(milliseconds: 300),
                            //     enableActiveFill: true,
                            //     // errorAnimationController: errorController,
                            //     controller: passController,
                            //     keyboardType: TextInputType.number,
                            //     boxShadows: [
                            //       BoxShadow(
                            //         offset: Offset(0, 1),
                            //         color: Colors.black12,
                            //         blurRadius: 10,
                            //       )
                            //     ],
                            //     onCompleted: (v) {
                            //       print("Completed");
                            //     },
                            //     // onTap: () {
                            //     //   print("Pressed");
                            //     // },
                            //     onChanged: (value) {
                            //       print(value);
                            //       setState(() {
                            //         // currentText = value;
                            //       });
                            //     },
                            //   ),
                            // ),



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
                            //   onTap: () {},
                            //   child: Text(
                            //     "Forgot Password?",
                            //     textAlign: TextAlign.right,
                            //     style: TextStyle(
                            //       fontSize: 15,
                            //       color: Constants.primaryColor,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 20.0,
                            // ),
                            GestureDetector(
                              onTap: (){
                                if(sap_idcontroller.text == "" && fstationcontroller.text == "" && cniccontroller.text == "" && cellnumbercontroller.text ==""){
                                  Fluttertoast.showToast(
                                      msg: "Fill All The Fields",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                                else{
                                  registration(sap_idcontroller.text, fstationcontroller.text, cniccontroller.text, cellnumbercontroller.text);
                                }
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
                                      'Register',
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

  registration(String sid, String fs, String ccnic, String phone) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Map data = {'name': email, 'pass': pass};
    var jsonResponse = null;

    var response = await http.post(Uri.parse("http://151.106.17.246:8080/byco/api/orderuser.php?accesskey=12345&sap=" + sid + "&fname=" + fs + "&cnic=" + ccnic + "&mnum=" + phone,));
    print(sid);
    print(fs);
    print(ccnic);
    print("http://151.106.17.246:8080/byco/api/orderuser.php?accesskey=12345&sap=" + sid + "&fname=" + fs + "&cnic=" + ccnic + "&mnum=" + phone);
    print(phone);

    jsonResponse = json.encode(response.body);

    print(response);
    print(jsonResponse.toString());

    if (jsonResponse.toString() == null) {
      setState(() {
        print("Jawad Ahmed");
        Fluttertoast.showToast(
            msg: "Registration not successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
    else {
      setState(() {
        print(jsonResponse);
        print(response);
        print(jsonResponse);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Signup()), (Route<dynamic>route) => false);
        Fluttertoast.showToast(
            msg: "Register Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });

    }
  }

}
