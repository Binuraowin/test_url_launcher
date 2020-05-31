import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  GoogleMapController _controller;
  Position _currentPosition;
  String _currentAddress;

 
List<Marker> allMarkers = [];

 @override
void initState() {
  super.initState();
  allMarkers.add(Marker(
    markerId:MarkerId("myMarker"),
    draggable: true,
  //  position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
     ));

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body:
      GoogleMap(
        mapType: MapType.normal,
        compassEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(6.8211, 80.0409),
          zoom: 12.0,
        ),
       markers: Set.from(allMarkers),
     //   circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },

      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () {
           _getCurrentLocation();
          }),

    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

    //  _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

}