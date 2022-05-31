import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


class CustomMarkerWithNetworkImage extends StatefulWidget {
  const CustomMarkerWithNetworkImage({Key? key}) : super(key: key);

  @override
  _CustomMarkerWithNetworkImageState createState() => _CustomMarkerWithNetworkImageState();
}

class _CustomMarkerWithNetworkImageState extends State<CustomMarkerWithNetworkImage> {

  final Completer<GoogleMapController> _controller = Completer();


  List<String> images = [ 'images/car.png' ,'images/car2.png', 'images/marker2.png' ,
    'images/marker3.png', 'images/marker.png' , 'images/motorcycle.png' ,];

  final List<Marker> _markers =  <Marker>[];
  List<LatLng> _latLang =  [
    LatLng(33.6941, 72.9734), LatLng(33.7008, 72.9682) ,LatLng(33.6992, 72.9744),
    LatLng(33.6939, 72.9771), LatLng(33.6910, 72.9807), LatLng(33.7036, 72.9785)
  ];

  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(33.6941, 72.9734),
    zoom: 15,
  );


  Future<Uint8List>  getBytesFromAssets(String path , int width) async
  {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List() , targetHeight:60 );
    ui.FrameInfo fi = await codec.getNextFrame() ;
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }


  loadData ()async{

    for(int i = 0 ; i< images.length ; i++ ){

      // Bitmap newBitmap ;
      // Bitmap bitmap = await Bitmap.fromProvider(NetworkImage('https://media-exp1.licdn.com/dms/image/C5603AQFtuW78eNazIw/profile-displayphoto-shrink_800_800/0/1567442703746?e=1659571200&v=beta&t=3EIKzIls1HcNWGBBcspQlGFiIjRvmnc64MK4LwEncOQ'));


      //  Bitmap newBitMap = Bitmap.fromHeadless(30, 30, bitmap.buildHeaded());

      Uint8List? image = await  _loadNetworkImage('https://as2.ftcdn.net/v2/jpg/03/32/56/67/1000_F_332566713_q0QLBQ0BWkG5ed7DGRiuFIjvZNwEL9k2.jpg') ;

      final ui.Codec markerImageCodec = await instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetWidth: 100,
      );
      final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ImageByteFormat.png,
      );

      final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();
      _markers.add(
          Marker(markerId: MarkerId(i.toString()) ,
            position: _latLang[i],
            icon: BitmapDescriptor.fromBytes(resizedMarkerImageBytes),
            anchor: Offset(.1 , .1),
            //icon: BitmapDescriptor.fromBytes(image!.buffer.asUint8List()),
            infoWindow: InfoWindow(
                title: 'This is title marker: '+i.toString()
            ),
          ));
      setState(() {

      });
    }
  }

  Future<Uint8List?> _loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var img = NetworkImage(path);
    img.resolve(const ImageConfiguration(size: Size.fromHeight(10) )).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png ,);
    return byteData?.buffer.asUint8List();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
