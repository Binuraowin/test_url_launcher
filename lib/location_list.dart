import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:test_url_launcher/locationItem.dart';
import 'user_map.dart';
import 'HomePage.dart';
import 'redux/reducers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'locationItem.dart';



class LocationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<List<TestLocation>, List<TestLocation>>(
      converter: (store) => store.state,
      builder: (context, list) {
        // return new ListView.builder(
        //     // itemCount: list.length,
        //     // itemBuilder: (context, position) =>
        //         // new ShoppingListItem(list[position])
        //         );
      },
    );
  }
}