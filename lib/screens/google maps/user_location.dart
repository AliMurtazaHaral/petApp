import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class UserLocationScreen extends StatefulWidget {
  const UserLocationScreen({Key? key}) : super(key: key);

  @override
  State<UserLocationScreen> createState() => UserLocationScreenState();
}

class UserLocationScreenState extends State<UserLocationScreen> {

  StreamSubscription? _locationSubscription;
  Location _locationTracker = Location();
  Circle circle = Circle(circleId: CircleId('car'));
  Marker marker = Marker(markerId: MarkerId('home'));

  late GoogleMapController _controller;
  static final CameraPosition initialLocation = CameraPosition(
      target: LatLng(37.42796133580664, -122.08574955962),
  zoom: 14);

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load('assets/images/location_mover.png');
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData){
    LatLng latLng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    this.setState(() {
      marker = Marker(
        markerId: MarkerId("home"),
        position: latLng,
        rotation:   newLocalData.heading!,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5 , 0.5),
        icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
        circleId: CircleId("car"),
        radius: 20.0,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latLng,
        fillColor: Colors.blue.withAlpha(70));
    });
  }



  void getCurrentLocation() async{
    try{
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location , imageData);

      if(_locationSubscription != null){
        _locationSubscription!.cancel();
      }

      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
          bearing: 192.83340901395799,
          target: LatLng(newLocalData.latitude! , newLocalData.longitude!),
          tilt: 0,
          zoom: 18.00
        )));
        updateMarkerAndCircle(newLocalData , imageData);
      });
    }
    on PlatformException catch(e){
      if(e.code == 'PERMISSION_DENIED'){
        debugPrint('Permission Denied');
      }
    }
  }


  @override

  void dispose(){
    if(_locationSubscription != null){
      _locationSubscription!.cancel();
    }
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialLocation,
        markers: Set.of(marker !=null ? [marker] : []),
        circles: Set.of(circle !=null ? [circle] : []),
        onMapCreated: (GoogleMapController controller){
          _controller = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.location_searching),
        onPressed: (){
          getCurrentLocation();
        },
      ),
    );
  }
}
