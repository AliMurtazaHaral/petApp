import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/models/ReportingModel.dart';
import 'package:fyp/models/storage.dart';
import 'package:fyp/widgets/loading_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'add_animals.dart';

class Reporting_Screen extends StatefulWidget {
  const Reporting_Screen({Key? key}) : super(key: key);

  @override
  State<Reporting_Screen> createState() => _Reporting_ScreenState();
}

class _Reporting_ScreenState extends State<Reporting_Screen> {

  final description_controller = TextEditingController();
  String? lat;
  String? lng;
  String? image;
  File? selected_image;
  bool check = false;
  LatLng? currentPostion;

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(locationSettings: AndroidSettings(
      accuracy: LocationAccuracy.high
    ));

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
      lat = position.latitude.toString();
      lng = position.longitude.toString();
    });
  }
  postReporttoFirebase() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    ReportingModel add_report = ReportingModel();
    
    add_report.description = description_controller.text;
    add_report.image = selected_image!.path.split("/").last;
    add_report.lat = lat;
    add_report.lng = lng;
    await firebaseFirestore
        .collection("users")
        .doc("LQ0PFtnsaxXU1c4tY0ZM")
        .collection("reports")
        .doc()
        .set(add_report.toMapReportDetails());
  }

  @override
  Widget build(BuildContext context) =>
    check?  Loading_Page(): Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade800,
        title: Text(
            "Report Activity"
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Text("Description:" ,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800]
                ),
              ),
              SizedBox(height: 5,),
              EnterText.textfield(context, description_controller, "Description", 4),
              SizedBox(height: 30,),
              selected_image == null ? Text("Add Image:" ,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800]
                ),
              ):Image.file(
                selected_image!,
                fit: BoxFit.cover,
                width: 160,
                height: 160,
              ),
              SizedBox(height: 20,),
              TextButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.teal[800])),
                // onPressed:
                // uploadImage,
                onPressed: () async {

                  final pickedImage =
                  await ImagePicker().getImage(source: ImageSource.camera, imageQuality: 85);
                  selected_image = File(pickedImage!.path);
                  setState(() {});
                },

                //selectedImage = null,
                icon: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
                label: Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 40,),
              TextButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.teal[800])),
                // onPressed:
                // uploadImage,
                onPressed: () async {
                  if(description_controller.text.isEmpty || selected_image == null){
                    Fluttertoast.showToast(msg: "Please enter all data");
                  }
                  else{
                    setState(() {
                      check = true;
                    });
                    _getUserLocation();
                    Fluttertoast.showToast(msg: lat);
                    StorageModel report = StorageModel();
                    await report.uploadFile(selected_image!.path, selected_image!.path.split("/").last , "reports");
                    await postReporttoFirebase();
                    selected_image = null;
                    description_controller.text = "";
                    setState(() {
                      check = false;
                    });
                  }
                },

                //selectedImage = null,
                icon: Icon(
                  Icons.upload_file,
                  color: Colors.white,
                ),
                label: Text(
                  "Submit Report",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );

}
