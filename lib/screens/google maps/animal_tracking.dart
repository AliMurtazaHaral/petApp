import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'dart:collection';
import "dart:async";
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import '../Alert.dart';
// import 'package:quickalert/quickalert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class Animal_Tracking_Screen extends StatefulWidget{
  LatLng initial_position;
  Animal_Tracking_Screen({Key? key, required this.initial_position }): super(key: key);

  @override
  _Animal_Tracking_ScreenState createState() => _Animal_Tracking_ScreenState();

}
class _Animal_Tracking_ScreenState extends State<Animal_Tracking_Screen> {

  List<LatLng> history = [];
  late final StreamSubscription myStream;



  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
  getdate(){
    final now = new DateTime.now();
    String formatter = DateFormat('yMd').format(now);
    return formatter;
  }
  gettime(){
    final now = new DateTime.now();
    String formatter = DateFormat.jm().format(now);
    return formatter;
  }
  Future<void> marker_changer() async {
    print("Updating markers: ");
    
      // await new Future.delayed(const Duration(seconds : 5));
      bool abc = await datanotupdated(widget.initial_position.latitude.toString() , "lat");
      //Fluttertoast.showToast(msg: abc.toString());
      if(await datanotupdated(widget.initial_position.latitude.toString() , "lat") == false
          && await datanotupdated(widget.initial_position.longitude.toString(), "lng") == false) {
        Fluttertoast.showToast(msg: "Location Changed");
         get_live_location();
         await FirebaseFirestore.instance.collection("animal_history")
         .add({
           "latitude": widget.initial_position.latitude.toString(),
           "longitude": widget.initial_position.longitude.toString(),
           "date": getdate(),
           "time": gettime()
         });
        if (widget.initial_position.latitude != 0.0 ||
            widget.initial_position.longitude != 0.0) {
          setState(() {
            _markers[0] = _markers[0].copyWith(
                positionParam: LatLng(
                    widget.initial_position.latitude, widget.initial_position.longitude));
            // markers.elementAt(0) = markers.elementAt(0).copyWith(positionParam: LatLng(path_2[i].latitude, path_2[i].longitude));
            print(_markers);
            print("5 second break");
            _controller.animateCamera(
                CameraUpdate.newCameraPosition(new CameraPosition(
                    bearing: 192.83340901395799,
                    target: widget.initial_position,
                    tilt: 0,
                    zoom: 18.00
                ))
            );
          });
          _getAddress(points, widget.initial_position);
        }
      }
      else{
        Fluttertoast.showToast(msg: "Location did not change");
      }


  }


  late GoogleMapController _controller;
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.747806, 73.005352),
    zoom: 14,
  );

  final Set<Polygon> _polygone = HashSet<Polygon>();
  final Set<Circle> _circle = HashSet<Circle>();

  final List<Marker> _markers = [];
  // Set<Marker> markers = {};
  late Set<Polyline> _polyline = {};

  List<InfoWindow> infoWindowArr =
  [
    InfoWindow(title: "Muntjac",
        snippet: "WildLife Animal"),

];

  List<LatLng> points = [
    LatLng(33.75829333059816, 73.0060121562299),
    LatLng(33.75829333059816, 73.00699783597707),
    LatLng(33.75829333059816, 73.00789390847451),
    LatLng(33.75829333059816, 73.00941723172015),
    LatLng(33.758367829063275, 73.00905880272119),
    LatLng(33.758665822276285, 73.01076134046632),
    LatLng(33.758442327463634, 73.01120937671502),
    LatLng(33.75806983481434, 73.01138859121451),
    LatLng(33.757995336090254, 73.01228466371195),
    LatLng(33.7581443334737, 73.01291191446015),
    LatLng(33.757622841498666, 73.0136287724581),
    LatLng(33.75739934396677, 73.01335995070887),
    LatLng(33.757175845852174, 73.0140768087068),
    LatLng(33.75680334769968, 73.0146144522053),
    LatLng(33.757101346351156, 73.01542091745297),
    LatLng(33.757101346351156, 73.01658581169963),
    LatLng(33.757175845852174, 73.01748188419708),
    LatLng(33.757175845852174, 73.01819874219503),
    LatLng(33.75680334769968, 73.01909481469245),
    LatLng(33.75590934552993, 73.01963245819091),
    LatLng(33.75516433660019, 73.02034931618887),
    LatLng(33.75330178595166, 73.02088695968733),
    LatLng(33.753972308846436, 73.0204389234386),
    LatLng(33.7532272830841, 73.0206181379381),
    LatLng(33.752631257813, 73.02169342493502),
    LatLng(33.75225873991453, 73.02223106843348),
    LatLng(33.751364690354876, 73.02258949743245),
    LatLng(33.750768652136095, 73.02321674818066),
    LatLng(33.74965106930875, 73.02339596268014),
    LatLng(33.74823544348433, 73.02375439167912),
    LatLng(33.74659626859758, 73.02321674818066),
    LatLng(33.74674528579105, 73.02348556992989),
    LatLng(33.74637274232186, 73.02285831918168),
    LatLng(33.74600019723433, 73.02196224668425),
    LatLng(33.74518059234535, 73.02151421043553),
    LatLng(33.744286468987966, 73.02115578143656),
    LatLng(33.743243313289994, 73.0204389234386),
    LatLng(33.74309429001174, 73.01954285094116),
    LatLng(33.742721730683336, 73.01873638569349),
    LatLng(33.74249819430952, 73.01775070594631),
    LatLng(33.742572706498855, 73.0163169899504),
    LatLng(33.741678555954756, 73.01506248845399),
    LatLng(33.74130599047707, 73.01434563045603),
    LatLng(33.74078439608972, 73.01353916520836),
    LatLng(33.74011377007417, 73.01228466371195),
    LatLng(33.73974119780008, 73.01129898396478),
    LatLng(33.73929410893516, 73.01031330421759),
    LatLng(33.73944313881569, 73.00941723172015),
    LatLng(33.73944313881569, 73.008073122974),
    LatLng(33.74011377007417, 73.0076250867253),
    LatLng(33.74063536853935, 73.00646019247861),
    LatLng(33.740709882346906, 73.00574333448067),
    LatLng(33.740709882346906, 73.00484726198324),
    LatLng(33.740411826728355, 73.00296550973863),
    LatLng(33.740411826728355, 73.00224865174067),
    LatLng(33.74026279853072, 73.00135257924323),
    LatLng(33.7400392557488, 73.00099415024427),
    LatLng(33.74033731266191, 72.99982925599761),
    LatLng(33.74011377007417, 72.9983955400017),
    LatLng(33.74115696383291, 72.99794750375298),
    LatLng(33.74212563239192, 72.9977682892535),
    LatLng(33.74264721862347, 72.9977682892535),
    LatLng(33.74369038157125, 72.99732025300479),
    LatLng(33.74361587035284, 72.99723064575504),
    LatLng(33.74443549019487, 72.9963345732576),
    LatLng(33.74577666940504, 72.9965137877571),
    LatLng(33.74689430272557, 72.99543850076017),
    LatLng(33.7477138912371, 72.9942736065135),
    LatLng(33.74838445782951, 72.9936463557653),
    LatLng(33.74972557528371, 72.99337753401608),
    LatLng(33.75069414706743, 72.99418399926375),
    LatLng(33.75114117650836, 72.99516967901094),
    LatLng(33.7518117163, 72.99579692975914),
    LatLng(33.752482250847805, 72.99642418050733),
    LatLng(33.7531527801518, 72.9965137877571),
    LatLng(33.75441932119631, 72.99669300225656),
    LatLng(33.75479182970751, 72.99606575150837),
    LatLng(33.75508983535114, 72.99642418050733),
    LatLng(33.75613284694641, 72.99723064575504),
    LatLng(33.756281847567, 72.99803711100273),
    LatLng(33.756579848031265, 72.99920200524939),
    LatLng(33.756579848031265, 72.99982925599761),
    LatLng(33.75695234715492, 73.00036689949607),
    LatLng(33.757101346351156, 73.001083757494),
    LatLng(33.757548342386116, 73.00144218649298),
    LatLng(33.757771839529525, 73.00233825899042),
    LatLng(33.757622841498666, 73.0031447242381),
    LatLng(33.75829333059816, 73.00368236773656),
    LatLng(33.758367829063275, 73.0047576547335),
    LatLng(33.75851682579926, 73.0060121562299),
    LatLng(33.75829333059816, 73.0060121562299),

  ];
 

  bool _checkIfValidMarker(LatLng tap, List<LatLng> vertices) {
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }

    return ((intersectCount % 2) == 1); // odd = inside, even = outside;
  }

  bool rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false;
    }

    if (aX == bX) {
      return true;
    }
    double m = (aY - bY) / (aX - bX);
    double bee = (-aX) * m + aY;
    double x = (pY - bee) / m;

    return x > pX;
  }

  void _getAddress( List<LatLng> points , LatLng pos1) {

    if (_checkIfValidMarker(pos1, points)) {
      print ("Inside Boundary");
      Fluttertoast.showToast(msg: "Inside Boundary");

    }
    else {
      Fluttertoast.showToast(msg: "Outside Boundary");
      NotificationWidget.showNotifications(title: "ALERT", body: "Animal Out Of bound", payload: FlutterLocalNotificationsPlugin());

    }
  }
  Future<bool> datanotupdated(data , String lat_lng) async {
    return await FirebaseFirestore.instance
        .collection('location')
        .doc("ZVs9bLumD3XVY4mETi13")
        .get()
        .then((value) => value[lat_lng] == data ? true : false);
  }

   get_live_location() async{
    await FirebaseFirestore.instance
        .collection('location')
        .doc("ZVs9bLumD3XVY4mETi13")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');

        widget.initial_position =  LatLng(double.parse(documentSnapshot["lat"]), double.parse(documentSnapshot["lng"]));
        Fluttertoast.showToast(msg: widget.initial_position.latitude.toString());
      } else {
        print('Document does not exist on the database');
        widget.initial_position = LatLng(0.0, 0.0);
      }
    });

  }

   //LatLng animal_location = widget.initial_position ;
  @override
  initState() {
    super.initState();

    NotificationWidget.init();
    //get_live_location();
    for(int i = 0; i < 1; i++)
    {
      Marker m = Marker(
        draggable: true,
        markerId: MarkerId('Animal' + i.toString()),
        // position: LatLng(33.74635825443523, 73.00529534884603),
        position: widget.initial_position,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: infoWindowArr[i],
      );
      _markers.add(m);
    }

    /*_markers.add(
        Marker(
          markerId: MarkerId('1'),
          position: LatLng(33.747806, 73.005352),
          infoWindow: InfoWindow(
              title: "Margalla Hills",
              snippet: "National Park"
          ),
          icon: BitmapDescriptor.defaultMarker,
        )
    ); */



    for (int i = 0; i < points.length; i++) {
      _polygone.add(
          Polygon(polygonId: PolygonId('1'),
              points: points,
              fillColor: Colors.red.withOpacity(0.3),
              geodesic: true,
              strokeWidth: 4,
              strokeColor: Colors.deepOrange
          )
      );
      _circle.add(
          Circle(
              circleId: CircleId('1'),
              center: LatLng(33.747806, 73.005352),
              radius: 6000,
              // zIndex: 1,
              strokeColor: Color.fromRGBO(102, 51, 153, .5),
              fillColor: Colors.blue.withOpacity(0.3))
      );

      // WidgetsBinding.instance?.addPostFrameCallback((_) async {
      //   // do something
      //   await new Future.delayed(const Duration(seconds : 5));
      //   Fluttertoast.showToast(msg: "Build Completed");
      //
      // });
      // setState(() {
      //
      // }
      // );

      //  for(int i = 0; i < path.length; i++)
      // {

      //    }

      // int animalIndex = 10;
      // if(animalIndex >= 0 && animalIndex < path.length) {
      //   _polyline.add(
      //   Polyline(polylineId: PolylineId(animalIndex.toString()),
      //       points: path[animalIndex],
      //       color: Colors.orange
      //   ),
      // );
      // }


    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    //Fluttertoast.showToast(msg: "Build Completed");
    return Scaffold(
        appBar: AppBar(
          title: Text('Google Map'),
          backgroundColor: Colors.teal[800],
        ),

        body: GoogleMap(
          markers: _markers.toSet(),
          /*markers: LatLng == null
              ? <Marker>[].toSet()
              : [
            Marker(
              markerId: MarkerId('m1'),
              position: LatLng(33.747806, 73.005352),
            ),
          ].toSet(),*/

          onMapCreated: (GoogleMapController controller){
            _controller = controller;
          },
          polylines: _polyline,
          polygons: _polygone,
          // circles: _circle,


          onTap: (LatLng) async {
            // distance in meters
            // var abc = Geolocator.distanceBetween(_markers[0].position.latitude, _markers[0].position.longitude,
            //     _markers[1].position.latitude, _markers[1].position.longitude);
            //
            // String distance = abc.toStringAsFixed(4);
            // double double_distance = double.parse(distance);
            // print(double_distance);
            //Fluttertoast.showToast(msg: history[0].latitude.toString());
            while(true) {
              await marker_changer();
              await new Future.delayed(const Duration(seconds : 5));
              //Fluttertoast.showToast(msg: "Method called");
            }

            //NotificationWidget.showNotifications(title: "ALERT", body: "Animal Out Of bound", payload: FlutterLocalNotificationsPlugin());
            //print("Count Done");
          },
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          initialCameraPosition: CameraPosition(
            target: widget.initial_position,
            zoom: 14,
          ),
          mapType: MapType.hybrid,
        )
    );
  }
}