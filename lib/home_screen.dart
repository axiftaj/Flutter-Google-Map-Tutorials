import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final Completer<GoogleMapController> _controller = Completer();

  List<Marker> _markers = <Marker>[];

  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14,
  );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.add(
        Marker(
            markerId: MarkerId('SomeId'),
            position: LatLng(37.42796133580664, -122.085749655962),
            infoWindow: InfoWindow(
                title: 'The title of the marker'
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          trafficEnabled: false,
          rotateGesturesEnabled: true,
          buildingsEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}

// List<Marker> list = const [
//   Marker(
//       markerId: MarkerId('SomeId'),
//       position: LatLng(33.6844, 73.0479),
//       infoWindow: InfoWindow(
//           title: 'The title of the marker'
//       )
//   ),
//   Marker(
//       markerId: MarkerId('SomeId'),
//       position: LatLng( 33.738045,73.084488),
//       infoWindow: InfoWindow(
//           title: 'e-11 islamabd'
//       )
//   ),
// ];
//
// @override
// void initState() {
//   // TODO: implement initState
//   super.initState();
//   _markers.addAll(
//       list);
// }
