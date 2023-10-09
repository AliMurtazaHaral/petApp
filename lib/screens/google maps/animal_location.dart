import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class Animal_tracker extends StatefulWidget {
  const Animal_tracker({Key? key}) : super(key: key);

  @override
  State<Animal_tracker> createState() => _Animal_trackerState();
}

class _Animal_trackerState extends State<Animal_tracker> {
var latlng;
  Future<dynamic> get_animal_location()async{
    final response = await http.Client().get(Uri.parse("https://petaffixapp.herokuapp.com/getlatlng"));
    if(response.statusCode == 200){
      var document = response.body;
      //http.Response res = await http.Response.fromStream(document);
      final resJson = jsonDecode(document);

      latlng = resJson;

      print("thelatlng is $latlng");
    }else{
      print("error");
    }
  }


  @override
  Widget build(BuildContext context) {
    get_animal_location();
    return Container(


    );
  }
}
