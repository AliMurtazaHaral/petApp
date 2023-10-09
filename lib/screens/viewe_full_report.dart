import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/report_location.dart';
import 'package:fyp/widgets/loading_screen.dart';


class View_Full_Report extends StatefulWidget {
  String id;
  String description;
  String imageurl;
  String lat;
  String lng;
  View_Full_Report({Key? key , required this.id, required this.description, required this.imageurl
  , required this.lat, required this.lng}) : super(key: key);

  @override
  State<View_Full_Report> createState() => _View_Full_ReportState();
}

class _View_Full_ReportState extends State<View_Full_Report> {
  bool check = false;
  @override
  Widget build(BuildContext context) =>
     check? Loading_Page():Scaffold(
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
          },
        ),
        title: Text("Report detail"),
        backgroundColor: Colors.teal.shade800,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FittedBox(
                child: Image.network(
                  widget.imageurl.toString(),
                  height: 100,
                ),
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Text(widget.description , style: TextStyle(
                color: Colors.teal[800],
                fontSize: 15,
                fontStyle: FontStyle.italic
              ),),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              TextButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.teal[800])),
                // onPressed:
                // uploadImage,
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => Report_Location_Screen(
                          lat: widget.lat , lng: widget.lng,
                        )
                    ),
                  );
                }, //selectedImage = null,
                icon: Icon(
                  Icons.location_searching,
                  color: Colors.white,
                ),
                label: Text(
                  "Show Location",
                  maxLines: 8,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.010,
              ),
              TextButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.teal[800])),
                // onPressed:
                // uploadImage,
                onPressed: () async {
                  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                  await firebaseFirestore
                      .collection("users")
                      .doc("LQ0PFtnsaxXU1c4tY0ZM")
                      .collection("reports")
                      .doc(widget.id).delete();
                  Navigator.pop(context);
                }, //selectedImage = null,
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                label: Text(
                  "Delete Report",
                  maxLines: 8,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );

}
