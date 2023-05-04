// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'shared.dart';
import 'Welcome/Welcome.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

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
  // runApp(const MaterialApp(home:Arrived(args:{"latitude":24.90
  //59, "longitude":67.1383})));
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

