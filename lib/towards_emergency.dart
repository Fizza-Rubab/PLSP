// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'myheaderdrawer.dart';
// import 'Alert/Alert_Details.dart';
// import 'arrived.dart';

// var subheading = TextStyle(
//   color: Colors.black45,
//   fontFamily: 'Poppins',
//   fontStyle: FontStyle.italic,
//   fontSize: 18,
// );

// var text = TextStyle(
//   color: Color.fromRGBO(146, 98, 81, 1),
//   fontFamily: 'Poppins',
//   fontSize: 18,
// );

// enum DrawerSections { dashboard, emergency, edit_profile }

// const appbar_icon_color = Color.fromRGBO(255, 160, 161, 1);

// class TowardsEmergency extends StatefulWidget {
//   final Map<String, dynamic> args;
//   const TowardsEmergency({Key? key, required this.args}) : super(key: key);

//   @override
//   State<TowardsEmergency> createState() => _TowardsEmergencyState();
// }

// class _TowardsEmergencyState extends State<TowardsEmergency> {
//   var currentPage;
//   @override
//   void initState() {
//     super.initState();
//     currentPage=DrawerSections.emergency;
//     startTime();
//   }

//   startTime() async {
//     var duration = new Duration(seconds: 10);
//     return new Timer(duration, route);
//   }
//   route() {
//     Navigator.pushReplacement(context, MaterialPageRoute(
//         builder: (context) => Arrived(args:this.widget.args)
//     )
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     final Set<Marker> markers = new Set();

//     markers.add(Marker(
//       //add first marker
//       markerId: MarkerId(LatLng(24.8920, 67.0747).toString()),
//       position: LatLng(24.8920, 67.0747), //position of marker
//       infoWindow: InfoWindow(
//         //popup info
//         title: 'Aga Khan University Hospital',
//         snippet: 'Health comes first!',
//       ),
//       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//     ));
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color.fromRGBO(255, 241, 236, 1),
//         appBar: AppBar(
//           iconTheme: IconThemeData(color: appbar_icon_color),
//           elevation: 0,
//           backgroundColor: Colors.red,
//           title: Center(
//             child: Text("Towards Emergency"),
//           ),
//           leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back,
//               ),
//               onPressed: () {
//                 // Navigator.of(context).push(
//                 //     MaterialPageRoute(builder: (context) => AlertDetails()));
//               }),
//         ),
//         endDrawer: Drawer(
//           child: SingleChildScrollView(
//             child: Container(
//               child: Column(
//                 children: [
//                   MyHeaderDrawer(),
//                   MyDrawerList(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: (MediaQuery.of(context).size.height) / 2.5,
//                 child: GoogleMap(
//                   initialCameraPosition: CameraPosition(
//                     target: LatLng(24.8920, 67.0747),
//                     zoom: 15.0,
//                   ),
//                   mapType: MapType.normal,
//                   compassEnabled: true,
//                   markers: markers,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//                 child: card_Header("Location:"),
//               ),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
//                 child: Container(
//                   height: (MediaQuery.of(context).size.height) / 15,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: card_decoration,
//                   child: TextFormField(
//                     textAlign: TextAlign.center,
//                     style: input_style,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.all(
//                           (MediaQuery.of(context).size.height) / 50),
//                       isDense: true,
//                     ),
//                   ),
//                 ),
//               ),
//               Row(
//                 children: [
//                   Column(
//                     children: [
//                       card_Header("No. of patients"),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(
//                             MediaQuery.of(context).size.width / 20, 0, 0, 10),
//                         child: Container(
//                           height: (MediaQuery.of(context).size.height) / 15,
//                           width: MediaQuery.of(context).size.width / 3.3,
//                           decoration: card_decoration,
//                           child: TextFormField(
//                             textAlign: TextAlign.center,
//                             initialValue: "1",
//                             style: input_style,
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               contentPadding: EdgeInsets.all(
//                                   (MediaQuery.of(context).size.height) / 45),
//                               isDense: true,
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       card_Header("Name of patient(s)"),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(
//                             MediaQuery.of(context).size.width / 20, 0, 0, 10),
//                         child: Container(
//                           height: (MediaQuery.of(context).size.height) / 15,
//                           width: MediaQuery.of(context).size.width / 1.8,
//                           decoration: card_decoration,
//                           child: TextFormField(
//                             textAlign: TextAlign.center,
//                             initialValue: "-",
//                             style: input_style,
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               contentPadding: EdgeInsets.all(
//                                   (MediaQuery.of(context).size.height) / 45),
//                               isDense: true,
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//               // Padding(
//               //   padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
//               //   child: card_Header("Other Details:"),
//               // ),
//               // Padding(
//               //   padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
//               //   child: Container(
//               //     height: (MediaQuery.of(context).size.height) / 15,
//               //     width: MediaQuery.of(context).size.width,
//               //     decoration: card_decoration,
//               //     child: TextFormField(
//               //       textAlign: TextAlign.center,
//               //       style: input_style,
//               //       decoration: InputDecoration(
//               //         border: InputBorder.none,
//               //         contentPadding: EdgeInsets.all(
//               //             (MediaQuery.of(context).size.height) / 45),
//               //         isDense: true,
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.redAccent, width: 4),
//                     borderRadius: BorderRadius.all(Radius.circular(
//                             10.0) //                 <--- border radius here
//                         ),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Caller: ",
//                             style: subheading,
//                           ),
//                           Text(
//                             "Mr. Dumbledore",
//                             style: text,
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Contact: ",
//                             style: subheading,
//                           ),
//                           Text(
//                             "0333-1234567",
//                             style: text,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           color: Colors.transparent,
//           elevation: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               BottomButton(Icons.call),
//               BottomButton_2(),
//               BottomButton(Icons.message),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget MyDrawerList() {
//     return Container(
//       padding: EdgeInsets.only(top: 15),
//       child: Column(
//         children: [
//           DrawerListItem(1, "Launch Alert", Icons.emergency,
//               currentPage == DrawerSections.emergency ? true : false),
//           DrawerListItem(2, "Dashboard", Icons.dashboard_outlined,
//               currentPage == DrawerSections.dashboard ? true : false),
//           DrawerListItem(3, "Edit Profile", Icons.edit,
//               currentPage == DrawerSections.edit_profile ? true : false),
//         ],
//         // Details of life saver
//       ),
//     );
//   }

//   Widget BottomButton(IconData icon) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
//       child: ElevatedButton(
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => TowardsEmergency(args:this.widget.args),
//           ));
//         },
//         child: Icon(icon, color: Colors.redAccent),
//         style: ElevatedButton.styleFrom(
//           primary: Colors.orangeAccent,
//           padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
//         ),
//       ),
//     );
//   }

//   Widget BottomButton_2() {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
//       child: ElevatedButton(
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => TowardsEmergency(args:this.widget.args),
//           ));
//         },
//         child: Text(
//           "CANCEL",
//           style: TextStyle(
//             color: Colors.redAccent,
//             fontFamily: 'Poppins',
//             fontSize: 15,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         style: ElevatedButton.styleFrom(
//           primary: Colors.orangeAccent,
//           padding: EdgeInsets.fromLTRB(60, 12, 60, 12),
//         ),
//       ),
//     );
//   }

//   Widget DrawerListItem(int id, String title, IconData icon, bool selected) {
//     return Material(
//       color: selected ? Colors.grey[300] : Colors.transparent,
//       child: InkWell(
//         onTap: () {
//           Navigator.pop(context);
//           setState(() {
//             if (id == 1) {
//               currentPage = DrawerSections.emergency;
//             } else if (id == 2) {
//               currentPage = DrawerSections.dashboard;
//             } else if (id == 3) {
//               currentPage = DrawerSections.edit_profile;
//             }
//           });
//         },
//         child: Padding(
//           padding: EdgeInsets.all(15.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Icon(
//                   icon,
//                   size: 20,
//                   color: Colors.black,
//                 ),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Text(
//                   title,
//                   style: TextStyle(color: Colors.black, fontSize: 16),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
