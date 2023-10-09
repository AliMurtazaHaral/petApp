import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/screens/management_dashboard.dart';
import 'package:fyp/screens/registration_screen.dart';
import 'package:fyp/screens/reset_password.dart';
import 'package:fyp/widgets/img.dart';
import 'package:fyp/widgets/my_text.dart';
import 'package:fyp/screens/dashboard.dart';
import '../models/UserModel.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();

  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String _dropDownValue = 'Visitor';
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.teal[800],
      appBar:
          PreferredSize(child: Container(), preferredSize: Size.fromHeight(0)),
      body: Stack(
        children: <Widget>[
          Container(
              child: Image.asset(Img.get('bg4.jpeg'),
                  fit: BoxFit.fill),
              height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,),


          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(Img.get('LOGO_REDLINE.png'),
                      color: Colors.white,),
                    Text("REDLINE ANIMALIA",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Log in",
                        style: MyText.medium(context).copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      //Text field data is stored in emailController
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Enter Valid Email");
                        }
                      },
                      onSaved: (value) {
                        emailController.text = value!;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.blueGrey[100],
                        focusedBorder: OutlineInputBorder(

                          borderSide: BorderSide(color: Colors.white , width: 2),
                          borderRadius: BorderRadius.circular(10 ),
                        ),
                        filled: false,
                        hintText: "Email",
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white , width: 1),
                          borderRadius: BorderRadius.circular(10 ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Enter Valid Password");
                        }
                      },
                      onSaved: (value) {
                        passwordController.text = value!;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.blueGrey[100],
                        focusedBorder: OutlineInputBorder(

                          borderSide: BorderSide(color: Colors.white , width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: false,
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(10 ),

                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButton(
                      dropdownColor: Colors.teal[800],
                      hint: _dropDownValue == 'Visitor'
                          ? Text(
                              'Visitor',
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              _dropDownValue,
                              style: TextStyle(color: Colors.white),
                            ),
                      isExpanded: true,
                      iconSize: 40.0,
                      style: TextStyle(color: Colors.white),
                      items: ['Visitor', 'Management'].map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            _dropDownValue = val.toString();
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.transparent,
                        ),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPasswordScreen()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),

                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.white)),
                      elevation: 5,
                      color: Color(0x00000000),
                      child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
                          minWidth: MediaQuery.of(context).size.width * 0.3,
                          onPressed: () {
                            if (_dropDownValue == "Visitor") {
                              setState(() {
                                check=true;
                              });
                              signInVisitor(
                                  emailController.text, passwordController.text);
                            }
                            else{
                              setState(() {
                                check=true;
                              });
                              signInManagementBoard(
                                  emailController.text, passwordController.text);

                            }

                          },


                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),

                      ),

                    ),
                    Center(
                      child: check?CircularProgressIndicator():SizedBox(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.transparent,
                        ),
                        child: Text(
                          "Sign up for an account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void signInVisitor(String email, String password) async {
    if(_dropDownValue == "Visitor"){
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
        Fluttertoast.showToast(msg: "Login Successful"),
        emailController.text="",
        passwordController.text="",
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DashboardScreen())),
      })
          .catchError((e) {
        Fluttertoast.showToast(msg: "Login is not successful");
      });
    }
    else{
      Fluttertoast.showToast(msg: "The user is not Management Board");
    }
    setState(() {
      check = false;
    });
  }

  void signInManagementBoard(String email, String password) async {
    if(_dropDownValue == "Management"){
      var documents = await FirebaseFirestore.instance.collection('users')
          .doc('LQ0PFtnsaxXU1c4tY0ZM')
          .collection('Management')
          .doc("MPWd3ddd77KMoouB8JBf").get();
      String email_checker = documents['email'];
      String pass_checker = documents['password'];
      if(email == email_checker && password == pass_checker){
        Fluttertoast.showToast(msg: "Login Successful");
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => Management_Dashboard_Screen()));
      }
      else{
        Fluttertoast.showToast(msg: "Email or password doesnot match");
      }
      // await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(email: email, password: password)
      //     .then((uid) => {
      //   Fluttertoast.showToast(msg: "Login Successful")
      //   Navigator.push(context,
      //       MaterialPageRoute(
      //           builder: (context) => TrackingPage()))
      // })
      //     .catchError((e) {
      //   Fluttertoast.showToast(msg: "Login is not successful");
      //
      // });
    }
    else{
      Fluttertoast.showToast(msg: "User is not a Visitor");
    }
    setState(() {
      check = false;
    });
  }
}



