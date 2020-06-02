
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'user_map.dart';
import 'HomePage.dart';


void main() {
  runApp(MaterialApp(
    title: 'Returning Data',
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Returning Data Demo'),
      ),
      body: Center(child: SelectionScreen()),
    );
  }
}

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Pick an option'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Close the screen and return "Yep!" as the result.
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