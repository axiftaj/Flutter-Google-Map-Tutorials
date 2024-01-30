import 'package:flutter/material.dart';
import 'package:googlemap/convert_latlang_to_address.dart';
import 'package:googlemap/current_location.dart';
import 'package:googlemap/custom_marker.dart';
import 'package:googlemap/custom_marker_info_window.dart';
import 'package:googlemap/custom_marker_with_network_image.dart';
import 'package:googlemap/google_map_styling_screen.dart';
import 'package:googlemap/google_search_places_api.dart';
import 'package:googlemap/home_screen.dart';
import 'package:googlemap/polygone_screen.dart';
import 'package:googlemap/polyline_screen.dart';
import 'package:googlemap/polyline_two.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home:  const GoolgeMapStyling(),
    );
  }
}


