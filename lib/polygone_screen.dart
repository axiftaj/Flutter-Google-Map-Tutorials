import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PolygoneScreen extends StatefulWidget {
  const PolygoneScreen({Key? key}) : super(key: key);

  @override
  _PolygoneScreenState createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {

  Completer<GoogleMapController> _controller = Completer();


  CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(8.984744630984105, -79.51568584889174),
    zoom: 14,
  );
  final Set<Marker> _markers = {};
  Set<Polygon> _polygone = HashSet<Polygon>() ;

  List<LatLng> points = [
    LatLng(9.000471, -79.495544),
    LatLng(8.999406, -79.495831),

    LatLng(8.998838, -79.494680),
    LatLng(8.997630, -79.493314),
    LatLng(8.995286, -79.495831),
    LatLng(8.994078, -79.496335),
    LatLng(8.992941, -79.495615),
    LatLng(8.990029, -79.497701),
    LatLng(8.985198, -79.502664),
    LatLng(8.981359, -79.506608),
    LatLng(8.969308, -79.514766),
    LatLng(8.965132, -79.518738),
    LatLng(8.979038, -79.529805),
    LatLng(8.995424, -79.520294),

    LatLng(9.000471, -79.495544),

  ] ;


  void _setPolygone(){
    _polygone.add(
        Polygon(polygonId: PolygonId('1') ,
            points: points ,
            strokeColor: Colors.deepOrange,
            strokeWidth: 5 ,
            fillColor: Colors.deepOrange.withOpacity(0.1),
            geodesic: true
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setPolygone() ;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Polygone'),),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        // cameraTargetBounds: CameraTargetBounds(LatLngBounds(
        //   northeast: LatLng(9.006808, -79.508148),
        //   southwest:  LatLng(9.003121, -79.505702),
        // )),
        //  onCameraMove: ((_position) => _updatePosition(_position)),
        markers:_markers ,
        polygons: _polygone,

        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
