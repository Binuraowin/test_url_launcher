import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'locationItem.dart';
import 'locationItem.dart';
import 'locationItem.dart';
import 'locationItem.dart';
import 'main.dart';
import 'redux/actions.dart';
import 'package:redux/redux.dart';



class MyHomePage extends StatefulWidget {
  final ViewModel model;
  @override
  _MyHomePageState createState() => _MyHomePageState(this.model);

  MyHomePage(this.model);
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;
  var lat;
  var longi;
  LatLng markervalue;
  LatLng testloc;
  ViewModel model;
   ScrollController scrollController;
  bool dialVisible = true;

  _MyHomePageState(this.model);

   CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );



  LatLng updateMarkerAndCircle(LocationData newLocalData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    print(latlng);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: true,
          onDragEnd: ((value){
            markervalue = LatLng(value.latitude, value.longitude);
            print(markervalue);
          }),
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5));
 
    });
    return markervalue;
  }


  Future<LatLng> getCurrentLocation() async {
    try {

      var location = await _locationTracker.getLocation();
        if (_controller != null) {
           if (markervalue != null) {
             testloc=LatLng(markervalue.latitude, markervalue.longitude);
      print(testloc);
            
          } else {
            testloc=LatLng(location.latitude, location.longitude);
      print(testloc);
          }
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target:testloc,
              tilt: 0,
              zoom: 18.00)));
          updateMarkerAndCircle(location);
         print(markervalue);
         return testloc;
        }
      

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }
    void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
         actions: <Widget>[
           Text(this.model.locations.isNotEmpty ? this.model.locations[0].lat : "hello"),
          ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,
        markers: Set.of((marker != null) ? [marker] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },

      ),
      floatingActionButton: SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          visible: dialVisible,
          // If true user is forced to close dial manually 
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.add_location),
              backgroundColor: Colors.blueAccent,
              label: 'Share Location',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => getCurrentLocation(),
            ),
            SpeedDialChild(
              child: Icon(Icons.edit_location),
              backgroundColor: Colors.blueAccent,
              label: 'Set Location',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => this.model.onAddLocation(new TestLocation(testloc.latitude, testloc.longitude)),
            ),
          ],
        ),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.location_searching),
      //     onPressed: () {
      //       this.model.onAddLocation(new TestLocation(testloc.latitude, testloc.longitude));
      //     }),
    );
  }
     

  }
