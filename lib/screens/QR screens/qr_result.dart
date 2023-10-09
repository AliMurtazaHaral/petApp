import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';

import '../../widgets/loading_screen.dart';


class Result_QR extends StatefulWidget {
  String animal_id;
  Result_QR({Key? key , required this.animal_id}) : super(key: key);



  @override
  State<Result_QR> createState() => _Result_QRState();
}

class _Result_QRState extends State<Result_QR> {
  bool isplayed = false;
  final player = AudioPlayer();
  @override


  Future<String> getFile(String s) async {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan[800],
        title: Text("QR Result"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users")
                .doc("LQ0PFtnsaxXU1c4tY0ZM")
                .collection("qr_details")
                .where('animal_id', isEqualTo: widget.animal_id )
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              // List<Widget> Data = [];
              // var image_2;
              if(streamSnapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              final qr_data = streamSnapshot.data?.docs;
              return qr_data?.length != 0 ?
              Column(children: [
                FutureBuilder<List<String>>(future: Future.wait([
                  getFile("qrdetails/${qr_data![0]["animal_image"]}"),
                  getFile("qrdetails/${qr_data![0]["animal_sound"]}")
                ])
                    ,builder: (_, imageSnapshot){
                      if(!imageSnapshot.hasData){
                        return Loading_Page();
                      }
                      else{
                        String? imageURL = imageSnapshot.data![0];
                        String? soundurl = imageSnapshot.data![1];
                        player.setUrl(soundurl);
                        player.setLoopMode(LoopMode.one);
                        //String? soundURL = imageSnapshot.data![1];
                        return imageURL != null ?
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(imageURL),
                                        fit: BoxFit.fill
                                    ),
                                  ),
                                ),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(onPressed: (){
                                        player.play();
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
                                        player.stop();
                                      },
                                        iconSize: 40,
                                        icon: Icon(
                                            Icons.pause_circle_filled
                                        ),
                                        color: Colors.teal[800],),
                                    ],
                                  ),
                                  Texts("Name", qr_data![0]["animal_name"]),
                                  Texts("Habitat", qr_data![0]["animal_habitat"]),
                                  Texts("Fact", qr_data![0]["animal_fact"])

                                ],
                              ),
                            ],
                          ),
                        )
                            :  Loading_Page();
                      }
    })
              ])
                  : Loading_Page();
            }),
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
                fontSize: 20,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: '${key}: ', style: TextStyle(fontWeight: FontWeight.bold)),
                key == "Fact"?
                TextSpan(
                  text: '\n  ${value}'.replaceAll(".", ".\n"),
                ):
                TextSpan(
                  text: '${value}',
                )
              ])),
    );
  }
}

// class QR_Result_Screen extends StatelessWidget {
//   bool isplayed = false;
//   Future<String> getFile(String s) async {
//     final ref = FirebaseStorage.instance.ref().child(s);
//     String abc = "abc";
//     try {
//       abc = await ref.getDownloadURL();
//       print(abc);
//       return abc;
//     } catch (e) {
//       print(e);
//       return "null";
//     }
//   }
//   String? animal_id_from_qr;
//   final player = AudioPlayer();
//   QR_Result_Screen({
//     required this.animal_id_from_qr
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     //Fluttertoast.showToast(msg: animal_id_from_qr);
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance.collection("users")
//             .doc("LQ0PFtnsaxXU1c4tY0ZM")
//             .collection("qr_details")
//             .where('animal_id', isEqualTo: animal_id_from_qr )
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//           // List<Widget> Data = [];
//           // var image_2;
//           if(streamSnapshot.connectionState == ConnectionState.waiting){
//             return Center(child: CircularProgressIndicator());
//           }
//           final animal_data = streamSnapshot.data?.docs;
//           return animal_data?.length != 0
//               ? Column(children: [
//             FutureBuilder<List<String>>(future: Future.wait([
//               getFile("qrdetails/${animal_data![0]["animal_image"]}"),
//               getFile("qrdetails/${animal_data![0]["animal_sound"]}")
//             ])
//                 ,builder: (_, imageSnapshot){
//                   if(!imageSnapshot.hasData){
//                     return Loading_Page();
//                   }
//                   String? imageURL = imageSnapshot.data![0];
//                   String? soundurl = imageSnapshot.data![1];
//                   player.setUrl(soundurl);
//                   //String? soundURL = imageSnapshot.data![1];
//                   return imageURL != null
//                       ? Container(
//                     child:Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(height: 20,),
//                           Container(
//                             width: 200,
//                             height: 200,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               image: DecorationImage(
//                                   image: NetworkImage(imageURL),
//                                   fit: BoxFit.fill
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20,),
//                           CupertinoButton(
//                             color: Colors.teal[800],
//                             child:
//                             const Text("Play" ,
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold
//                               ),),
//                             onPressed: () async {
//                               player.setSpeed(2.0);
//                               player.play();
//                             },
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           CupertinoButton(
//                             color: Colors.teal[800],
//                             child: const Text("Pause" ,
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold
//                               ),),
//                             onPressed: () async {
//
//                               player.pause();
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                       :  Loading_Page();
//                 })
//           ])
//               : Column();
//         });
//   }
// }



// IconButton(
// iconSize: 40,
// color: Colors.teal[800],
// icon:
// isplayed? Icon(
// Icons.play_circle_fill
// ):
// Icon(
// Icons.pause_circle_filled
// ),
// onPressed: (){
// isplayed = !isplayed;
//
// },
//
// ),

