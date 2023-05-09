// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';
import 'Arrival.dart';
import '../config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class AboutToReach extends StatefulWidget {
  final LatLng destinationLocation;
  final Map<String, dynamic> incident_obj;

  const AboutToReach({super.key, required this.destinationLocation, required this.incident_obj});

  @override
  State<AboutToReach> createState() => _AboutToReachState();
}

class _AboutToReachState extends State<AboutToReach> {
  final Completer<GoogleMapController> _controller = Completer();
  // static const LatLng sourceLocation = LatLng(24.8918, 67.0731);
  // static const LatLng destinationLocation = LatLng(24.9061, 67.1384);
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;

  List<LatLng> polylineCoordinates = [];
  LatLng? currentLocation;
  late Timer _timer;

  startTime() async {
    var duration = const Duration(seconds: 20);
    return Timer(duration, endRoute);
  }

  endRoute() {
    _timer.cancel();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Arrived(destinationLocation:currentLocation!, incident_obj: widget.incident_obj)));
  }
  LocationData convertLatLngToLocationData(double latitude, double longitude) {
  return LocationData.fromMap({
    "latitude": latitude,
    "longitude": longitude,
    "accuracy": 0.0,
    "altitude": 0.0,
    "speed": 0.0,
    "speed_accuracy": 0.0,
    "heading": 0.0,
    "time": DateTime.now().millisecondsSinceEpoch,
    "is_mock": false,
    "altitude_accuracy": 0.0,
  });
  }

  void getCurrentLocation() async {
    print("fetching location from ""${ApiConstants.baseUrl}${ApiConstants.lifesaverEndpoint}/${widget.incident_obj['lifesaver']}");
    final http.Response ls_result = await http.get(Uri.parse("${ApiConstants.baseUrl}${ApiConstants.lifesaverEndpoint}/${widget.incident_obj['lifesaver']}"));
    if (ls_result.statusCode == 200) {
      print(ls_result);
      final data = json.decode(ls_result.body);
      final latitude = data['latitude'] as double;
      final longitude = data['longitude'] as double;
      // final LocationData ld = convertLatLngToLocationData(latitude, longitude);
      setState(() {
        currentLocation = LatLng(latitude, longitude);
      });
      // Assuming currentLocation and destination are both LatLng objects
    double distanceInMeters = Geolocator.distanceBetween(
    currentLocation!.latitude,
    currentLocation!.longitude,
    widget.destinationLocation.latitude,
    widget.destinationLocation.longitude,
    );
    print(widget.destinationLocation.toString());
    print("distance "+ distanceInMeters.toString());
    if (distanceInMeters<8){
      _timer.cancel();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Arrived(destinationLocation:currentLocation!, incident_obj: widget.incident_obj)),
            (Route<dynamic> route) => false
            );
    }
    GoogleMapController googleMapController = await _controller.future;
    print('${currentLocation!.latitude} ${currentLocation!.longitude}');
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 18,
          target: LatLng(currentLocation!.latitude, currentLocation!.longitude),
        ),
      ),
    );
  }
  }

  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     api_key,
  //     PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //     PointLatLng(widget.destinationLocation.latitude, widget.destinationLocation.longitude),
  //   );

  //   if (result.points.isNotEmpty) {
  //     for (var point in result.points) {
  //       polylineCoordinates.add(
  //         LatLng(point.latitude, point.longitude),
  //       );
  //     }
  //     if (this.mounted) {
  //     setState(() {});
  //     }
  //   }
  // }


  @override
  void initState() {
    getCurrentLocation();
    // setCustomMarker();
    //getPolyPoints();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      getCurrentLocation();
    });
    super.initState();
    // startTime();
  }

  void setCustomMarker() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_source.png")
        .then((icon) => destinationIcon = icon);
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_source.png")
        .then((icon) => sourceIcon = icon);
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_source.png")
        .then((icon) => currentIcon = icon);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomButton(Icons.call),
              BottomButton_2(),
              BottomButton(Icons.message),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme:
              const IconThemeData(color: Color.fromRGBO(255, 160, 161, 1)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Lifesaver is on his Way",
            style: GoogleFonts.poppins(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
              color: Colors.redAccent,
            )
          ),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {}),
        ),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height) / 1.6,
              child: currentLocation == null
                  ?  Center(
                      child: Text("Loading",
                      style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      color: Colors.black45,
                    )),
                    )
                  : GoogleMap(
                      zoomGesturesEnabled: true, //enable Zoom in, out on map
                      minMaxZoomPreference: const MinMaxZoomPreference(10, 20),
                      onCameraMove: (CameraPosition cameraPosition) {
                        print(cameraPosition.zoom);
                      },
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation!.latitude,
                              currentLocation!.longitude),
                          zoom: 10.0),
                      // polylines: {
                      //   Polyline(
                      //     polylineId: const PolylineId("route"),
                      //     points: polylineCoordinates,
                      //     color: Colors.redAccent,
                      //     width: 6,
                      //   )
                      // },
                      markers: {
                        Marker(
                          markerId: const MarkerId("currentLocation"),
                          icon: BitmapDescriptor.defaultMarkerWithHue(240),
                          position: LatLng(currentLocation!.latitude,
                              currentLocation!.longitude),
                              infoWindow: InfoWindow(
                                title: widget.incident_obj['lifesaver_name'],
                                snippet: 'Lifesaver approaching',
                              ),
                        ),
                        // Marker(
                        //   markerId: MarkerId("source"),
                        //   // icon: sourceIcon,
                        //   position: sourceLocation,
                        // ),
                        Marker(
                            markerId: const MarkerId("destination"),
                            // icon: destinationIcon,
                            position: widget.destinationLocation,
                            infoWindow: InfoWindow(
                                title: "Incident Location",
                                snippet: 'Called for help',
                              )
                              ),
                                                     
                            
                      },
                      onMapCreated: (mapController) {
                        _controller.complete(mapController);
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Stack(
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 30.0, top: 10.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            widget.incident_obj['lifesaver_name'],
                            style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                            color: Colors.white,
                          ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: Text(
                              widget.incident_obj['lifesaver_contact'],
                              style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                            color: Colors.white,
                          ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromRGBO(173, 78, 40, 1.0),
                          width: 2,
                        ),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/profileicon.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget MyDrawerList() {
  //   return Container(
  //     padding: const EdgeInsets.only(top: 15),
  //     child: Column(
  //       children: [],
  //       // Details of life saver
  //     ),
  //   );
  // }

  // Widget DrawerListItem(int id, String title, IconData icon, bool selected) {
  //   return Material(
  //     color: selected ? Colors.grey[300] : Colors.transparent,
  //     child: InkWell(
  //       onTap: () {
  //         Navigator.pop(context);
  //         setState(() {});
  //       },
  //       child: Padding(
  //         padding: const EdgeInsets.all(15.0),
  //         child: Row(
  //           children: [
  //             Expanded(
  //               child: Icon(
  //                 icon,
  //                 size: 20,
  //                 color: Colors.black,
  //               ),
  //             ),
  //             Expanded(
  //               flex: 3,
  //               child: Text(
  //                 title,
  //                 style: const TextStyle(color: Colors.black, fontSize: 16),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget BottomButton(IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ElevatedButton(
        onPressed: ()async{
          if (icon==Icons.call)
            launch("tel://03222336019");
          else {
            Uri sms = Uri.parse('sms:03222336019?body=Hello Lifesaver');
            if (await launchUrl(sms)) {
              //app opened
            } else {
              //app is not opened
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget BottomButton_2() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        ),
        child: const Text(
          "Cancel",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
