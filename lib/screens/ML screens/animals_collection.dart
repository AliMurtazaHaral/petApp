import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/widgets/img.dart';
import 'package:fyp/widgets/loading_screen.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../../models/UserModel.dart';

class AnimalCollectionScreen extends StatefulWidget {
  AnimalCollectionScreen();

  @override
  AnimalCollectionScreenState createState() => AnimalCollectionScreenState();
}

class AnimalCollectionScreenState extends State<AnimalCollectionScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late final Stream<QuerySnapshot<Map<String, dynamic>>> all_animals;
  bool check = false;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    all_animals = FirebaseFirestore.instance
        .collection("users")
        .doc("LQ0PFtnsaxXU1c4tY0ZM")
        .collection("Visitor")
        .doc(user!.uid)
        .collection("animals")
        .snapshots();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan[800],
        title: Text("Animals Collection"),
      ),
      body: SingleChildScrollView(
        child: Animal_Data_Stream(),
      ),
    );
  }
}

class Animal_Data_Stream extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  var url;

  Future<String> getImg(String s) async {
    final ref = FirebaseStorage.instance.ref().child(s);
    String abc = "abc";
    try {
      abc = await ref.getDownloadURL();
      print(abc);
      return abc;
    } catch (e) {
      print(e);
      return "null";
    }
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc("LQ0PFtnsaxXU1c4tY0ZM")
            .collection("Visitor")
            .doc(user!.uid)
            .collection("animals")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          // List<Widget> Data = [];
          // var image_2;
          if(streamSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          final animal_data = streamSnapshot.data?.docs;
          // for(var data in animal_data!){
          //   final image = getImg(data["animal_image"]);
          //   image_2 = image;
          //   final name = data["animal_name"];
          //   final kingdom = data["animal_kingdom"];
          //   final classs = data["animal_class"];
          //   final order = data["animal_order"];
          //   final specie = data["animal_species"];
          //   Data.add(kCard(context, image, name, kingdom, classs, order, specie));
          //  }
          return animal_data?.length != 0
              ? Column(children: [
                  for (var data in animal_data!)
                    FutureBuilder<String>(future: getImg(data["animal_image"])
                        ,builder: (_, imageSnapshot){
                      String? imageURL = imageSnapshot.data;
                      return imageURL != null
                          ? kCard(
                          context,
                          imageURL,
                          data["animal_name"],
                          data["animal_kingdom"],
                          data["animal_class"],
                          data["animal_order"],
                          data["animal_species"]):
                      const SizedBox.shrink();
                        })
                ])
              : Column();
        });
  }
}

Widget kCard(
    BuildContext context,
    String image,
    String animal_Name,
    String animal_kingdom,
    String animal_class,
    String animal_order,
    String animal_specie) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
    child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width * 0.9,
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                contentPadding: EdgeInsets.all(0.0),
                backgroundColor: Colors.white,
                scrollable: true,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(image.toString()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Kingdom: ",
                            style: TextStyle(
                                color: Colors.cyan[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Text(
                          animal_kingdom,
                          style: TextStyle(color: Colors.teal[900]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Class: ",
                            style: TextStyle(
                                color: Colors.cyan[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Text(animal_class,
                            style: TextStyle(color: Colors.teal[900]))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Order: ",
                            style: TextStyle(
                                color: Colors.cyan[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Text(animal_order,
                            style: TextStyle(color: Colors.teal[900]))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Species: ",
                            style: TextStyle(
                                color: Colors.cyan[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Text(animal_specie,
                            style: TextStyle(color: Colors.teal[900]))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            });
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.cyan, width: 2)),
        elevation: 2.0,
        shadowColor: Colors.black38,
        surfaceTintColor: Colors.black,
        color: Colors.white,

        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(image.toString()),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Text(
                animal_Name.replaceAll("_", "\n"),
                maxLines: 3,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.cyan[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
