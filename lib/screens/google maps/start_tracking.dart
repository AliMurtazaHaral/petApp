import 'package:flutter/material.dart';
import 'package:fyp/screens/management_map.dart';


class TrackingPage extends StatefulWidget{
  const TrackingPage({Key? key}): super(key: key);

  @override
  _TrackingPageState createState() => _TrackingPageState();

}
class _TrackingPageState extends State<TrackingPage> {

  @override


  Widget build(BuildContext context){
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/gradient.jpg"),
            opacity: 1,
            fit: BoxFit.cover,
          ),
        ),

        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(''),
            backgroundColor: Colors.teal[800],
          ),
          // backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Container(
                child:  Center(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Let's Start",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.teal[800],
                        fontSize: 30,
                        height: 3,
                        decorationThickness: 50,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child:  Center(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Your Tracking",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.teal[800],
                        fontSize: 15,
                        height: 9,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),

              Container(

                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(('assets/images/a.png'),
                          alignment: Alignment.topCenter,
                          color: Colors.teal[800],
                          width: 155,
                          height: 250,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Container(
                child:  Center(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Wohoo!",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.teal[800],
                        fontSize: 15,
                        height: 36,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child:  Center(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Tracking made easy for you",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.teal[800],
                        fontSize: 15,
                        height: 37.5,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: 520,
                width: double.infinity,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Align(
                      alignment: Alignment.bottomCenter,

                      child: ElevatedButton(
                        onPressed:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => History_Playback_Screen()));
                        },

                        style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),


                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                            backgroundColor: Colors.cyan[50],
                            shadowColor: Colors.teal,
                            side: BorderSide(color: Colors.teal, width: 3),
                            textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold)

                        ),
                        child: Text(
                          "Track ",
                          style: TextStyle(
                            color: Colors.teal[800],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}