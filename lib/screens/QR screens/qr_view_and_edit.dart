import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class QR_edit_delete_Screen extends StatefulWidget {
  String id;
  String image;
  String animal_Name;
  String habitat;
  AudioPlayer sound;
  String fact;

  QR_edit_delete_Screen({Key? key , required this.id , required this.fact
    ,required this.image , required this.animal_Name , required this.habitat , required this.sound
  }) : super(key: key);

  @override
  State<QR_edit_delete_Screen> createState() => _QR_edit_delete_ScreenState();
}

class _QR_edit_delete_ScreenState extends State<QR_edit_delete_Screen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
      AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            widget.sound.pause();
          },
        ),
        title: Text("QR details"),
        backgroundColor: Colors.teal.shade800,
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: FittedBox(
              child: Image.network(
                widget.image.toString(),
                height: 150,
              ),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: (){
                widget.sound.play();
              },
                iconSize: 40,
                icon: Icon(
                    Icons.play_circle_fill
                ),
                color: Colors.teal[800],),
              SizedBox(
                width: 20,
              ),
              IconButton(onPressed: (){
                widget.sound.pause();
              },
                iconSize: 40,
                icon: Icon(
                    Icons.pause_circle_filled
                ),
                color: Colors.teal[800],),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Texts("Habitat", widget.habitat),
          SizedBox(
            height: 10,
          ),
          Texts("Fact: ", widget.fact),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                  color: Colors.teal[800],
                  onPressed: () async{
                    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                    await firebaseFirestore
                        .collection("users")
                        .doc("LQ0PFtnsaxXU1c4tY0ZM")
                        .collection("qr_details")
                        .doc(widget.id).delete();
                    Navigator.pop(context);
                  },


                  child: Text(
                    "Delete",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),

                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          )

        ],
      ),
    );
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
}
