import 'package:flutter/material.dart';
import 'package:fyp/screens/registration_screen.dart';


class GetStartedPage extends StatefulWidget{
  const GetStartedPage({Key? key}): super(key: key);

  @override
  _GetStartedPageState createState() => _GetStartedPageState();

}
class _GetStartedPageState extends State<GetStartedPage> {

  @override


  Widget build(BuildContext context){
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg4.jpeg"),
            // opacity: 0.8,
            fit: BoxFit.cover,
          ),
        ),

        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Container(

                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(('assets/images/LOGO_REDLINE.png') ,
                            color: Colors.blueGrey[100],
                            width: 500,
                            height: 120,
                          ),

                          Text(
                            "Welcome to",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey[100],
                              fontStyle: FontStyle.italic,
                              height: 2,
                              //  fontWeight: FontWeight.bold
                            ),
                          ),
                          Container(
                            child:  Center(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "RED LINE ANIMALIA",
                                  textAlign: TextAlign.center,

                                  style: TextStyle(
                                    color: Colors.blueGrey[100],
                                    fontSize: 35,
                                    height: 1.25,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),


                          Container(
                            alignment: Alignment.bottomCenter,
                            height: 294,
                            width: double.infinity,

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                Align(
                                  alignment: Alignment.bottomCenter,

                                  child: ElevatedButton(
                                    onPressed:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistrationScreen()));
                                    },

                                    style: ElevatedButton.styleFrom(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                        ),


                                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                        backgroundColor: Colors.blueGrey[200],
                                        shadowColor: Colors.teal,
                                        side: BorderSide(color: Colors.teal, width: 2),
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)

                                    ),
                                    child: Text(
                                      "Get Started >",
                                      style: TextStyle(
                                        color: Colors.teal[800],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            child:  Center(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "-INTO THE WILD-",
                                  textAlign: TextAlign.center,

                                  style: TextStyle(
                                    color: Colors.blueGrey[100],
                                    fontSize: 12,
                                    height: 2.5,
                                    //  wordSpacing: 5,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),




                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        )
    );
  }
}