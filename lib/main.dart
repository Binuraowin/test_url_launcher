
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Map Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
      print(markervalue);
            
          } else {
            testloc=LatLng(location.latitude, location.longitude);
      print(location);
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

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
         actions: <Widget>[
          FlatButton.icon(
            onPressed: ()  {
 
            },
            icon: Icon(Icons.location_on),
            label: Text('Share my location',style: TextStyle(
                          fontSize: 12,

                        ),),
          )]
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,
        markers: Set.of((marker != null) ? [marker] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },

      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () {
            getCurrentLocation();
          }),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'ShareingPage.dart';


void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Launcher',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}
*/