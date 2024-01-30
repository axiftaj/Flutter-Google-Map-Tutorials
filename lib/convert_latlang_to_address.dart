import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:location_geocoder/location_geocoder.dart';


class ConvertLatLangToAddress extends StatefulWidget {
  const ConvertLatLangToAddress({Key? key}) : super(key: key);

  @override
  _ConvertLatLangToAddressState createState() => _ConvertLatLangToAddressState();
}

class _ConvertLatLangToAddressState extends State<ConvertLatLangToAddress> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                 Text('latitude: 37.597576, longitude: 55.771899'),
             //   Text(address),
              ],
            ),
            const SizedBox(height: 40),
            Column(
              children: <Widget>[
                const Text('address: Москва, 4-я Тверская-Ямская улица, 7'),
                //Text(latLong),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          late LocatitonGeocoder geocoder = LocatitonGeocoder('');

          final address = await geocoder
              .findAddressesFromCoordinates(Coordinates(9.9312, 76.2673));
          var message = address.first.addressLine;
          if (message == null) return;
          log(message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );

          final address1 = await geocoder.findAddressesFromQuery('kochi,kerala');
          var message1 = address1.first.coordinates.toString();
          log(message1);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message1),
            ),
          );

        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
