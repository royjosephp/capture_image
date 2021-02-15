import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class ConvertGeocodesToAddress extends StatefulWidget {

  @override
  _ConvertGeocodesToAddressState createState() => _ConvertGeocodesToAddressState();
}

class _ConvertGeocodesToAddressState extends State<ConvertGeocodesToAddress> {
  Position _position;
  StreamSubscription<Position> _streamSubscription;
  Address _address;

  @override
  void initState(){
    super.initState();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    _streamSubscription = Geolocator().getPositionStream(locationOptions).listen((Position position) {
      setState(() {
        print(position);
        _position = position;

        final coordinates = new Coordinates(position.latitude, position.longitude);
        convertCoordinatesToAddress(coordinates).then((value)=> _address=value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10,),
            Text("Your Location is Identified as follows:"),
            SizedBox(height: 20,),
            Text("latitude:${_position?.latitude?? '-'}, longitude:${_position?.longitude?? '-'}"),
            SizedBox(height: 20,),
            Text("Country : ${_address?.countryName?? '-'}"),
            Text("State : ${_address?.adminArea?? '-'}"),
            Text("District : ${_address?.subAdminArea?? '-'}"),
            Text("Postal Code : ${_address?.postalCode?? '-'}"),
            SizedBox(height: 20,),
            Text("Address : ${_address?.addressLine?? '-'}"),

          ],
        ),
      );

  }

  @override
  void dispose(){
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<Address> convertCoordinatesToAddress(Coordinates coordinates) async {
    var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return address.first;
  }
}