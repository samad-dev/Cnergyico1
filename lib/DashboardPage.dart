import 'package:flutter/material.dart';
import 'package:cnergyico/LoginPage.dart';
// import 'package:flutter_app_byco/LoginPage.dart';
// import 'package:cnergyico/OrderPage.dart';
// import 'package:flutter_app_byco/singup.dart';
// import 'package:flutter_app_byco/utils/constants.dart';
import 'package:cnergyico/singup.dart';
import 'package:cnergyico/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // var name;
  //
  // void shprefer() async{
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //
  //   setState(() {
  //     name = sharedPreferences.get("name");
  //   });
  // }
  //
  // checkLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   if(prefs.get("name") != null){
  //     // Navigator.of(context).pushAndRemoveUntil(
  //     //     MaterialPageRoute(
  //     //         builder: (BuildContext context) => OrderScreen()),
  //     //         (Route<dynamic>route) => false);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => OrderScreen()),
  //     );
  //   }
  // }
  //
  // @override
  // void initState() {
  //   shprefer();
  //   checkLogin();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.gray,
     
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    // top: 100.0,
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 450,
                      width: double.infinity,
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     fit: BoxFit.fill,
                      //     image: AssetImage("assets/Images/bycologo.jpeg"),
                      //   ),
                      // ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      // child: Image.asset(
                      //   "assets/Images/byco_logo_1.jpg",
                      //   scale: 1.1,
                      // ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                decoration: BoxDecoration(
                  color: Constants.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1.0),


                      Container(
                        child: Row(
                          children: [

                            Container(
                                width: 80,
                                height: 80,
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage("assets/Images/Cnergyicoicon.png"),
                                      fit: BoxFit.fill,
                                    )
                                )
                            ),

                            SizedBox(width: 10,),

                            Text(
                              "Conecct!",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Color.fromRGBO(19, 22, 33, 1),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 1.0,
                      ),
                      Text(
                        "Welcome to Cnergyico Conecct. For any support, please contact our call center.",
                        style: TextStyle(
                          color: Color.fromRGBO(74, 77, 84, 1),
                          fontSize: 17.0,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      // Let's create a generic button widget
                      // AppButton(
                      //   text: "Log In",
                      //   type: ButtonType.PLAIN,
                      //   onPressed: () {
                      //     nextScreen(context, "/login");
                      //   },
                      // ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // color: Colors.black,
                              color: Constants.primarygreen,
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
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Constants.primaryorrange),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      // AppButton(
                      //   text: "Create an Account",
                      //   type: ButtonType.PRIMARY,
                      // )
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Signup()
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // color: Colors.black,
                              color: Constants.primarygreen,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Constants.primaryorrange),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/Images/bycosplash.png"),
          ),
        ),
      ),
    );
  }
}
