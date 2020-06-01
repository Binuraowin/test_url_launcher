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

  final String _markerImageUrl =
      'https://img.icons8.com/office/80/000000/marker.png';

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();
    _currentPosition = null;
    markers = {};
  }

  getLoc() async {
    await _getCurrentLocation();
    Marker marker = Marker(
      markerId: MarkerId("myMarker"),
      draggable: true,
      position: LatLng(6.157, 85.3658),
    );

    this.setState(() {
      markers[marker.markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        compassEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(6.8211, 80.0409),
          zoom: 8.0,
        ),
        markers: Set<Marker>.of(markers.values),
        //   circles: Set.of((circle != null) ? [circle] : []),
       onMapCreated: (controller) => _onMapCreated(controller),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () {
            _getCurrentLocation();
          }),
    );
  }

_onMapCreated(GoogleMapController controller)async{
  print("map created");
  await getLoc();
  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: markers.values.first.position)));
}

  _getCurrentLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    await geolocator
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