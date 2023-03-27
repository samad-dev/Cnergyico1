import 'package:flutter/material.dart';
import 'package:cnergyico/HistoryPage.dart';
import 'package:cnergyico/LoginPage.dart';
import 'package:cnergyico/MapPage.dart';
import 'package:cnergyico/OrderPage.dart';
import 'package:cnergyico/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  _TripsScreenState createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index == 0){
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const TripsScreen(),
          ),
        );
      }
      else if(index == 1){
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const OrderScreen(),
          ),
        );
      }
      else if(index == 2){
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
    });
  }

  signout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text("Trips", style: TextStyle(color: Constants.primaryColor,),),
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
                      color: Constants.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Constants.gray,
        ),

        body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                        child: Column(
                          children: [
                            // listsc(),
                            //
                            // listsc1("10/08/2021", "08:30 PM", "TUC-123", "Shahrai-e-Faisal Near Marine Faisal", "Korangi Crossing", "HBD"),
                            //
                            // GestureDetector(
                            //   onTap: (){
                            //     Navigator.of(context).push(
                            //       MaterialPageRoute(
                            //           builder: (context) => MapScreen3()
                            //       ),
                            //     );
                            //   }, child: Container(child: listscr("10/08/2021", "08:30 PM", "TUC-123", "Shahrai-e-Faisal Near Marine", "Korangi Crossing Near Allah wala Town", "HBD"))),
                            //
                            // SizedBox(
                            //   height: 20,
                            // ),
                            //
                            // listscr("10/08/2021", "08:30 PM", "TUC-123", "Shahrai-e-Faisal Near Marine Building", "Korangi Crossing Near Allah wala Town", "HBD"),
                            //
                            //
                            // SizedBox(
                            //   height: 20,
                            // ),
                            //
                            // listscreenred("10/08/2021", "08:30 PM", "TUC-123", "Shahrai-e-Faisal Near Marine Building", "Korangi Crossing Near Allah wala Town", "HBD"),
                            //
                            // SizedBox(
                            //   height: 20,
                            // ),
                            //
                            // listscreenblue("10/08/2021", "08:30 PM", "TUC-123", "Shahrai-e-Faisal Near Marine Building", "Korangi Crossing Near Allah wala Town", "HBD"),
                            //
                            // SizedBox(
                            //   height: 20,
                            // ),
                            //
                            // listscreengreen("10/08/2021", "08:30 PM", "TUC-123", "Shahrai-e-Faisal Near Marine Building", "Korangi Crossing Near Allah wala Town", "HBD"),
                            //
                            // SizedBox(
                            //   height: 20,
                            // ),
                            //
                            // listscrgreen("10/08/2021", "08:30 PM", "TUC-123", "Shahrai-e-Faisal Near Marine Building", "Korangi Crossing Near Allah wala Town", "HBD"),
                            //
                            // SizedBox(
                            //   height: 20,
                            // ),
                            //
                            // listscrblue("10/08/2021", "08:30 PM", "TUC-123", "Shahrai-e-Faisal Near Marine Building", "Korangi Crossing Near Allah wala Town", "HBD"),
                            //
                            // SizedBox(
                            //   height: 20,
                            // ),
                            //
                            // listscrred("10/08/2021", "08:30 PM", "TUC-123", "Shahrai-e-Faisal Near Marine Building", "Korangi Crossing Near Allah wala Town", "HBD"),
                            //
                            // SizedBox(
                            //   height: 20,
                            // ),

                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => MapScreen3()
                                  ),
                                );
                              },
                              child: listscrgreencar("10/08/2021", "08:30 PM", "TUC-123", "Shahrai-e-Faisal Near Marine Building", "Korangi Crossing Near Allah wala Town", "HBD"),
                            ),


                            SizedBox(
                              height:15,
                            ),

                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => MapScreen3()
                                  ),
                                );
                              },
                              child: listscrbluecar("10/08/2021", "08:30 PM", "TUC-123", "Shahrai-e-Faisal Near Marine Building", "Korangi Crossing Near Allah wala Town", "HBD"),
                            ),


                            SizedBox(
                              height:15,
                            ),

                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => MapScreen3()
                                  ),
                                );
                              },
                              child: listscrredcar("10/08/2021", "08:30 PM", "TUC-123", "Shahrai-e-Faisal Near Marine Building", "Korangi Crossing Near Allah wala Town", "HBD"),
                            ),



                            SizedBox(height: 20,),

                            // GestureDetector(
                            //   onTap: () async {
                            //     // SharedPreferences prefs = await SharedPreferences.getInstance();
                            //     // prefs.remove('email');
                            //     SharedPreferences prefs = await SharedPreferences.getInstance();
                            //     prefs.remove('name');
                            //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
                            //   },
                            //   child: Card(
                            //     elevation: 8,
                            //     color: Colors.red,
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(10)),
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(12.0),
                            //       child: Center(
                            //         child: Text(
                            //           "Sign Out",
                            //           style: TextStyle(
                            //             fontSize: 16.0,
                            //             color: Colors.white,
                            //           ),
                            //           overflow: TextOverflow.ellipsis,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),



                                 ],
                        ),
                    ),
                ),
            ),
        ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),

    );
  }







  Widget listsc(){
    return Container(
      child: Container(
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
        child: Row(
          children: [


            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                children: [
                  Container(
                    child: Text("16/08/2021", style: TextStyle(fontSize: 10, color: Colors.black54),),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    child: Text("07:09 PM", style: TextStyle(fontSize: 14, color: Colors.black),),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Container(
                    child: Text("TUC-607", style: TextStyle(fontSize: 10, color: Colors.black54),),
                  ),
                ],
              ),
            ),


            // Column(
            //   children: [
            //
            //     Padding(
            //       padding: const EdgeInsets.all(5.0),
            //       child: Container(
            //         margin: EdgeInsets.only(left: 20),
            //         width: 2,
            //         color: Colors.black45,
            //         height: 80,
            //
            //       ),
            //     ),
            //
            //   ],
            // ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                margin: EdgeInsets.only(left: 20),
                width: 2,
                color: Colors.black45,
                height: 80,

              ),
            ),


            SizedBox(
              width: 10,
            ),

            Column(
              children: [

                Container(
                  width: 200,
                  // height: 50,
                  child: Text("opposite Karachi Foods", style: TextStyle(fontSize: 16, fontWeight:  FontWeight.bold, color: Colors.black54),),
                ),


                SizedBox(
                  height: 15,
                ),


                Container(
                  width: 200,

                  child: Text("Outside Al-Khidmat Medical", style: TextStyle(fontSize: 16, fontWeight:  FontWeight.bold, color: Colors.black54),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 200,
                  child: Text("Product: HSD", style: TextStyle(fontSize: 12, color: Colors.black45),),
                ),

                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget listsc1(String date, String time, String vno, String spoint, String epoint, String pname){
    return Container(
      child: Container(
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
        child: Row(
          children: [


            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                children: [
                  Container(
                    child: Text(date, style: TextStyle(fontSize: 10, color: Colors.black54),),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54),),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Container(
                    child: Text(vno, style: TextStyle(fontSize: 10, color: Colors.black54),),
                  ),
                ],
              ),
            ),


            // Column(
            //   children: [
            //
            //     Padding(
            //       padding: const EdgeInsets.all(5.0),
            //       child: Container(
            //         margin: EdgeInsets.only(left: 20),
            //         width: 2,
            //         color: Colors.black45,
            //         height: 80,
            //
            //       ),
            //     ),
            //
            //   ],
            // ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                margin: EdgeInsets.only(left: 20),
                width: 2,
                color: Colors.black45,
                height: 80,

              ),
            ),


            SizedBox(
              width: 10,
            ),

            Column(
              children: [

                Container(
                  width: 200,
                  // height: 50,
                  child: Text(spoint, style: TextStyle(fontSize: 16, fontWeight:  FontWeight.bold, color: Colors.black54),),
                ),


                SizedBox(
                  height: 15,
                ),


                Container(
                  width: 200,

                  child: Text(epoint, style: TextStyle(fontSize: 16, fontWeight:  FontWeight.bold, color: Colors.black54),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 200,
                  child: Text("Product: " + pname, style: TextStyle(fontSize: 12, color: Colors.black45),),
                ),

                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget listscr(String date, String time, String vno, String spoint, String epoint, String pname){
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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(date, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,

                  width: 80,
                  // height: 50,
                  child: Text(spoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight:  FontWeight.bold, color: Colors.black54),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(vno, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),
              ],
            ),


            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  // color: Colors.blue,
                  height: 50,
                  width: 140,
                  child: Row(
                    children: [
                      
                      Column(
                        children: [

                          Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.red,
                          ),
                          // Icon(
                          //   Icons.car_repair,
                          //   size: 20,
                          //   color: Colors.red,
                          // )
                        ],
                      ),

                      Column(
                        children: [

                          Container(
                            margin: EdgeInsets.only(top: 3),
                            width: 45,
                            height: 2,
                            color: Colors.black54,
                          ),

                        ],
                      ),


                      Column(
                        children: [

                          Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.blue,
                          ),
                          // Icon(
                          //   Icons.car_repair,
                          //   size: 20,
                          //   color: Colors.blue,
                          // )
                        ],
                      ),

                      Column(
                        children: [

                          Container(
                            margin: EdgeInsets.only(top: 3),
                            width: 45,
                            height: 2,
                            color: Colors.black54,
                          ),

                        ],
                      ),

                      Column(
                        children: [

                          Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.car_repair,
                            size: 20,
                            color: Colors.green,
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
                  child: Text(date, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(epoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text("Product: " + pname, style: TextStyle(fontSize: 10, color: Colors.black54, fontWeight:  FontWeight.bold),),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }






  Widget listscrred(String date, String time, String vno, String spoint, String epoint, String pname){
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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,

                  width: 80,
                  child: Text(date, style: TextStyle(fontSize: 12, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  // color: Colors.blue,
                  width: 80,
                  // height: 50,
                  child: Text(spoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight:  FontWeight.bold, color: Colors.black54),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(vno, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),
              ],
            ),


            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  // color: Colors.blue,
                  margin: EdgeInsets.only(top: 60),
                  // color: Colors.blue,
                  height: 32,
                  width: 145,
                  child: Row(
                    children: [

                      Column(
                        children: [

                          Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.red,
                          ),
                          Icon(
                            Icons.car_repair,
                            size: 20,
                            color: Colors.red,
                          )
                        ],
                      ),

                      Column(
                        children: [

                          Container(
                            margin: EdgeInsets.only(top: 3),
                            width: 55,
                            height: 2,
                            color: Colors.red,
                          ),


                        ],
                      ),

                      // Column(
                      //   children: [
                      //
                      //     Icon(
                      //       Icons.circle,
                      //       size: 10,
                      //       color: Colors.blue,
                      //     ),
                      //     Icon(
                      //       Icons.car_repair,
                      //       size: 20,
                      //       color: Colors.blue,
                      //     )
                      //   ],
                      // ),

                      Column(
                        children: [

                          Container(
                            margin: EdgeInsets.only(top: 3),
                            width: 55,
                            height: 2,
                            color: Colors.red,
                          ),

                        ],
                      ),


                      // Column(
                      //   children: [
                      //
                      //     Icon(
                      //       Icons.circle,
                      //       size: 10,
                      //       color: Colors.green,
                      //     ),
                      //     Icon(
                      //       Icons.car_repair,
                      //       size: 20,
                      //       color: Colors.green,
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 1),
                  padding: EdgeInsets.only(left: 8),
                  child: Text("Pending", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),),
                ),
              ],
            ),


            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(date, style: TextStyle(fontSize: 12, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(epoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text("Product: " + pname, style: TextStyle(fontSize: 10, color: Colors.black54, fontWeight:  FontWeight.bold),),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listscrblue(String date, String time, String vno, String spoint, String epoint, String pname){
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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(date, style: TextStyle(fontSize: 12, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,

                  width: 80,
                  // height: 50,
                  child: Text(spoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight:  FontWeight.bold, color: Colors.black54),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(vno, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),
              ],
            ),


            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 60),
                  // color: Colors.blue,
                  height: 30,
                  width: 140,
                  child: Row(
                    children: [

                      // Column(
                      //   children: [
                      //
                      //     Icon(
                      //       Icons.circle,
                      //       size: 10,
                      //       color: Colors.red,
                      //     ),
                      //     // Icon(
                      //     //   Icons.car_repair,
                      //     //   size: 20,
                      //     //   color: Colors.red,
                      //     // )
                      //   ],
                      // ),

                      Column(
                        children: [

                          Container(
                            margin: EdgeInsets.only(top: 3),
                            width: 55,
                            height: 2,
                            color: Colors.blue,
                          ),

                        ],
                      ),


                      Column(
                        children: [

                          Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.blue,
                          ),
                          Icon(
                            Icons.car_repair,
                            size: 20,
                            color: Colors.blue,
                          )
                        ],
                      ),

                      Column(
                        children: [

                          Container(
                            margin: EdgeInsets.only(top: 3),
                            width: 55,
                            height: 2,
                            color: Colors.blue,
                          ),

                        ],
                      ),

                      // Column(
                      //   children: [
                      //
                      //     Icon(
                      //       Icons.circle,
                      //       size: 10,
                      //       color: Colors.green,
                      //     ),
                      //     Icon(
                      //       Icons.car_repair,
                      //       size: 20,
                      //       color: Colors.green,
                      //     ),
                      //   ],
                      // ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 1),
                  padding: EdgeInsets.only(left: 5),
                  child: Text("On Trip", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),),
                ),
              ],
            ),


            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(date, style: TextStyle(fontSize: 12, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(epoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text("Product: " + pname, style: TextStyle(fontSize: 10, color: Colors.black54, fontWeight:  FontWeight.bold),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listscrgreen(String date, String time, String vno, String spoint, String epoint, String pname){
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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(date, style: TextStyle(fontSize: 12, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,

                  width: 80,
                  // height: 50,
                  child: Text(spoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight:  FontWeight.bold, color: Colors.black54),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(vno, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),
              ],
            ),


            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  // color: Colors.blue,
                  height: 33,
                  width: 140,
                  child: Row(
                    children: [

                      // Column(
                      //   children: [
                      //
                      //     Icon(
                      //       Icons.circle,
                      //       size: 10,
                      //       color: Colors.red,
                      //     ),
                      //     // Icon(
                      //     //   Icons.car_repair,
                      //     //   size: 20,
                      //     //   color: Colors.red,
                      //     // )
                      //   ],
                      // ),

                      Column(
                        children: [

                          Container(
                            margin: EdgeInsets.only(top: 3),
                            width: 55,
                            height: 2,
                            color: Colors.green,
                          ),

                        ],
                      ),


                      // Column(
                      //   children: [
                      //
                      //     Icon(
                      //       Icons.circle,
                      //       size: 10,
                      //       color: Colors.blue,
                      //     ),
                      //     // Icon(
                      //     //   Icons.car_repair,
                      //     //   size: 20,
                      //     //   color: Colors.blue,
                      //     // )
                      //   ],
                      // ),

                      Column(
                        children: [

                          Container(
                            margin: EdgeInsets.only(top: 3),
                            width: 55,
                            height: 2,
                            color: Colors.green,
                          ),

                        ],
                      ),

                      Column(
                        children: [

                          Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.car_repair,
                            size: 20,
                            color: Colors.green,
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 1),
                  padding: EdgeInsets.only(left: 5),
                  child: Text("Done", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),),
                ),
              ],
            ),


            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(date, style: TextStyle(fontSize: 12, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(epoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text("Product: " + pname, style: TextStyle(fontSize: 10, color: Colors.black54, fontWeight:  FontWeight.bold),),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }




  Widget listscreenred(String date, String time, String vno, String spoint, String epoint, String pname){
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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(date, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,

                  width: 80,
                  // height: 50,
                  child: Text(spoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight:  FontWeight.bold, color: Colors.black54),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  // color: Colors.blue,
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(vno, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),
              ],
            ),


            //Attach widget of curved line
            Column(
              children: [

                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MapScreen3()
                      ),
                    );
                  },
                  child: Container(
                    width: 145,
                    height: 130,
                    child: Image.asset("assets/Images/r1.jpg", fit: BoxFit.fill,),
                  ),
                )

              ],
            ),


            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  // color: Colors.blue,
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(date, style: TextStyle(fontSize: 10, color: Colors.red,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.red,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(epoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.red,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text("Product: " + pname, style: TextStyle(fontSize: 10, color: Colors.red, fontWeight:  FontWeight.bold),),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listscreenblue(String date, String time, String vno, String spoint, String epoint, String pname){
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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(date, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,

                  width: 80,
                  // height: 50,
                  child: Text(spoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight:  FontWeight.bold, color: Colors.black54),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  // color: Colors.blue,
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(vno, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),
              ],
            ),


            //Attach widget of curved line
            Column(
              children: [

                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MapScreen3()
                      ),
                    );
                  },
                  child: Container(
                    width: 145,
                    height: 130,
                    child: Image.asset("assets/Images/r2.jpg", fit: BoxFit.fill,),
                  ),
                )

              ],
            ),


            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  // color: Colors.blue,
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(date, style: TextStyle(fontSize: 10, color: Colors.blue,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.blue,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(epoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.blue,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text("Product: " + pname, style: TextStyle(fontSize: 10, color: Colors.blue, fontWeight:  FontWeight.bold),),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listscreengreen(String date, String time, String vno, String spoint, String epoint, String pname){
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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(date, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,

                  width: 80,
                  // height: 50,
                  child: Text(spoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight:  FontWeight.bold, color: Colors.black54),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  // color: Colors.blue,
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Text(vno, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),
              ],
            ),


            //Attach widget of curved line
            Column(
              children: [

                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MapScreen3()
                      ),
                    );
                  },
                  child: Container(
                    width: 145,
                    height: 130,
                    child: Image.asset("assets/Images/r3.jpg", fit: BoxFit.fill,),
                  ),
                )

              ],
            ),


            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  // color: Colors.blue,
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(date, style: TextStyle(fontSize: 10, color: Colors.green,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.green,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(epoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.green,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text("Product: " + pname, style: TextStyle(fontSize: 10, color: Colors.green, fontWeight:  FontWeight.bold),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }




  Widget listscrredcar(String date, String time, String vno, String spoint, String epoint, String pname){
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
                  child: Text(date, style: TextStyle(fontSize: 12, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  // color: Colors.blue,
                  width: 70,
                  // height: 50,
                  child: Text(spoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight:  FontWeight.bold, color: Colors.black54),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(vno, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
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
                  child: Column(
                    children: [

                      Column(
                        children: [

                          Row(
                            children: [

                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),

                              Container(
                                width: 55,
                                height: 2,
                                color: Colors.red,
                              ),

                              Container(
                                width: 55,
                                height: 2,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ],
                      ),


                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                // margin: EdgeInsets.only(left: 50),
                                child: Icon(
                                  Icons.car_repair,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                      Column(
                        children: [

                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 30),
                                padding: EdgeInsets.only(top: 5),
                                child: Text("Pending", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),),
                              ),
                            ],
                          )

                        ],
                      )


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
                  child: Text(date, style: TextStyle(fontSize: 12, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(epoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text("Product: " + pname, style: TextStyle(fontSize: 10, color: Colors.black54, fontWeight:  FontWeight.bold),),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listscrbluecar(String date, String time, String vno, String spoint, String epoint, String pname){
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
                  child: Text(date, style: TextStyle(fontSize: 12, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  // color: Colors.blue,
                  width: 70,
                  // height: 50,
                  child: Text(spoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight:  FontWeight.bold, color: Colors.black54),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(vno, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
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
                  child: Column(
                    children: [

                      //Column1
                      Column(
                        children: [
                          //Row1
                          Row(
                            children: [

                              Container(
                                width: 55,
                                height: 2,
                                color: Colors.blue,
                              ),

                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),

                              Container(
                                width: 55,
                                height: 2,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ],
                      ),

                      //Column2
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 50),
                                child: Icon(
                                  Icons.car_repair,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                      Column(
                        children: [

                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 30),
                                padding: EdgeInsets.only(top: 5),
                                child: Text("On Trip", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),),
                              ),
                            ],
                          )

                        ],
                      )

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
                  child: Text(date, style: TextStyle(fontSize: 12, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(epoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text("Product: " + pname, style: TextStyle(fontSize: 10, color: Colors.black54, fontWeight:  FontWeight.bold),),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listscrgreencar(String date, String time, String vno, String spoint, String epoint, String pname){
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
                  child: Text(date, style: TextStyle(fontSize: 12, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  // color: Colors.blue,
                  width: 70,
                  // height: 50,
                  child: Text(spoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight:  FontWeight.bold, color: Colors.black54),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(vno, style: TextStyle(fontSize: 10, color: Colors.black54,  fontWeight:  FontWeight.bold),),
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
                            child: Text("Complete", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),),
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
                  child: Text(date, style: TextStyle(fontSize: 12, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(time, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text(epoint, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.black54,  fontWeight:  FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: 70,
                  child: Text("Product: " + pname, style: TextStyle(fontSize: 10, color: Colors.black54, fontWeight:  FontWeight.bold),),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }



}