import 'dart:ui';
import 'package:cnergyico/Complaint.dart';
import 'package:cnergyico/Lube.dart';
import 'package:cnergyico/OrderPage.dart';
import 'package:cnergyico/Uniform.dart';
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
            image: AssetImage("assets/Images/bycolg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
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
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OrderScreen()));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.white),
                              right:
                                  BorderSide(width: 1.0, color: Colors.white),
                            ),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Icon(
                                  Icons.bookmark_border_outlined,
                                  color: Constants.primarygreen,
                                  size: 60,
                                ),
                             const Text(
                                  'Fuel Order',
                                  style:  TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UniformScreen()));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.white),
                              left: BorderSide(width: 1.0, color: Colors.white),
                            ),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                             const SizedBox(
                                  height: 50,
                                ),
                                Icon(
                                  Icons.man_rounded,
                                  color: Constants.primarygreen,
                                  size: 60,
                                ),
                               const Text(
                                  'Uniform',
                                  style:  TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Lube()));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.white),
                              right:
                                  BorderSide(width: 1.0, color: Colors.white),
                            ),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                const  SizedBox(
                                  height: 50,
                                ),
                                Icon(
                                  Icons.message_outlined,
                                  color: Constants.primarygreen,
                                  size: 60,
                                ),
                                const Text(
                                  'Complaint',
                                  style:  TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Complaint()));
                        },
                        child: Container(
                          decoration:const BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.white),
                              left: BorderSide(width: 1.0, color: Colors.white),
                            ),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                const  SizedBox(
                                  height: 50,
                                ),
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Constants.primarygreen,
                                  size: 60,
                                ),
                                const Text(
                                  'Lube',
                                  style:  TextStyle(
                                      fontSize: 16,
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
            const   SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height/4.4,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [

                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Retail Price ",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700,fontStyle: FontStyle.italic,color: Colors.black45),),
                          ),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [

                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("PMG",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontStyle: FontStyle.italic,color: Color.fromRGBO(18, 99, 81, 1.0)),),
                          ),
                          SizedBox(width: 140,),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("270.00 Rs/Litre",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontStyle: FontStyle.italic,color: Color.fromRGBO(18, 99, 81, 1.0)),),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [

                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("HSD",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontStyle: FontStyle.italic,color: Color.fromRGBO(18, 99, 81, 1.0)),),
                          ),
                          SizedBox(width: 140,),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("258.00 Rs/Litre",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontStyle: FontStyle.italic,color: Color.fromRGBO(18, 99, 81, 1.0)),),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
