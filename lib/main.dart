// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_maps/Alert/Arrival.dart';
// import 'package:google_maps/Home/Citizen_History.dart';
// import 'package:google_maps/Lifesaver/Lifesaver.dart';
import 'shared.dart';
import 'Welcome/OTP.dart'; 

import 'Welcome/ForgotPassword.dart';
import 'Welcome/Welcome.dart';
import 'Home/Citizen.dart';
import 'Lifesaver/Lifesaver_Home.dart';
import 'Lifesaver/Lifesaver_History.dart';
import 'Alert/searching.dart';

import 'Alert/about_to_reach.dart';
import 'Lifesaver/Lifesaver_Feedback.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'Welcome/Register.dart'; 

void main() {
  AwesomeNotifications().initialize(
    'resource://drawable/res_img_test',
    [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'basic notifications',
          defaultColor: Colors.redAccent,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          )
    ],
  );
  sharedPrefInit();
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(const MaterialApp(home:Arrived(args:{"latitude":24.9059, "longitude":67.1383})));
  runApp( GetMaterialApp(home: Welcome()));   //Welcome
}

// void main(){
//   sharedPrefInit();
//   runApp(MaterialApp(
//       home:AboutToReach(args: {"latitude":24.9059, "longitude":24.9059},)))
//       ;
//   }
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
