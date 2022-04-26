import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({Key? key}) : super(key: key);

  @override
  _CustomMarkerScreenState createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {

  final Completer<GoogleMapController> _controller = Completer();

  List<String> images = [ 'images/car.png' ,'images/car2.png', 'images/marker2.png' , 'images/marker3.png', 'images/marker.png' , 'images/motorcycle.png' ,];

  Uint8List? markerImage;
  final List<Marker> _markers =  <Marker>[];
  final List<LatLng> _latLang =  <LatLng>[
    LatLng(33.6941, 72.9734), LatLng(33.7008, 72.9682) ,LatLng(33.6992, 72.9744),
    LatLng(33.6939, 72.9771), LatLng(33.6910, 72.9807), LatLng(33.7036, 72.9785)];

  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(33.6910, 72.98072),
    zoom: 15,
  );


  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData()async{

    for(int i = 0 ; i < images.length ; i++){

      final Uint8List markerIcon = await getBytesFromAsset(images[i].toString(), 100);
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: _latLang[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
              title: 'The title of the marker'
          )
      ));
      setState(() {

      });
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Customer Marker'),
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),

      ),
    );
  }
}
