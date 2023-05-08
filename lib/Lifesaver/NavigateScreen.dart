import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps/Lifesaver/Lifesaver_Arrival.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../config.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";


class MapScreen extends StatefulWidget {
  final Map<String, dynamic> incident_obj;
  const MapScreen({Key? key, required this.incident_obj}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? sourceLocation;
  late LatLng destinationLocation;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  // late Timer _timer;
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  // startTime() async {
  //   var duration = const Duration(seconds: 60);
  //   return Timer(duration, endRoute);
  // }

  // endRoute() {
  //   _timer.cancel();
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => LifesaverArrived(incident_obj:widget.incident_obj)));
  // }

void getSourceLocation() async {
  // Check if permission is granted
  // PermissionStatus permissionStatus = await Location().hasPermission();
  // if (permissionStatus == PermissionStatus.granted) {
    // Permission is granted, get location data
    final locationData = await Location().getLocation();
    setState(() {
      sourceLocation = LatLng(locationData.latitude!, locationData.longitude!);  
    });
    print('Current location: ${sourceLocation!.latitude}, ${sourceLocation!.longitude}');
    getPolyPoints();
  // } else {
  //   // Permission is not granted, request permission
  //   permissionStatus = await Location().requestPermission();
  //   if (permissionStatus == PermissionStatus.granted) {
  //     // Permission granted, get location data
  //     final locationData = await Location().getLocation();
  //     setState(() {
  //       sourceLocation = LatLng(locationData.latitude!, locationData.longitude!);  
  //     });
  //     print('Current location: ${sourceLocation!.latitude}, ${sourceLocation!.longitude}');
  //     getPolyPoints();
  //   } else {
  //     // Permission denied, handle accordingly
  //     print('Location permission denied');
  //   }
  // }
}


  void getCurrentLocation() async {
      var status = await Location().hasPermission();
      print(status.toString());
      if (status == PermissionStatus.denied) {
        status = await Location().requestPermission();
        if (status != PermissionStatus.granted) {
          // handle permission not granted
          return;
        }
      }


    Location location = Location();
    location.getLocation().then(
      (location) {
        setState(() {
          currentLocation = location;
          sourceLocation =  LatLng(location!.latitude!, location!.longitude!);
        });
        print("currentLocation" + currentLocation.toString());
        print("sourceLocation" + sourceLocation.toString());
        getPolyPoints();

        // sourceLocation = LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
      },
    );

    // if (currentLocation!=null){
    // double distanceInMeters = await Geolocator.distanceBetween(
    // currentLocation!.latitude!,
    // currentLocation!.longitude!,
    // widget.incident_obj['latitude'],
    // widget.incident_obj['latitude'],
    // );
    // print(widget.incident_obj['latitude'].toString());
    // print("distance "+ distanceInMeters.toString());
    // if (distanceInMeters<8){
    //   _timer.cancel();
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => LifesaverArrived(incident_obj:widget.incident_obj)));
    // }
    // }
    
    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newloc) async {
      currentLocation = newloc;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 18,
            target: LatLng(newloc.latitude!, newloc.longitude!),
          ),
        ),
      );
      // if (this.mounted) {
      // setState(() {});
      // }
    //   double distanceInMeters = await Geolocator.distanceBetween(
    // currentLocation!.latitude!,
    // currentLocation!.longitude!,
    // widget.incident_obj['latitude'],
    // widget.incident_obj['latitude'],
    // );
    // print(widget.incident_obj['latitude'].toString());
    // print("distance "+ distanceInMeters.toString());
    // if (distanceInMeters<8){
    //   // _timer.cancel();
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => LifesaverArrived(incident_obj:widget.incident_obj)));
    // }
      print("currentLocation" + currentLocation.toString());
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      api_key,
      PointLatLng(sourceLocation!.latitude, sourceLocation!.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      if (this.mounted) {
      setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print("in after init state");
    destinationLocation = LatLng(double.parse(widget.incident_obj['latitude'].toString()), double.parse(widget.incident_obj['longitude'].toString()));
    getSourceLocation();
    print("source gotton");

    getCurrentLocation();
    print("current gotten");

    // sourceLocation = currentLocation==null?LatLng(24.90501,67.1380108):LatLng(currentLocation!.latitude!, currentLocation!.longitude!);    // setCustomMarker();
    // getPolyPoints();
    // startTime();
    // _timer = Timer.periodic(Duration(seconds: 3), (timer) {
    //   getCurrentLocation();
    // });
    // Timer.run(() { })
    // getCurrentLocation();
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
    final AppLocalizations localizations = AppLocalizations.of(context)!;
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
            "Taking you to the accident",
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
            Text('Please follow these directions', style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
              color: Colors.grey,
            )),
            SizedBox(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height) / 1.8,
              child: currentLocation == null || sourceLocation == null
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
                          target: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                          zoom: 10.0),
                      polylines: {
                        Polyline(
                          polylineId: const PolylineId("route"),
                          points: polylineCoordinates,
                          color: Colors.redAccent,
                          width: 6,
                        )
                      },
                      markers: {
                        Marker(
                          markerId: const MarkerId("currentLocation"),
                          infoWindow: InfoWindow(
                                title: 'Current Location',
                                snippet: 'Current Location',
                              ),
                          icon: BitmapDescriptor.defaultMarkerWithHue(240),
                          position: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                        ),
                        Marker(
                          markerId: MarkerId("source"),
                          infoWindow: InfoWindow(
                                title: 'Source Location',
                                snippet: 'Source Location',
                              ),
                          // icon: sourceIcon,
                          position: sourceLocation!,
                        ),
                        Marker(
                            markerId: MarkerId("destination"),
                            // icon: destinationIcon,
                            infoWindow: InfoWindow(
                                title: 'Incident Location',
                                snippet: 'Incident Location',
                              ),
                            position: destinationLocation),
                      },
                      onMapCreated: (mapController) {
                        _controller.complete(mapController);
                      },
                    ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                "Help requested by",
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
                color: Colors.redAccent,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
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
                            widget.incident_obj['citizen_name'],
                            style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                            color: Colors.white,
                          ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 1.0),
                            child: Text(
                              widget.incident_obj['citizen_contact'],
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
        onPressed: () {},
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
