import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Report_Location_Screen extends StatefulWidget {
  String lat;
  String lng;
  Report_Location_Screen({Key? key , required this.lat , required this.lng}) : super(key: key);

  @override
  State<Report_Location_Screen> createState() => _Report_Location_ScreenState();
}

class _Report_Location_ScreenState extends State<Report_Location_Screen> {
  @override
  Marker marker = new Marker(markerId: MarkerId("1"));

  @override
  void initState() {
    super.initState();
    marker = Marker(
      draggable: true,
      markerId: MarkerId("Report Site"),
      // position: LatLng(33.74635825443523, 73.00529534884603),
      position: LatLng(double.parse(widget.lat) , double.parse(widget.lng)),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(),
    );
  }
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(widget.lat) , double.parse(widget.lng)),
          zoom: 14,
        ),
        markers: Set.of(marker !=null ? [marker] : []),
        mapType: MapType.hybrid,

    );
  }
}
