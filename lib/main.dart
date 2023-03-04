import 'package:flutter/material.dart';
import 'package:google_maps/homepage.dart';
import 'package:google_maps/post_arrival.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'login.dart';
import 'profile.dart';
import 'register.dart';
import 'towards_emergency.dart';
import 'alert_details.dart';
import 'searching.dart';
import 'dart:async';
import 'coming.dart';
import 'arrived.dart';
import 'homepage.dart';
import 'display.dart';


// const Profile_Name = TextStyle(
//   fontWeight: FontWeight.bold,
//   color: Colors.black45,
//   fontFamily: 'Poppins',
//   fontSize: 20,
//   letterSpacing: 0,
// );
//
// const role_style = TextStyle(
//   fontStyle: FontStyle.italic,
//   color: Colors.black45,
//   fontFamily: 'Poppins',
//   fontSize: 15,
//   letterSpacing: 0,
// );
//
// const text_field = TextStyle(
//   fontStyle: FontStyle.italic,
//   color: Colors.black45,
//   fontFamily: 'Poppins',
//   fontSize: 18,
//   letterSpacing: 0,
//   fontWeight: FontWeight.normal,
// );
//
// const not_pressed = TextStyle(
//   color: Colors.black45,
//   fontFamily: 'Poppins',
//   fontSize: 18,
//   letterSpacing: 0,
//   fontWeight: FontWeight.normal,
// );
// const radio_buttons = TextStyle(
//   color: Colors.black45,
//   fontFamily: 'Poppins',
//   fontSize: 15,
//   letterSpacing: 0,
//   fontWeight: FontWeight.normal,
// );
// var linkText = TextStyle(
//   color: Color.fromRGBO(255, 0, 95, 1),
//   fontFamily: 'Poppins',
//   fontSize: 10,
//   letterSpacing: 0,
//   fontWeight: FontWeight.normal,
//   height: 0,
// );
// var disclaimerText = TextStyle(
//   color: Colors.black45,
//   fontFamily: 'Poppins',
//   fontSize: 10,
//   letterSpacing: 0,
//   fontWeight: FontWeight.normal,
//   height: 0,
// );

void main() {
  runApp(
    MaterialApp(
      home:
          DisplayPage()
      // Searching(), //Searching(),  //Coming(), //AlertDetails(), //Profile(), //Register(), // LogIn()
    ),
  );
}

//-----------------------------------------------
//-----------------------------------------------
// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }
//
// class MapSampleState extends State<MapSample> {
//   Completer<GoogleMapController> _controller = Completer();
//
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: Text('To the lake!'),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }
//
//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
