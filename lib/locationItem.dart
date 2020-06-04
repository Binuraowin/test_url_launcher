


import 'package:flutter/foundation.dart';

class TestLocation{

  var lat;
  var longi;

  TestLocation(this.lat, this.longi);
}

class AppState {
  final List<TestLocation> locationList;

  AppState({
    @required this.locationList,
  });

  AppState.initialState() : locationList = List.unmodifiable(<TestLocation>[]);
}