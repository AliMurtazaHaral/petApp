import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/UserModel.dart';
import '../widgets/img.dart';
import '../widgets/my_colors.dart';
import '../widgets/my_strings.dart';
import '../widgets/my_text.dart';

class ProfileScreen extends StatefulWidget {

  ProfileScreen();

  @override
  ProfileScreenState createState() => new ProfileScreenState();
}


class ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc("LQ0PFtnsaxXU1c4tY0ZM")
        .collection("Visitor")
        .doc(user!.uid).get()
        .then((value) {
      loggedInUser = UserModel.fromMapRegsitration(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        title: Text(
          "Profile"
        ),
      ),

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
           child: Column(
             children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Email:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan[900]
                  ),),
                ),
               TextFormField(
                 enabled: false,
                 style: TextStyle(
                   color: Colors.cyan[900]
                 ),
                 keyboardType: TextInputType.emailAddress,
                 //Text field data is stored in emailController
                 decoration: InputDecoration(
                   hintText: loggedInUser.email.toString(),
                   hintStyle: TextStyle(color: Colors.cyan[900]),
                   enabledBorder: UnderlineInputBorder(
                     borderSide: BorderSide(color: Colors.cyan, width: 1),
                   ),
                   focusedBorder: UnderlineInputBorder(
                     borderSide: BorderSide(color: Colors.cyan, width: 2),
                   ),
                 ),
               ),
               Align(
                 alignment: Alignment.centerLeft,
                 child: Text("Username:",
                   style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                       color: Colors.cyan[900]
                   ),),
               ),
               TextFormField(
                 style: TextStyle(
                     color: Colors.cyan[900]
                 ),
                 keyboardType: TextInputType.text,
                 //Text field data is stored in emailController
                 controller: usernameController,
                 validator: (value) {
                   if (value!.isEmpty) {
                     return ("Enter Valid Email");
                   }
                 },
                 onSaved: (value) {
                   usernameController.text = value!;
                 },
                 decoration: InputDecoration(
                   hintText: loggedInUser.username.toString(),
                   hintStyle: TextStyle(color: Colors.cyan[900]),
                   enabledBorder: UnderlineInputBorder(
                     borderSide: BorderSide(color: Colors.cyan, width: 1),
                   ),
                   focusedBorder: UnderlineInputBorder(
                     borderSide: BorderSide(color: Colors.cyan, width: 2),
                   ),
                 ),
               ),
               SizedBox(
                 height: MediaQuery.of(context).size.height * 0.02,
               ),
               Align(
                 alignment: Alignment.centerLeft,
                 child: Text("Password:",
                   style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                       color: Colors.cyan[900]
                   ),),
               ),
               TextFormField(
                 style: TextStyle(
                     color: Colors.cyan[900]
                 ),
                 keyboardType: TextInputType.text,
                 //Text field data is stored in emailController
                 controller: passwordController,
                 validator: (value) {
                   if (value!.isEmpty) {
                     return ("Enter Valid Email");
                   }
                 },
                 onSaved: (value) {
                   passwordController.text = value!;
                 },
                 decoration: InputDecoration(
                   hintText: loggedInUser.password.toString(),
                   hintStyle: TextStyle(color: Colors.cyan[900]),
                   enabledBorder: UnderlineInputBorder(
                     borderSide: BorderSide(color: Colors.cyan, width: 1),
                   ),
                   focusedBorder: UnderlineInputBorder(
                     borderSide: BorderSide(color: Colors.cyan, width: 2),
                   ),
                 ),
               ),
               SizedBox(
                 height: MediaQuery.of(context).size.height * 0.05,
               ),
               MaterialButton(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(8.0)
                 ),
                 padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
                 minWidth: MediaQuery.of(context).size.width * 0.3,
                 color: Colors.cyan[900],
                 onPressed: (){
                    if(passwordController.text.isEmpty || usernameController.text.isEmpty){
                      Fluttertoast.showToast(msg: "PLease fill all  credentials");
                    }
                    else{
                      updateDetailsToFirestore();
                    }
                 },
                 child: Text(
                   "UPDATE",
                   textAlign: TextAlign.center,
                   style: const TextStyle(
                       fontSize: 20,
                       color: Colors.white,
                       fontWeight: FontWeight.bold),
                 ),
               )
             ],
           ),

          ),
        ),

    );
  }
  updateDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    // writing all the values
    userModel.password = passwordController.text;
    userModel.username = usernameController.text;

    await firebaseFirestore
        .collection("users")
        .doc("LQ0PFtnsaxXU1c4tY0ZM").collection("Visitor").doc(user!.uid)
        .update(userModel.toMapUpdateDetails());
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Update Successful");
  }
}

