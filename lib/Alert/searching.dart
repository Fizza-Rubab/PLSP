// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps/Lifesaver/Lifesaver.dart';
import 'package:google_maps/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Home/Citizen.dart';
import 'About_To_Reach.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import '../appbar.dart';

import 'package:http/http.dart' as http;

class Searching extends StatefulWidget {
  final double latitude;
  final double longitude;
  final Map<String, dynamic> incident_obj;

  Searching({required this.latitude, required this.longitude, required this.incident_obj});
  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching>
  with SingleTickerProviderStateMixin {
  late AnimationController controller;
  int lifesaver_id = 2;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    // startTime();
    startTimer();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  // startTime() async {
  //   var duration = const Duration(seconds: 20);
  //   return Timer(duration, route);
  // }

  // route() {
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) => AboutToReach(destinationLocation: LatLng(widget.latitude, widget.longitude), incident: widget.incident, lifesaver: lifesaver_id)));
  // }

    void startTimer() {
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) async {
      // hit the API to check if any lifesaver has accepted the request
      print('url ' + '${ApiConstants.baseUrl}/incident/${widget.incident_obj['id']}/accept');
      var response = await http.get(Uri.parse('${ApiConstants.baseUrl}/incident/${widget.incident_obj['id']}/status'));
      if (response.statusCode == 200) {
        print('response ' + response.body.toString());
        var data = jsonDecode(response.body);
        if (data["status"]=='accepted') {
          t.cancel(); // stop the timer
          Map<String, dynamic> incident_obj_updated = data;
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AboutToReach(destinationLocation: LatLng(widget.latitude, widget.longitude), incident_obj: incident_obj_updated)));
        }
      }
    });
  }

  // stop the timer when the widget is disposed
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final Set<Marker> markers = {};
    markers.add(Marker(
      //add first marker
      markerId: MarkerId(LatLng(widget.latitude, widget.longitude).toString()),
      position: LatLng(widget.latitude, widget.longitude), //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Aga Khan University Hospital',
        snippet: 'Health comes first!',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: SimpleAppBar(
            localizations.finding_lifesaver_nearby),
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.latitude, widget.longitude),
                  zoom: 15.0,
                ),
                mapType: MapType.normal,
                compassEnabled: true,
                markers: markers,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Text(
                            localizations.stay_calm,
                            style: GoogleFonts.poppins(
                              color: Colors.blue.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                localizations.stay_calm_desc,
                                style: GoogleFonts.lato(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              Center(
                                child: LoadingAnimationWidget.hexagonDots(
                                  color: Colors.redAccent,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BottomButton_2(localizations),
            ],
          ),
        ),
      ),
    );
  }

//   Widget MyDrawerList() {
//     return Container(
//       padding: const EdgeInsets.only(top: 10),
//       child: Column(
//         children: [],
//         // Details of life saver
//       ),
//     );
//   }

//   Widget DrawerListItem(int id, String title, IconData icon, bool selected) {
//     return Material(
//       color: selected ? Colors.grey[300] : Colors.transparent,
//       child: InkWell(
//         onTap: () {
//           Navigator.pop(context);
//           setState(() {});
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
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
//                   style: const TextStyle(color: Colors.black, fontSize: 16),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget BottomButton(IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//       child: ElevatedButton(
//         onPressed: () async {
//           if (icon == Icons.call)
//             launch("tel://03222336019");
//           else {
//             Uri sms = Uri.parse('sms:101022?body=your+text+here');
//             if (await launchUrl(sms)) {
//               //app opened
//             } else {
//               //app is not opened
//             }
//           }
//         },
//         child: Icon(icon, color: Colors.redAccent),
//         style: ElevatedButton.styleFrom(
//           primary: Colors.orangeAccent,
//           padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
//         ),
//       ),
//     );
//   }

  Widget BottomButton_2(localizations) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Citizen(),
          ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.fromLTRB(60, 12, 60, 12),
        ),
        child: Text(
          localizations.cancel,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
