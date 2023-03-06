import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps/alert_details.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import "searching.dart";
import 'old_login.dart';
import 'package:geolocator/geolocator.dart';
import 'myheaderdrawer.dart';


const appbar_icon_color = Color.fromRGBO(255, 160, 161, 1);

var input_style = TextStyle(
  color: Color.fromRGBO(146, 98, 81, 1),
  fontFamily: 'Poppins',
);

const Profile_Name = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.black45,
  fontFamily: 'Poppins',
  fontSize: 20,
  letterSpacing: 0,
);

const role_style = TextStyle(
  color: Colors.black45,
  fontFamily: 'Poppins',
  // fontWeight: FontWeight.,
  fontSize: 18,
  letterSpacing: 0,
  fontStyle: FontStyle.italic,
);

enum DrawerSections { dashboard, emergency, edit_profile }

var card_decoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(211, 211, 211, 1),
      blurRadius: 3,
      offset: Offset(4, 5), // Shadow position
    ),
  ],
  border: Border.all(
      color: Color.fromRGBO(255, 222, 210, 1),
      width: 0.0,
      style: BorderStyle.solid),
  borderRadius: BorderRadius.circular(20),
  color: Color.fromRGBO(255, 222, 210, 1),
);

class HomePage extends StatefulWidget {
  final Map<String, dynamic> args;
  const HomePage({Key? key, required this.args}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 241, 236, 1),
        appBar: AppBar(
          iconTheme: IconThemeData(color: appbar_icon_color),
          elevation: 0,
          backgroundColor: Colors.red,
          title: Center(
            child: Text("Dashboard"),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
            onPressed: () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LogIn()))
            },),
        ),
        endDrawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  MyHeaderDrawer(),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.orange,
                radius: 60,
                child: CircleAvatar(
                  radius: 57,
                  backgroundImage: AssetImage('assets/images/profileicon.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height / 70, 0, 0),
                child: Text(
                  widget.args["first_name"] + ' ' + widget.args["last_name"] ,
                  style: Profile_Name,
                ),
              ),
              Divider(
                indent: 60,
                endIndent: 60,
                color: Colors.black45,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, 0, 0, MediaQuery.of(context).size.height / 70),
                child: Text(
                  "Citizen",
                  style: role_style,
                ),
              ),
              card_Header("Emergency Statistics"),
              Container(
                height: (MediaQuery.of(context).size.height) / 6,
                decoration: card_decoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          card_Header("Emergency Calls"),
                          card_detail_numb( widget.args['calls_made'].toString(),),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      indent: 30,
                      endIndent: 30,
                      color: Colors.black45,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          card_Header("Aid Received:"),
                          card_detail_numb( widget.args['calls_made'].toString(),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, 0, 0, MediaQuery.of(context).size.height / 70),
              ),
              card_Header("Emergency Track Record"),
              Container(
                height: (MediaQuery.of(context).size.height) / 11,
                decoration: card_decoration,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    // Column so that we can enter details here in future
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      card_Header("No Emergency"),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 5 , 0, 0)),
              TextButton(
                onPressed:  () async {
                  LocationPermission permission;
                  permission = await Geolocator.requestPermission();
                  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                  Map<String, dynamic> alert_args = new Map<String,dynamic>.from(widget.args);
                  alert_args.addAll({'latitude':position.latitude, 'longitude':position.longitude, 'timestamp':position.timestamp});
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AlertDetails(args:alert_args)));
                },
                child: Image.asset('assets/images/call_for_help.png', height:90,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Align card_detail_numb(String header_text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
      child: Text(
        header_text,
        style: TextStyle(
          color: Color.fromRGBO(146, 98, 81, 1),
          fontFamily: 'Poppins',
          fontSize: 37,
        ),
      ),
    ),
  );
}

Align card_Header(String header_text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
      child: Text(
        header_text,
        style: TextStyle(
            color: Color.fromRGBO(146, 98, 81, 1),
            fontFamily: 'Poppins',
            fontSize: 14,
            fontStyle: FontStyle.italic),
      ),
    ),
  );
}
//////////////////////////////////////////////////////////////////

//
//
// var input_style = TextStyle(
//   color: Color.fromRGBO(146, 98, 81, 1),
//   fontFamily: 'Poppins',
// );
//
// const Profile_Name = TextStyle(
//   fontWeight: FontWeight.bold,
//   color: Colors.black45,
//   fontFamily: 'Poppins',
//   fontSize: 20,
//   letterSpacing: 0,
// );
//
// const role_style = TextStyle(
//   color: Colors.black45,
//   fontFamily: 'Poppins',
//   fontWeight: FontWeight.bold,
//   fontSize: 20,
//   letterSpacing: 0,
// );
//
// var card_decoration = BoxDecoration(
//   boxShadow: [
//     BoxShadow(
//       color: Color.fromRGBO(211, 211, 211, 1),
//       blurRadius: 3,
//       offset: Offset(4, 5), // Shadow position
//     ),
//   ],
//   border: Border.all(
//       color: Color.fromRGBO(255, 222, 210, 1),
//       width: 0.0,
//       style: BorderStyle.solid),
//   borderRadius: BorderRadius.circular(20),
//   color: Color.fromRGBO(255, 222, 210, 1),
// );
//
// class HomePage extends StatefulWidget {
//   final Map<String, dynamic> args;
//   const HomePage({Key? key, required this.args}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color.fromRGBO(255, 255, 255, 1),
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(240),
//           child: AppBar(
//             backgroundColor: Color.fromRGBO(255, 255, 255, 1),
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: Colors.red,
//               ),
//               onPressed: () => {
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (context) => LogIn()))
//               },
//             ),
//             elevation: 0,
//             flexibleSpace: Padding(
//               padding: EdgeInsets.fromLTRB(40.0, 25.0, 40.0, 0),
//               child: Column(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.orange,
//                     radius: 70,
//                     child: CircleAvatar(
//                       radius: 65,
//                       backgroundImage: AssetImage('assets/images/profileicon.png'),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                     child: Text(
//                       widget.args["first_name"] + ' ' + widget.args["last_name"] ,
//                       style: Profile_Name,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                     child: Text(
//                       "Citizen",
//                       style: role_style,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: Container(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
//             child: Column(children: [
//               Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(22, 0, 20, 0),
//                     child: Column(
//                       children: [
//                         Text(
//                           "Number of calls made",
//                           style: role_style,
//                         ),
//                         Text(
//                           widget.args['calls_made'].toString(),
//                           style: TextStyle(fontSize: 50),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                     child: Column(
//                       children: [
//                         Text(
//                           "Lives saved",
//                           style: role_style,
//                         ),
//                         Text(
//                           "0",
//                           style: TextStyle(fontSize: 50),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               Center(
//                 child: Row(
//                   children: [
//                     Padding(
//                         padding: EdgeInsets.fromLTRB(40, 40, 0, 0),
//                         child: InkWell(
//                           onTap: () async {
//                             LocationPermission permission;
//                             permission = await Geolocator.requestPermission();
//                             Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//                             Map<String, dynamic> alert_args = new Map<String,dynamic>.from(widget.args);
//                             alert_args.addAll({'latitude':position.latitude, 'longitude':position.longitude, 'timestamp':position.timestamp});
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => AlertDetails(args:alert_args)));
//                           }, // Image tapped
//                           splashColor:
//                               Colors.white10, // Splash color over image
//                           child: Ink.image(
//                             fit: BoxFit.cover, // Fixes border issues
//                             width: 275,
//                             height: 120,
//                             image: AssetImage('assets/images/call.jpg'),
//                           ),
//                         )
//                         // child: IconButton(
//                         //   icon: Image.asset('assets/images/call.jpg'),
//                         //   iconSize: 350,
//                         //   onPressed: () {},
//                         // ),
//                         ),
//                   ],
//                 ),
//               ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// EdgeInsets page_padding(BuildContext context) {
//   var right = MediaQuery.of(context).size.width / 20;
//   var top = 0.0;
//   var left = MediaQuery.of(context).size.width / 20;
//   var bottom = MediaQuery.of(context).size.height / 80;
//
//   return EdgeInsets.fromLTRB(left, top, right, bottom);
// }
//
// Align card_Header(String header_text) {
//   return Align(
//     alignment: Alignment.centerLeft,
//     child: Padding(
//       padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
//       child: Text(
//         header_text,
//         style: TextStyle(
//             color: Color.fromRGBO(146, 98, 81, 1),
//             fontFamily: 'Poppins',
//             fontSize: 14,
//             fontStyle: FontStyle.italic),
//       ),
//     ),
//   );
// }
