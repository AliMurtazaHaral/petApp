import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/screens/add_animals.dart';
import 'package:fyp/screens/all_reports.dart';
import 'package:fyp/screens/google%20maps/animal_tracking.dart';
import 'package:fyp/screens/management_map.dart';
import 'package:fyp/screens/QR%20screens/qr_codes.dart';
import 'package:fyp/widgets/loading_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Management_Dashboard_Screen extends StatelessWidget {
  Management_Dashboard_Screen({Key? key}) : super(key: key);

  bool check = false;

  get_live_location() async{
    LatLng animal_location = LatLng(0.0, 0.0);
    await FirebaseFirestore.instance
        .collection('location')
        .doc("ZVs9bLumD3XVY4mETi13")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');

        animal_location =  LatLng(double.parse(documentSnapshot["lat"]), double.parse(documentSnapshot["lng"]));
        Fluttertoast.showToast(msg: animal_location.latitude.toString());
      } else {
        print('Document does not exist on the database');
        animal_location = LatLng(0.0, 0.0);
      }
    });
    return animal_location;
  }

  @override
  Widget build(BuildContext context) =>
    check == true ? Loading_Page() :Container(
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
        title: Center(child: Text("Wild Life" , style: TextStyle(
          fontFamily: 'Poppins'
        ),),),
        backgroundColor: Colors.teal[800],
      ),
      body: Center(
        child: Column(
          children: [
            Image(image: AssetImage(
              "assets/images/LOGO_REDLINE.png"
            ),
            color: Colors.teal[900],),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryButton.categoryButton(context, "assets/images/a.png", "Track", onTap: () async{
                  LatLng abc =
                  LatLng(33.748107007846485, 73.02423155745402);
                  //await get_live_location();
                  Fluttertoast.showToast(msg: abc.latitude.toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Animal_Tracking_Screen(
                              initial_position: abc,
                          )));
                }),
                CategoryButton.categoryButton(context, "assets/images/a.png", "Reports", onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Reports_Screen()));
                })
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryButton.categoryButton(context, "assets/images/a.png", "Add Animal" , onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Add_AnimalsScreen()));
                }),
                CategoryButton.categoryButton(context, "assets/images/a.png", "View QRs",onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QR_codes_collection()));
                })
              ],
            )
              ]
            )
        ),
      ),

    );

}


class CategoryButton {
  static Widget categoryButton(BuildContext context, String imagePath, String text,
      {Function? onTap}) {
    return GestureDetector(
        onTap: () => {onTap!()},
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal.shade800),
                borderRadius: BorderRadius.circular(70.0),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 60, // Image radius
                child: Image.asset(
                  imagePath,
                  color: Colors.teal[800],
                  height: 100,
                ),
              ),
            ),
            SizedBox(width: MediaQuery
                .of(context)
                .size
                .width * 0.4,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.05,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(text, maxLines: 3,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )
            ),

          ],
        ));
  }
}