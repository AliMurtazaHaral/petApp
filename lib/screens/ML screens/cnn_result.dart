import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/models/UserModel.dart';
import 'package:fyp/models/storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Detection_Result_Screen extends StatelessWidget {
  File? result_image;
  late String name, kingdom, classss, order, specie;

  Detection_Result_Screen(
      {required this.name,
      required this.result_image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            //source + query
              stream: FirebaseFirestore.instance.collection("users")
              .doc("LQ0PFtnsaxXU1c4tY0ZM")
              .collection("Animals")
              .where('name', isEqualTo: name )
              .snapshots(),
              builder: (context,snapshot) {
                print(snapshot.data);
                print(snapshot.connectionState);
                switch(snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                  //    return Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    if(snapshot.hasError) {
                      return Container(
                        height: 50,
                        width: 50,
                        child:Text('No data found',style: TextStyle(
                            fontSize: 30
                        ),),
                      );
                    }
                    if(snapshot.hasData == false) {
                      return Container(
                        height: 50,
                        width: 50,
                        child:Text('No data found',style: TextStyle(
                            fontSize: 30
                        ),),
                      );
                    }
                    final data = snapshot.data!.docs;
                    final row = data[0].data() as Map<String, dynamic>;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            child: Image.file(
                              result_image!,
                              height: 150,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Texts("Name", row["name"]),
                        Texts("Kingdom", row["kingdom"]),
                        Texts("Class", row["classss"]),
                        Texts("Order", row["order"]),
                        Texts("Specie", row["specie"]),
                        Texts("Fact", row["fact"]),
                        TextButton.icon(
                            onPressed: () async {
//print(result_image!.path.split("/").last);
                              StorageModel animal_data = StorageModel();
                              animal_data.uploadFile(result_image!.path, result_image!.path.split("/").last, "");
                              UserModel user = UserModel();
                              user.animal_name = row["name"];
                              user.animal_image = result_image!.path.split("/").last;
                              user.animal_kingdom = row["kingdom"];
                              user.animal_class = row["classss"];
                              user.animal_order = row["order"];
                              user.animal_species = row["specie"];
                              FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                              final _auth = FirebaseAuth.instance;
                              User? loggedin_user = _auth.currentUser;
                              await firebaseFirestore.
                              collection("users").doc("LQ0PFtnsaxXU1c4tY0ZM").
                              collection("Visitor").doc(loggedin_user!.uid).
                              collection("animals").doc().set(user.toMapAnimalDetails());
                              Fluttertoast.showToast(msg: "Animal Saved");
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.save_alt,
                              color: Colors.teal[800],
                            ),
                            label: Text(
                              "Save",
                              style: TextStyle(color: Colors.teal[800]),
                            ))
                      ],
                    );
                    break;
                }
              }
          ),
        ),
      ),
    );
  }
}

Widget Texts(key, value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: RichText(
      maxLines: 5,
        text: TextSpan(
            style: TextStyle(
              color: Colors.cyan[800],
            ),
            children: <TextSpan>[
          TextSpan(
              text: '${key}: ', style: TextStyle(fontWeight: FontWeight.bold)),
              key == "Fact"?
          TextSpan(
            text: '${value}'.replaceAll(".", ".\n"),
          ):
              TextSpan(
                text: '${value}',
              )
        ])),
  );
}


// Column(
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
// SizedBox(
// height: 40,
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: FittedBox(
// child: Image.file(
// result_image!,
// height: 150,
// ),
// fit: BoxFit.fill,
// ),
// ),
// Texts("Name", name),
// Texts("Kingdom", kingdom),
// Texts("Class", classss),
// Texts("Order", order),
// Texts("Specie", specie),
// TextButton.icon(
// onPressed: () async {
// //print(result_image!.path.split("/").last);
// StorageModel animal_data = StorageModel();
// animal_data.uploadFileImage(result_image!.path, result_image!.path.split("/").last);
// UserModel user = UserModel();
// user.animal_name = name;
// user.animal_image = result_image!.path.split("/").last;
// user.animal_kingdom = kingdom;
// user.animal_class = classss;
// user.animal_order = order;
// user.animal_species = specie;
// FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
// final _auth = FirebaseAuth.instance;
// User? loggedin_user = _auth.currentUser;
// await firebaseFirestore.
// collection("users").doc("LQ0PFtnsaxXU1c4tY0ZM").
// collection("Visitor").doc(loggedin_user!.uid).
// collection("animals").doc().set(user.toMapAnimalDetails());
// Fluttertoast.showToast(msg: "Animal Saved");
// Navigator.pop(context);
// },
// icon: Icon(
// Icons.save_alt,
// color: Colors.teal[800],
// ),
// label: Text(
// "Save",
// style: TextStyle(color: Colors.teal[800]),
// ))
// ],
// ),