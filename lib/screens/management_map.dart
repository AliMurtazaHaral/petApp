import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'dart:collection';
import "dart:async";
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'Alert.dart';
// import 'package:quickalert/quickalert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class History_Playback_Screen extends StatefulWidget{
  const History_Playback_Screen({Key? key}): super(key: key);

  @override
  _History_Playback_ScreenState createState() => _History_Playback_ScreenState();

}
class _History_Playback_ScreenState extends State<History_Playback_Screen> {

  List<LatLng> history = [];
  late final StreamSubscription myStream;

// Alert generator
//   QuickAlert.show(
//   context: context,
//   type: QuickAlertType.warning,
//   text: 'You just broke protocol',
//   );

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> marker_changer() async {
    print("Updating markers: ");
    _polyline.add(
      Polyline(polylineId: PolylineId("abc"),
          points: path[7],
          color: Colors.orange
      ),
    );
    for (int i = 0; i < history.length; i++) {
      //_markers[i].copyWith(positionParam:path[i][(_counter%path[i].length)]);
      // print("Old value");
      //m.copyWith(positionParam:path[i][(_counter%path[i].length)]);

      //print(_markers[0].position);
      // Timer(Duration(seconds: 5),(){
      await new Future.delayed(const Duration(seconds : 5));
      setState(() {
        _markers[0] = _markers[0].copyWith(positionParam: LatLng(history[i].latitude, history[i].longitude));
        // markers.elementAt(0) = markers.elementAt(0).copyWith(positionParam: LatLng(path_2[i].latitude, path_2[i].longitude));
        print(_markers);
        print("5 second break");

      });
      _getAddress( points , history[i]);
      if(i == history.length - 1){
        await new Future.delayed(const Duration(seconds : 5));
        setState(() {
          _polyline =  {};
          _markers[0] =  _markers[0].copyWith(positionParam: LatLng(history[0].latitude, history[0].longitude));
        });
      }



      //    });

      // m.copyWith(positionParam: path_2[i]);
      //
      // print("New value");

      // print("for pausing");
      // setState(() {
      //
      // });

      //_markers.a
    }
  }


  Completer<GoogleMapController> _controller = Completer();
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

    InfoWindow(title: "Muntjac",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Wild Boar",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Golden Jackal",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Markhor",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Indian Leopard",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Kashmir Flying Squirrel",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Asian Palm Civet",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Gray Goral Sheep",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Himalayan Brown Bear",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Himalayan Marmot",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Indian Crested Porcupine",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Indian Flying Fox",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Indian Gray Mongoose",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Stag",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Striped Hyena",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Wild Boar",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Wild Hare",
        snippet: "WildLife Animal"),

    InfoWindow(title: "Yellow Throated Marten",
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
  List<LatLng> path_2 = [
    LatLng(33.745906049008894, 73.00490689290314),
    LatLng(33.751036937722134, 73.01165880424155),
    LatLng(33.75216266788833, 73.01679098514327),
    LatLng(33.74638844996954, 73.01050783519196),
  ];

  List<List<LatLng>> path = [
    [ //0
      LatLng(33.745906049008894, 73.00490689290314),
      LatLng(33.74607401130273, 73.00512442823117),
      LatLng(33.74628073367434, 73.00521765765747),
      LatLng(33.74635825443523, 73.00529534884603),
      LatLng(33.74646161534073, 73.00535750179691),
      LatLng(33.746616656465434, 73.00531088708375),
      LatLng(33.746900897799414, 73.00545073122319),
      LatLng(33.74699133802629, 73.00560611360036),
      LatLng(33.747094698168794, 73.00555949888721),
      LatLng(33.74718513819286, 73.00555949888694),
      LatLng(33.74727557811999, 73.00549734593608),
      LatLng(33.74741769781276, 73.00565272831324),
      LatLng(33.74761149701427, 73.00585472540357),
      LatLng(33.7478957350509, 73.0063674872482),
      LatLng(33.74797325435195, 73.00658502257622),
      LatLng(33.74793449471018, 73.0064607166745),
      LatLng(33.74807661331098, 73.00663163728939),
      LatLng(33.74824457135374, 73.00709778442088),
      LatLng(33.748554646876094, 73.0071288608963),
      LatLng(33.74876136326812, 73.00726870503574),
      LatLng(33.749006838336435, 73.00739301093749),
      LatLng(33.74931691110251, 73.00745516388835),
      LatLng(33.74961406311792, 73.0075173168392),
      LatLng(33.74963990237495, 73.00747070212606),
      LatLng(33.74998873158268, 73.00770377569181),
      LatLng(33.75031172032459, 73.00775039040495),
      LatLng(33.75044091548073, 73.00789023454439),
      LatLng(33.750595949411114, 73.00793684925755),
      LatLng(33.75090601643098, 73.008076693397),
      LatLng(33.736325038228294, 73.00094537319858),
      LatLng(33.737970427593645, 73.00285068833224),
      LatLng(33.739737662502336, 73.00285068833224),
      LatLng(33.741200174204835, 73.00438959670943),
      LatLng(33.74272359737943, 73.00416975265554),
      LatLng(33.744612604538695, 73.00702772535604),
      LatLng(33.75369144546946, 73.01545508075495),
      LatLng(33.75521464675683, 73.01736039588862),
      LatLng(33.7572861570782, 73.01736039588862),
      LatLng(33.76008870901582, 73.01992524318392),
      LatLng(33.761429027552474, 73.02256337183054),
    ],
    [ //1
      LatLng(33.74722911895063, 73.01492175383909),
      LatLng(33.748514276689264, 73.01532246694757),
      LatLng(33.74813349121902, 73.01566593532625),
      LatLng(33.74960902549766, 73.01600940370496),
      LatLng(33.75141771029945, 73.01652460627298),
      LatLng(33.751227324222164, 73.01698256411123),
      LatLng(33.75256001788582, 73.01629562735386),
      LatLng(33.751132131024995, 73.01618113789429),
    ],
    [ //2
      LatLng(33.751036937722134, 73.01165880424155),
      LatLng(33.75175088491752, 73.01051390964592),
      LatLng(33.75275040100398, 73.01039942018636),
      LatLng(33.75422585583615, 73.00931177032051),
      LatLng(33.75275040100398, 73.01039942018636),
      LatLng(33.75584406742388, 73.00816687572488),
      LatLng(33.756938722648734, 73.0071937153186),
      LatLng(33.7606033362381, 73.00307209477432),
      LatLng(33.761840702847834, 73.00244240274674),
      LatLng(33.761555158292595, 73.00032434774482),
    ],
    [ //3
      LatLng(33.75216266788833, 73.01679098514327),
      LatLng(33.7533999497127, 73.01720435027164),
      LatLng(33.75532457483897, 73.01753504237433),
      LatLng(33.752093929485675, 73.01728702329733),
    ],
    [ //4
      LatLng(33.74638844996954, 73.01050783519196),
      LatLng(33.744944834738554, 73.00901972072981),
      LatLng(33.74521981094171, 73.00629151088253),
      LatLng(33.74343244986246, 73.00563012667713),
    ],
    [ //5
      LatLng(33.74673216430007, 73.02051127129863),
      LatLng(33.74583850417539, 73.0183617726311),
      LatLng(33.74542604251553, 73.01728702329733),
      LatLng(33.74473860200765, 73.01522019765544),
    ],
    [ //6
      LatLng(33.75058167068555, 73.01786573447704),
      LatLng(33.750994107548856, 73.01894048381082),
      LatLng(33.75195645251506, 73.02100730945268),
      LatLng(33.75188771394709, 73.02381819232565),
      LatLng(33.75168149791254, 73.02447957653105),
      LatLng(33.752918786680404, 73.0276211515067),
      LatLng(33.75388111004474, 73.02977065017424),
      LatLng(33.754087320788976, 73.03216816791884),
      LatLng(33.754705950045874, 73.03398697448368),
      LatLng(33.75477468635442, 73.03530974289448),
      LatLng(33.75477468635442, 73.03762458761338),
      LatLng(33.756561811033585, 73.0385339908958),
      LatLng(33.75711168805531, 73.03969141325526),
    ],
    [ //7
      //LatLng(33.748931903394535, 73.01852711868244),
      LatLng(33.749000644332035, 73.0196845410419),
      LatLng(33.749000644332035, 73.02084196340134),
      LatLng(33.748107007846485, 73.02423155745402),
      // LatLng(33.747625815112436, 73.02638105612158),
      // LatLng(33.74618222070999, 73.0286132278148),
      // LatLng(33.745975990954555, 73.02853055478913),
      // LatLng(33.745082322950346, 73.0309280725337),
      // LatLng(33.744944834738554, 73.03398697448368),
      // LatLng(33.743019976631494, 73.03869933694715),
      // LatLng(33.74198878487592, 73.04126220074309),
    ],
    [ //8
      LatLng(33.75628687120009, 73.00935041283252),
      LatLng(33.754705950045874, 73.00935041283252),
      LatLng(33.753537424368815, 73.00885437467846),
      LatLng(33.753056262108025, 73.00885437467846),
    ],
    [ //9
      LatLng(33.75044419129027, 73.00596081877983),
      LatLng(33.75003175178192, 73.00405933918931),
      LatLng(33.749275607530954, 73.00257122472715),
      LatLng(33.749000644332035, 73.00050439908527),
    ],
    [ //10
      LatLng(33.75257509714698, 72.99670143990423),
      LatLng(33.751818975324014, 72.9974454971353),
      LatLng(33.75367489880451, 72.99504797939073),
      LatLng(33.75553078211137, 72.99364253795424),
      LatLng(33.75814269796447, 72.99397323005695),
      LatLng(33.76006721661766, 72.99397323005695),
    ],
    [ //11
      LatLng(33.74851945661237, 72.9941385761083),
      LatLng(33.746800907000846, 72.9921544234921),
      LatLng(33.74521981094171, 72.98884750246509),
      LatLng(33.74329495900587, 72.98727671497727),
      LatLng(33.74212627782629, 72.98578860051512),
      LatLng(33.740613843250735, 72.98297771764217),
    ],
    [ //12
      LatLng(33.74570101717585, 72.99901628462312),
      LatLng(33.74418864563408, 73.00083509118798),
      LatLng(33.74329495900587, 73.00083509118798),
      LatLng(33.74137006387193, 73.00215785959877),
    ],
    [ //13
      LatLng(33.747900782719654, 73.02067661734999),
      LatLng(33.746113477513276, 73.02323948114592),
      LatLng(33.743913666124904, 73.02175136668377),
      LatLng(33.74185129170519, 73.0196845410419),
      LatLng(33.740063860429714, 73.01794840750273),
      LatLng(33.73827639190868, 73.01662563909191),
    ],
    [ //14
      LatLng(33.75037545150998, 73.01331871806492),
      LatLng(33.747900782719654, 73.01331871806492),
      LatLng(33.746113477513276, 73.01315337201356),
      LatLng(33.74350119520811, 73.01265733385952),
    ],
    [ //15
      LatLng(33.74769455709691, 72.99661876687856),
      LatLng(33.74590724759253, 72.99562669057045),
      LatLng(33.74143881087056, 72.99405590308264),
      LatLng(33.7377951440202, 72.99430392215965),
      LatLng(33.7355951192938, 72.99405590308264),
    ],
    [ //16
      LatLng(33.75113158606245, 72.99901628462312),
      LatLng(33.752850048883936, 72.99992568790556),
      LatLng(33.756011930484824, 73.0024058786758),
      LatLng(33.75910496269206, 73.00265389775282),
      LatLng(33.761166922162666, 73.00389399313796),
    ],
    [ //17
      LatLng(33.754912158806206, 73.01389742924464),
      LatLng(33.75807396435632, 73.01431079437302),
      LatLng(33.761235653290775, 73.01522019765544),
      LatLng(33.76494705236252, 73.01951919499054),
    ]

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

  getfirebasedata() async{
    await FirebaseFirestore.instance
        .collection('animal_history')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        history.add(new LatLng(double.parse(doc["latitude"]), double.parse(doc["longitude"])));
      });
    });
  }
  Timer? timer;
  @override
   initState() {
    super.initState();
     getfirebasedata();
    // timer = Timer.periodic(Duration(seconds: 5), (Timer t) => ());
    // StreamBuilder(
    //   builder: (context , AsyncSnapshot<QuerySnapshot> streamSnapshot){
    //     final history_data = streamSnapshot.data?.docs;
    //     String lat = "abc";
    //     String long;
    //     for(var data in history_data!){
    //
    //       history.add(new LatLng(double.parse(data["latitude"]), double.parse(data["longitude"])));
    //       lat = data["latitude"];
    //     }
    //     Fluttertoast.showToast(msg: lat);
    //     return Container();
    //   },
    // );
    //PolylineScreen();
    NotificationWidget.init();

    for(int i = 0; i < 2; i++)
    {
      Marker m = Marker(
        draggable: true,
        markerId: MarkerId('Animal' + i.toString()),
        // position: LatLng(33.74635825443523, 73.00529534884603),
        position: path[i][0],
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
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
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
            _controller.complete(controller);
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
            await marker_changer();
             //NotificationWidget.showNotifications(title: "ALERT", body: "Animal Out Of bound", payload: FlutterLocalNotificationsPlugin());
            //print("Count Done");
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.hybrid,
        )
    );
  }
}