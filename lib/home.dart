import 'dart:ui';
import 'package:cnergyico/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Constants.primarygreen,
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        // color: Colors.black.withOpacity(0.6),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Images/bycolg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 60,left: 16,right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  const SizedBox(height: 50),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      GestureDetector(
                        onTap: (){
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AllMapSample()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: Colors.white),
                              right: BorderSide(width: 1.0, color: Colors.white),
                            ),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(height: 50,),
                                Icon(Icons.bookmark_border_outlined,color: Constants.primarygreen,size: 60,),
                                Text(
                                  'Order',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MyListViewScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: Colors.white),
                              left: BorderSide(width: 1.0, color: Colors.white),
                            ),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(height: 50,),
                                Icon(Icons.man_rounded,color: Constants.primarygreen,size: 60,),
                                Text(
                                  'Uniform',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>SettingPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.white),
                              right: BorderSide(width: 1.0, color: Colors.white),
                            ),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Column(
                              children: [

                                SizedBox(height: 50,),
                                Icon(Icons.message_outlined,color: Constants.primarygreen,size: 60,),
                                Text(
                                  'Complaint',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AlertList()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.white),
                              left: BorderSide(width: 1.0, color: Colors.white),
                            ),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(height: 50,),
                                Icon(Icons.access_time_outlined,color:Constants.primarygreen,size: 60,),
                                Text(
                                  'Lube',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
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
          ],
        ),
      ),
    );
  }
}
