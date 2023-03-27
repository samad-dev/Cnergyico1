import 'package:flutter/material.dart';
import 'package:cnergyico/utils/constants.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({Key? key}) : super(key: key);

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify PinCode", style: TextStyle(color: Constants.primaryColor),),
        backgroundColor: Constants.gray,
      ),

      body: Container(
        child: Column(
          children: [

            SizedBox(height: 60,),


            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(50, 0, 15, 0),
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

            SizedBox(height: 100,),

            Container(
              height: 50,
              decoration: BoxDecoration(
                // color: Colors.black,
                  color: Constants.primaryColor,
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

          ],
        ),
      ),
    );
  }
}
