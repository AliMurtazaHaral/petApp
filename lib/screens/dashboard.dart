import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/about.dart';
import 'package:fyp/screens/registration_screen.dart';
import 'package:fyp/screens/reporting.dart';
import 'package:fyp/screens/settings.dart';
import 'package:fyp/screens/google%20maps/user_location.dart';
import 'package:fyp/widgets/my_colors.dart';
import 'package:fyp/widgets/my_text.dart';
import '../models/UserModel.dart';
import 'ML screens/animals_collection.dart';
import 'ML screens/detect.dart';
import 'QR screens/qr_scan.dart';
import 'login_screen.dart';
import 'package:fyp/widgets/img.dart';
import 'package:fyp/screens/profile.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen();

  @override
  DashboardScreenState createState() => new DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController? _tabController;
  int currentIndex = 0;


  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController!.addListener(() {});
    FirebaseFirestore.instance
        .collection("users")
        .doc("LQ0PFtnsaxXU1c4tY0ZM")
        .collection("Visitor")
        .doc(user!.uid).get()
        .then((value) {
      loggedInUser = UserModel.fromMapRegsitration(value.data());
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(loggedInUser.username.toString()),
              accountEmail: Text(loggedInUser.email.toString()),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    Img.get('icon_profile.png'),
                    color: Colors.white,
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/profile-bg3.jpg')
                    // NetworkImage('https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')
                ),
              ),
            ),
            SideBarCard(context, 'assets/images/icon_profile.png', 'Profile' , onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));}),
            SideBarCard(context, 'assets/images/icon_settings.png', 'Settings', onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));}),
            SideBarCard(context, 'assets/images/icon_about.png', 'About', onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AboutAppRoute()));})
          ],
        ),
      ),
      backgroundColor: MyColors.grey_5,
      appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: MyColors.grey_60),
          // title: Text("Home",
          //     style: MyText.title(context)!.copyWith(color: MyColors.grey_60)),
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
              }),
          actions: <Widget>[
            MaterialButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserLocationScreen()));
              },
              child: ImageIcon(
                AssetImage('assets/images/mapicon.png'),color: Colors.cyan[900],
              ),
            ), // overflow menu
          ]),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: <Widget>[
          AnimalCollectionScreen(),
          DetectScreen(),
          ScanQR_Screen(),
          Reporting_Screen()
        ],
      ),
      
      bottomNavigationBar: menu(),
    );

  }

  Widget menu() {
    return Container(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.all(0),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: TabBar(
            indicatorColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 1,
            unselectedLabelColor: Colors.grey[600],
            labelColor: Colors.cyan[900],
            onTap: (index) => setState(() {
              currentIndex = index;
            }),
            tabs: [
              Tab(
                icon: Image.asset(
                  Img.get('icon_collection.png'),
                  color: _tabController?.index == 0
                      ? Colors.cyan[900]
                      : Colors.grey,
                  height: 25,
                  width: 25,
                ),
                text: "Animals",
              ),
              Tab(
                icon: Icon(Icons.camera_enhance,
                  color: _tabController?.index == 1
                      ? Colors.cyan[900]
                      : Colors.grey,
                ),
                text: "Detect",

              ),
              Tab(
                icon: Image.asset(
                  "assets/images/scan_qr.png",
                  color: _tabController?.index == 2
                    ? Colors.cyan[900]
                    : Colors.grey,
                  height: 25,
                  width: 25,
      ),
                text: "Scan",
              ),
              Tab(
                icon: Image.asset(
                  Img.get('report.png'),
                  color: _tabController?.index == 3
                      ? Colors.cyan[900]
                      : Colors.grey,
                  height: 35,
                  width: 35,
                ),
                text: "Report",
              ),
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }


}
Widget SideBarCard( BuildContext context, String image_name, String name ,
    {Function? onTap}){
  return Card(
    color: Colors.cyan[900],
    child: ListTile(
      iconColor: Colors.white,
      leading: ImageIcon(AssetImage(image_name)),
      title: Text(name, style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),),
      onTap: () {
        onTap!();
      },
    ),
  );
}

