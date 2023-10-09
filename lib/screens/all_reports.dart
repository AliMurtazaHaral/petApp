import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/registration_screen.dart';
import 'package:fyp/screens/viewe_full_report.dart';
import 'package:fyp/widgets/loading_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class Reports_Screen extends StatefulWidget {
  const Reports_Screen({Key? key}) : super(key: key);

  @override
  State<Reports_Screen> createState() => _Reports_ScreenState();
}

class _Reports_ScreenState extends State<Reports_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: Colors.cyan[800],
        title: Text("All Reports"),
      ),
      body: SingleChildScrollView(
        child: Reports_Data_Stream(),
      ),
    );
  }
}

class Reports_Data_Stream extends StatefulWidget {
  const Reports_Data_Stream({Key? key}) : super(key: key);

  @override
  State<Reports_Data_Stream> createState() => _Reports_Data_StreamState();
}

class _Reports_Data_StreamState extends State<Reports_Data_Stream> {

  Future<String?> _getAddressFromLatLng(Position position , String latitude , String longitude) async {
    String? currentAddress = "Coulnt fetch address";
    await placemarkFromCoordinates(
        double.parse(latitude), double.parse(longitude))
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress =
      '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    }).catchError((e) {
      debugPrint(e);
    });
    return currentAddress;
  }

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
            .collection("reports")
            .snapshots(),
        builder: (context , AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          final report_data = streamSnapshot.data?.docs;
          return report_data?.length !=0 ?
              Column(
                children: [
                  for(var data in report_data!)
                    FutureBuilder<String>
                      ( future: getFile("reports/${data["image"]}"),
                        builder:( _, imageSnapshot){
                          String? imgUrl = imageSnapshot.data;
                          return imgUrl!=null?
                          kCard(
                            context,
                            data.id,
                            data["description"],
                            imgUrl,
                            data["lat"],
                            data["lng"],
                          ):
                              Loading_Page();
                        })
                ],
              ):
              Loading_Page();
        });
  }
}

Widget kCard(
    BuildContext context,
    String id,
    String description,
    String imageurl,
    String latitude,
    String longitude,
    ){
  return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width*0.9,
        onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => View_Full_Report(id: id, description: description, imageurl: imageurl, lat: latitude, lng: longitude)
                    ),);
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
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(imageurl.toString()),
                ),
                ),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.03,
                ),
                // Text(
                //   address,
                //   style: TextStyle(
                //       color: Colors.cyan[800],
                //       fontWeight: FontWeight.bold,
                //       fontSize: 20),)
              ],
            ),
          ),
  ),
      ),
  );
}

