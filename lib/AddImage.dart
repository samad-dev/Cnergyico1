// import 'dart:html';
// import 'dart:html';
import 'dart:io';
import 'dart:math';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;


class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {

  bool showSpinner = false;
  final postref = FirebaseDatabase.instance.reference().child('posts');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;

  File? _image;
  UploadTask? task;
  late String basename;


  int _counter = 0;

  // File _image;
  late String _uploadedFileURL;
  bool isLoading = false;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
      else {
        print("no image selected");
      }
    });
  }

  Future getCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
      else {
        print("no image selected");
      }
    });
  }


  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  // Future uploadFile() async{
  //   if(_image == null) return;
  //
  // }


  void dialog(context) {
    showDialog(
        context: context, builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 120,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  getImage();
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Gallery"),
                ),
              ),
              InkWell(
                onTap: () {
                  getCamera();
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Camera"),
                ),
              ),
            ],
          ),
        ),
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Image"),),
      body: Container(
        color: Colors.white60,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                dialog(context);
              },
              child: Column(
                children: [
                  // Icon(Icons.camera_alt),
                  Center(
                    child: Container(
                      // height: MediaQuery.of(context).size.height * .2,
                      // width: MediaQuery.of(context).size.width * 1,
                      height: 100,
                      width: 100,
                      child: _image != null ? ClipRect(
                        child: Image.file(
                          _image!.absolute,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                      ) : Container(
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          border: Border.all(width: 3),
                        ),
                        child: Icon(Icons.camera_alt, color: Colors.blue,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(_image.toString()),

            GestureDetector(
              onTap: () async {

                try{
                  int date = DateTime.now().microsecondsSinceEpoch;
                  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/bycoapp$date');
                  UploadTask uploadtask = ref.putFile(_image!.absolute);
                  await Future.value(uploadtask);
                  var newUrl = await ref.getDownloadURL();



                  final User? user = _auth.currentUser;
                  postref.child('Post List').child(date.toString()).set({


                    'pId': date.toString(),
                    'pImage': newUrl.toString(),
                    'ptime': date.toString(),
                    'uid': user!.uid.toString(),

                  }).then((value){
                    toastMessage("Image Upload");

                  }).onError((error, stackTrace){
                    toastMessage(e.toString());
                  });
                }
                catch(e){
                  toastMessage(e.toString());
                }

              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.red,
                width: 130,
                height: 50,
                child: Text("Upload"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void toastMessage(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // Future uploadFile() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Reference storageReference = FirebaseStorage.instance
  //       .ref()
  //       .child('images/${Path.basename(_image!.path)}}');
  //   StorageUploadTask uploadTask = storageReference.putFile(_image!);
  //   await uploadTask.onComplete;
  //   print('File Uploaded');
  //   storageReference.getDownloadURL().then((fileURL) {
  //     setState(() {
  //       _uploadedFileURL = fileURL;
  //       isLoading = false;
  //     });
  //   });
  // }
}