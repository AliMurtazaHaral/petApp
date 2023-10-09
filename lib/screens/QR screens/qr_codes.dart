import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fyp/models/AnimalModel.dart';
import 'package:fyp/screens/QR%20screens/qr_view_and_edit.dart';
import 'package:just_audio/just_audio.dart';
import '../../widgets/loading_screen.dart';

class QR_codes_collection extends StatefulWidget {
  const QR_codes_collection({Key? key}) : super(key: key);

  @override
  State<QR_codes_collection> createState() => _QR_codes_collectionState();
}

class _QR_codes_collectionState extends State<QR_codes_collection> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: Colors.cyan[800],
        title: Text("All QR Data"),
      ),
      body: SingleChildScrollView(
        child: QR_Data_Stream(),
      ),
    );
  }
}

class QR_Data_Stream extends StatefulWidget {
  const QR_Data_Stream({Key? key}) : super(key: key);

  @override
  State<QR_Data_Stream> createState() => _QR_Data_StreamState();
}

class _QR_Data_StreamState extends State<QR_Data_Stream> {
  AudioPlayer player = AudioPlayer();
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
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc("LQ0PFtnsaxXU1c4tY0ZM")
          .collection("qr_details")
          .snapshots(),
        builder: (context , AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          final qr_data = streamSnapshot.data?.docs;
          return qr_data?.length !=0 ?
              Column(
                children: [
                  for(var qr in qr_data!)
          FutureBuilder<List<String>>(future: Future.wait([
            getFile("qrdetails/${qr!["animal_image"]}"),
            getFile("qrdetails/${qr!["animal_sound"]}")
          ])
              ,builder: (_ , imageSnapshot){
                if(!imageSnapshot.hasData){
                  return Loading_Page();
                }
                String? imageURL = imageSnapshot.data![0];
                String? soundurl = imageSnapshot.data![1];
                player.setUrl(soundurl);
                player.setLoopMode(LoopMode.one);
                return soundurl != null?
                    Column(
                      children: [
                        kCard(context,qr.id  ,imageURL, qr["animal_name"] , qr["animal_habitat"]
                            , player , qr["animal_fact"])
                      ],
                    ):
                    Loading_Page();
              }
          )


                ],
              ):
          Column(
            children: [
              Text("No QR codes to show")
          ],
          );
        }
    );
  }
}

Widget kCard(
    BuildContext context,
    String id,
    String image,
    String animal_Name,
    String habitat,
    AudioPlayer sound,
    String fact) {

  return Padding(
    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
    child: MaterialButton(
      minWidth: MediaQuery
          .of(context)
          .size
          .width * 0.9,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => QR_edit_delete_Screen(
              id: id, image: image, animal_Name: animal_Name, habitat: habitat,fact: fact,
              sound: sound,
                ),
          ),
        );
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.03,
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
