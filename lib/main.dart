
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'user_map.dart';
import 'HomePage.dart';
import 'redux/reducers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'locationItem.dart';



void main() {
  final store = new DevToolsStore<List<TestLocation>>(locationReducer,
      initialState: new List());

//  final store = new Store<List<String>>(addItemReducer,
//      initialState: new List());

  runApp(new FlutterReduxApp(store));
}
class FlutterReduxApp extends StatelessWidget {
  final DevToolsStore<List<TestLocation>> store;

  FlutterReduxApp(this.store);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<List<TestLocation>>(
      store: store,
      child: new SelectionScreen(store),
    );
  }
}
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Returning Data Demo'),
//       ),
//       body: Center(child: SelectionScreen()),
//     );
//   }
// }

// class SelectionButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return RaisedButton(
//       onPressed: () {
//         _navigateAndDisplaySelection(context);
//       },
//       child: Text('Pick an option, any option!'),
//     );
//   }

//   // A method that launches the SelectionScreen and awaits the result from
//   // Navigator.pop.
//   _navigateAndDisplaySelection(BuildContext context) async {
//     // Navigator.push returns a Future that completes after calling
//     // Navigator.pop on the Selection Screen.
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => SelectionScreen()),
//     );

//     // After the Selection Screen returns a result, hide any previous snackbars
//     // and show the new result.
//     // Scaffold.of(context)
//     //   ..removeCurrentSnackBar()
//     //   ..showSnackBar(SnackBar(content: Text("$result")));
//   }
// }


class SelectionScreen extends StatelessWidget {
 final DevToolsStore<List<TestLocation>> store;

  SelectionScreen(this.store);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context){
                    return MyHomePage();
                  }));
                },
                child: Text('User'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder:(context){
                    return ProviderPage();
                  }));
                },
                child: Text('Provider'),
              ),
            )
          ],
        ),
      ),
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