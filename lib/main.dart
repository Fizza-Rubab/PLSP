// @dart=2.9
import 'package:flutter/material.dart';
import 'package:google_maps/Alert/Arrival.dart';
import 'package:google_maps/Home/Citizen_History.dart';
import 'package:google_maps/Lifesaver/Lifesaver.dart';
import 'shared.dart';


// void main() {
//   runApp(
//     MaterialApp(home: DisplayPage()
//         // Searching(), //Searching(),  //Coming(), //AlertDetails(), //Profile(), //Register(), // LogIn()
//         ),
//   );
// }

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

import 'Welcome/Welcome.dart';
import 'Home/Citizen.dart';
import 'Lifesaver/Lifesaver_Home.dart'; 
import 'Lifesaver/Lifesaver_History.dart'; 
import 'Alert/searching.dart'; 
import 'Alert/about_to_reach.dart';



void main(){
  sharedPrefInit();
  WidgetsFlutterBinding.ensureInitialized();
    if (getString('token')!=null){
      runApp(const MaterialApp(home: Welcome(who: 'logged_in', )));
    }
    else
      runApp(const MaterialApp(home: Welcome(who: 'logged_out',)));
}