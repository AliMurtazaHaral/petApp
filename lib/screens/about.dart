import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import '../widgets/img.dart';
import '../widgets/my_colors.dart';
import '../widgets/my_text.dart';

class AboutAppRoute extends StatefulWidget {


  AboutAppRoute();

  @override
  AboutAppRouteState createState() => new AboutAppRouteState();
}


class AboutAppRouteState extends State<AboutAppRoute> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.cyan[900],
      appBar: AppBar(
          backgroundColor: Colors.cyan[800], brightness: Brightness.dark,
          title: Text("About"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {Navigator.pop(context);},
          ),
          // actions: <Widget>[
          //   PopupMenuButton<String>(
          //     onSelected: (String value){},
          //     itemBuilder: (context) => [
          //       PopupMenuItem(
          //         value: "Settings",
          //         child: Text("Settings"),
          //       ),
          //     ],
          //   )
          // ]
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 10),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2),),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Image.asset(Img.get('LOGO_REDLINE.png'), color: Colors.black),
                          width: 50, height: 50,
                        ),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("RedLine Animalia About", style: MyText.title(context)!.copyWith(color: MyColors.grey_80)),
                            Container(height: 2),
                            Text("@developers", style: MyText.caption(context)!.copyWith(color: MyColors.grey_40))
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.info, color: MyColors.grey_40), width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Version", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.w500)),
                            Container(height: 2),
                            Text("1.0", style: MyText.caption(context)!.copyWith(color: MyColors.grey_40))
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.sync, color: MyColors.grey_40), width: 50),
                        Container(width: 15),
                        Text("Changelog", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_60)),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2),),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 6),
                        Text("Author", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w500))
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.person, color: MyColors.grey_40), width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Huzaifa Abbasi", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.w500)),
                            Container(height: 2),
                            Text("Pakistan", style: MyText.caption(context)!.copyWith(color: MyColors.grey_40))
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.file_download, color: MyColors.grey_40), width: 50),
                        Container(width: 15),
                        Text("Download From PlayStore", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.w500)),
                        Spacer(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2),),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 6),
                        Text("Company", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w500))
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.business, color: MyColors.grey_40), width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Comsats", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.w500)),
                            Container(height: 2),
                            Text("Flutter Specialist", style: MyText.caption(context)!.copyWith(color: MyColors.grey_40))
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.location_on, color: MyColors.grey_40), width: 50),
                        Container(width: 15),
                        Expanded(
                          child: Text("Park Road Tarlai", style: MyText.subhead(context)!.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(height: 10),
          ],
        ),
      ),
    );
  }
}

