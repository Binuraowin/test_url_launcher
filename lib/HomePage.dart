import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatelessWidget {
    final String lat = "6.8211";
  final String lng = "80.0409";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("URL Launcher"),
      ),
      body: Column(
        children: <Widget>[
        ListTile(
  title: Text("Launch Maps"),
  onTap: () async {
    final String googleMapsUrl = "https://maps.google.com/?q=$lat,$lng";
 

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    }
   else {
      throw "Couldn't launch URL";
    }
  },
),
        ],
      ),
    );
  }
}