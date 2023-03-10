import 'package:flutter/material.dart';
import 'package:google_maps/Alert/searching.dart';
import 'package:google_maps/Alert/about_to_reach.dart';
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
// void main(){
//   sharedPrefInit();
//   runApp(Welcome());
// }

void main(){
  sharedPrefInit();
  runApp(MaterialApp(
      home:AboutToReach(args: {"latitude":24.9059, "longitude":24.9059},)))
      ;
  }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'PLSP',
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         scaffoldBackgroundColor: Colors.white,
//         textTheme: customTextTheme,

//         navigationBarTheme: NavigationBarThemeData(
//           backgroundColor: Colors.red.shade50,
//           height: 64,
//           labelTextStyle: MaterialStateProperty.all(GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.red.shade900),)
//         ),

//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             elevation: 0,
//             shape: const StadiumBorder(),
//           ),
//         ),
//         outlinedButtonTheme: OutlinedButtonThemeData(
//           style: OutlinedButton.styleFrom(
//             shape: const StadiumBorder(),
//           ),
//         ),
//         textButtonTheme: TextButtonThemeData(
//           style: TextButton.styleFrom(
//             shape: const StadiumBorder(),
//           ),
//         ),
//       ),
//       home: Welcome(),
//     );
//   }
// }
