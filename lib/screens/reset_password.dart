

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/UserModel.dart';
import 'login_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with TickerProviderStateMixin {
  final emailController = TextEditingController();

  @override




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[900],
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.cyan[800], //change your color here
        ),
        title: Text(
          "Password Reset" ,
          style: TextStyle(
            color: Colors.cyan[800],
          ),
        ),
      ),
      body: Column(

        children: [
          Padding(padding: EdgeInsets.all(8.0),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,

            decoration: InputDecoration(
              fillColor: Colors.blueGrey[100],
              focusedBorder: OutlineInputBorder(

                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10 ),
              ),
              filled: false,
              hintText: "Enter you email",
              hintStyle: TextStyle(
                  color: Colors.white
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 10, color: Colors.black),
                borderRadius: BorderRadius.circular(10 ),

              ),
            ),
            onSaved: (value){

                emailController.text = value!;

            },
          ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15.0) ),
                color: Colors.white,
                  child: Text(
                    "Send Email",
                    style: TextStyle(
                      color: Colors.cyan[900]
                    ),
                  ),
                  onPressed:() async{
                    try{
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                      Navigator.pop(context);

                    }
                    on FirebaseAuthException catch (e){
                      Fluttertoast.showToast(msg: "User Doesn't exist in database");
                    }
                  },
              )
            ],
          )
        ],
      ),
    );
  }
}