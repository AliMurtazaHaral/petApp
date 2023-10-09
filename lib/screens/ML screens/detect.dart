import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/screens/ML%20screens/cnn_result.dart';
import 'package:fyp/widgets/loading_screen.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fyp/widgets/img.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:html/parser.dart' as parser;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/models/storage.dart';

import '../../models/UserModel.dart';

class DetectScreen extends StatefulWidget {
  DetectScreen();

  @override
  DetectScreenState createState() => new DetectScreenState();
}

class DetectScreenState extends State<DetectScreen> {
  var animal_data = null;
  bool check = false;
  File? selectedImage;
  File? second_Image;
  late Reference getUrl;
  String? message = "";
  String? bg_image = "";
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final StorageModel storage = StorageModel();

  // posttoFirebase() async {
  //   UserModel userModel = UserModel();
  //   userModel.animal_name = message;
  //   userModel.animal_image = getUrl.fullPath.toString();
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   await firebaseFirestore
  //       .collection("users")
  //       .doc("LQ0PFtnsaxXU1c4tY0ZM")
  //       .collection("Visitor")
  //       .doc(user!.uid)
  //       .collection("animals")
  //       .doc()
  //       .set(userModel.toMapAnimalDetails());
  // }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc("LQ0PFtnsaxXU1c4tY0ZM")
        .collection("Visitor")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMapRegsitration(value.data());
      setState(() {});
    });
  }



  Future<String?> uploadImage() async {
    final request = http.MultipartRequest(
        "POST", Uri.parse("https://92b5-39-32-138-200.eu.ngrok.io/upload"));
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile('image',
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    message = resJson['message'];
    print(message);
    return message;
    // second_Image = selectedImage;
    // final animal_data = await extractData(message!);
    // setState(() {
    //   selectedImage = null;
    // });
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    //         contentPadding: EdgeInsets.all(0.0),
    //         backgroundColor: Colors.white,
    //         scrollable: true,
    //         content: Column(
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           children: [
    //             ClipRRect(
    //               borderRadius: BorderRadius.circular(10.0),
    //               child: Image.file(second_Image! ,
    //                 height: 150,
    //               ),
    //             ),
    //             Row(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(left: 8.0),
    //                   child: Text(
    //                     "Name: ",
    //                     style: TextStyle(
    //                         color: Colors.cyan[800], fontWeight: FontWeight.bold,
    //                         fontSize: 20),
    //                   ),
    //                 ),
    //                 Text(
    //                   message!,
    //                   style: TextStyle(
    //                       color: Colors.teal[900]
    //                   ),
    //                 )
    //               ],
    //             ),
    //             SizedBox(height: 10,),
    //             Row(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(left: 8.0),
    //                   child: Text(
    //                     "Kingdom: ",
    //                     style: TextStyle(
    //                         color: Colors.cyan[800], fontWeight: FontWeight.bold,
    //                         fontSize: 20),
    //                   ),
    //                 ),
    //                 Text(
    //                   animal_data[0],
    //                   style: TextStyle(
    //                       color: Colors.teal[900]
    //                   ),
    //                 )
    //               ],
    //             ),
    //             SizedBox(height: 10,),
    //             Row(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(left: 8.0),
    //                   child: Text(
    //                     "Class: ",
    //                     style: TextStyle(
    //                         color: Colors.cyan[800], fontWeight: FontWeight.bold,
    //                         fontSize: 20),
    //                   ),
    //                 ),
    //                 Text(
    //                     animal_data[1],
    //                     style: TextStyle(
    //                         color: Colors.teal[900]
    //                     )
    //                 )
    //               ],
    //             ),
    //             SizedBox(height: 10,),
    //             Row(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(left: 8.0),
    //                   child: Text(
    //                     "Order: ",
    //                     style: TextStyle(
    //                         color: Colors.cyan[800], fontWeight: FontWeight.bold,
    //                         fontSize: 20),
    //                   ),
    //                 ),
    //                 Text(
    //                     animal_data[2],
    //                     style: TextStyle(
    //                         color: Colors.teal[900]
    //                     )
    //                 )
    //               ],
    //             ),
    //             SizedBox(height: 10,),
    //             Row(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(left: 8.0),
    //                   child: Text(
    //                     "Species: ",
    //                     style: TextStyle(
    //                         color: Colors.cyan[800], fontWeight: FontWeight.bold,
    //                         fontSize: 20),
    //                   ),
    //                 ),
    //                 Text(
    //                     animal_data[3],
    //                     style: TextStyle(
    //                         color: Colors.teal[900]
    //                     )
    //                 )
    //               ],
    //             ),
    //             SizedBox(height: 10,),
    //             TextButton.icon(
    //               style: ButtonStyle(
    //                   backgroundColor: MaterialStateProperty.all(Color(0x00000000))
    //               ),
    //               onPressed:() async {
    //
    //                 // final result = await FilePicker.platform.pickFiles(
    //                 //   allowMultiple: false,
    //                 //   type: FileType.custom,
    //                 //   allowedExtensions: ['jpg', 'png'],
    //                 // );
    //                 // if (result == null) {
    //                 //   ScaffoldMessenger.of(context).showSnackBar(
    //                 //     const SnackBar(
    //                 //       content: Text('no file selected'),
    //                 //     ),
    //                 //   );
    //                 // } else {
    //                 //   final path = result?.files.single.path;
    //                 //   final fileName = result?.files.single.name;
    //                 //   storage
    //                 //       .uploadFileImage(path, fileName)
    //                 //       .then((value) => const SnackBar(
    //                 //     content: Text("File Has been uploaded successfully"),
    //                 //   ));
    //                 //   getUrl = FirebaseStorage.instance.ref().child(fileName!);
    //                 //   posttoFirebase();
    //                 // }
    //
    //
    //
    //                 // writing all the values
    //
    //
    //               },
    //
    //
    //               //selectedImage = null,
    //               icon: Icon(Icons.save_alt , color: Colors.teal[800],),
    //               label: Text("Save", style: TextStyle(
    //                   color: Colors.teal[800]
    //               ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     });
  }


  Future pickImage(ImageSource source) async {
    // var camerapermission = await Permission.camera;
    // var gallerypermission = await Permission.photos;
    // var image = await ImagePicker().pickImage(source: source);
    // if (image == null) return;
    // final imageTemporary = File(image.path);
    // image = imageTemporary as XFile?;
    // return image;

    final pickedImage =
        await ImagePicker().getImage(source: source, imageQuality: 85);
    selectedImage = File(pickedImage!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
    check? const Loading_Page():
     Scaffold(
      backgroundColor: Colors.teal[800]!.withOpacity(0.9),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Stack(children: [
                    selectedImage == null
                        ? Container(
                            decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Img.get("Detect.jpg")),
                                fit: BoxFit.fitHeight),
                          ))
                        : Container(
                            color: Colors.black,
                          ),
                    SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        selectedImage == null
                            ? Text(
                                "Please pick an Image to Upload",
                                style: TextStyle(color: Colors.white),
                              )
                            // : Image.file(selectedImage!),
                            : Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                                width: 160,
                                height: 160,
                              ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        TextButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0x00000000))),
                          // onPressed:
                          // uploadImage,
                          onPressed: () async {
                            if(selectedImage != null){
                              setState(() {
                                check = true;
                              });
                              String? animalName = await uploadImage();
                              second_Image = selectedImage;
                              selectedImage = null;
                              // animal_data = await extractData(animalName!);
                              check = false;
                              setState(() {
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Detection_Result_Screen(
                                  name: animalName!,
                                  result_image: second_Image,
                                ),
                              ));
                            }
                            else{
                              Fluttertoast.showToast(msg: "Please select and Image");
                            }
                          },

                          //selectedImage = null,
                          icon: Icon(
                            Icons.upload_file,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Upload",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Colors.white, width: 2)),
                              elevation: 5,
                              color: Color(0x00000000),
                              child: MaterialButton(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                onPressed: () {
                                  pickImage(ImageSource.camera);
                                },
                                child: Column(
                                  children: [
                                    ImageIcon(
                                      AssetImage(
                                          'assets/images/camer_icon.png'),
                                      size: MediaQuery.of(context).size.width *
                                          0.125,
                                    ),
                                    Text(
                                      " Camera",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Colors.white, width: 2)),
                              elevation: 5,
                              color: Color(0x00000000),
                              child: MaterialButton(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                onPressed: () async {
                                  pickImage(ImageSource.gallery);
                                },
                                child: Column(
                                  children: [
                                    ImageIcon(
                                      AssetImage(
                                          'assets/images/galler_icon.png'),
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width *
                                          0.1,
                                    ),
                                    Text(
                                      " Gallery",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  //}
}

// Material(
// elevation: 5,
// borderRadius: BorderRadius.circular(10),
// color: Colors.black.withOpacity(0.05),
// child: MaterialButton(
// padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
// onPressed: () {
// pickImage(ImageSource.gallery);
// },
// child: Text(
// " Upload",
// textAlign: TextAlign.center,
// style: const TextStyle(
// fontSize: 20,
// color: Colors.white,
// fontWeight: FontWeight.normal),
// ),
// ),
// ),


// to see the lat lng = https://petaffixapp.herokuapp.com/getlatlng
// to update lat lng = https://petaffixapp.herokuapp.com/updatelocation
// body:{
// "lat":"32323",
// "lng":"432434"},
//
//
// data type of lat lng will be string,
//
//     example
//
// var res = await http
//     .post(Uri.parse("https://petaffixapp.herokuapp.com/updatelocation"),
// headers: <String, String>{
// 'Context-Type': 'application/json;charSet=UTF-8'
// }, body: <String, String>{
// "lat": "13234",
// "lng": "3323",
// });
