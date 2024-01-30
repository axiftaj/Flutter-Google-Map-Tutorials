import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class GoolgeMapStyling extends StatefulWidget {
  const GoolgeMapStyling({Key? key}) : super(key: key);

  @override
  _GoolgeMapStylingState createState() => _GoolgeMapStylingState();
}

class _GoolgeMapStylingState extends State<GoolgeMapStyling> {

  String mapStyle = '' ;


  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(33.6941, 72.9734),
    zoom: 15,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DefaultAssetBundle.of(context).loadString('images/map_style.json').then((string) {
      mapStyle = string;
    }).catchError((error) {
      print("error"+error.toString());
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Map staling'),
        actions: <Widget>[
          // This button presents popup menu items.
          PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: (){

                    _controller.future.then((value){

                      DefaultAssetBundle.of(context).loadString('images/map_style.json').then((string) {
                        setState(() {

                        });
                        value.setMapStyle(string);

                      });

                    }).catchError((error) {
                      print("error"+error.toString());
                    });

                  },
                  child: Text("Retro"),
                  value: 1,
                ),
                PopupMenuItem(
                  onTap: ()async{

                    _controller.future.then((value){

                      DefaultAssetBundle.of(context).loadString('images/night_style.json').then((string) {
                        setState(() {

                        });
                        value.setMapStyle(string);

                      });

                    }).catchError((error) {
                      print("error"+error.toString());
                    });
                  },
                  child: Text("Night"),
                  value: 2,
                )
              ]
          )
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller){
            controller.setMapStyle(mapStyle);
            _controller.complete(controller);
            },
        ),

      ),
    );
  }
}
