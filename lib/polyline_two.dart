import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PolylineTwoScreen extends StatefulWidget {
  const PolylineTwoScreen({Key? key}) : super(key: key);

  @override
  _PolylineTwoScreenState createState() => _PolylineTwoScreenState();
}

class _PolylineTwoScreenState extends State<PolylineTwoScreen> {

  Completer<GoogleMapController> _controller = Completer();


  CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(33.738045, 73.084488),
    zoom: 14,
  );
  static const LatLng _center = const LatLng(33.738045, 73.084488);
  final Set<Marker> _markers = {};
  final Set<Polyline>_polyline={};

//add your lat and lng where you wants to draw polyline
  LatLng _lastMapPosition = _center;

  List<LatLng> latlng = [LatLng(33.738045, 73.084488) , LatLng(33.567997728, 72.635997456)];





  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(int i = 0 ; i < latlng.length ; i++){

      setState(() {
        _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(i.toString()),
          //_lastMapPosition is any coordinate which should be your default
          //position when map opens up
          position: latlng[i],
          infoWindow: InfoWindow(
            title: 'Really cool place',
            snippet: '5 Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,

        ));
        _polyline.add(Polyline(
          polylineId: PolylineId(i.toString()),
          visible: true,
          //latlng is List<LatLng>
          points: latlng,
        //  points: latlng[i],

          color: Colors.blue,
        ));
      });

    }

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
          body:GoogleMap(
            //that needs a list<Polyline>

            polylines:_polyline,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationEnabled:true,
           // onCameraMove: _onCameraMove,
            initialCameraPosition: _kGooglePlex,

            mapType: MapType.normal,

          )),
    );
  }

}
