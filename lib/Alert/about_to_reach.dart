import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../arrived.dart';

class AboutToReach extends StatefulWidget {

  final Map<String, dynamic> args;
  const AboutToReach({Key? key, required this.args}) : super(key: key);

  @override
  State<AboutToReach> createState() => _AboutToReachState();
}

class _AboutToReachState extends State<AboutToReach> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(24.9059, 67.1383);
  static const LatLng destinationLocation = LatLng(24.8920, 67.0735);
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  startTime() async {
    var duration = new Duration(seconds:1);
    return new Timer(duration, route);
  }
  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Arrived(args:this.widget.args)
    )
    );
  }

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newloc) {
      currentLocation = newloc;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 18,
            target: LatLng(newloc.latitude!, newloc.longitude!),
          ),
        ),
      );
      setState(() {});
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAStNr3B-MFk6VIfCC9sIerlba-T1ek-8A",
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    // setCustomMarker();
    getPolyPoints();
    super.initState();
    startTime();
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
        // endDrawer: Drawer(
        //   child: SingleChildScrollView(
        //     child: Container(
        //       child: Column(
        //         children: [
        //           MyDrawerList(),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomButton(Icons.call),
              BottomButton_2(),
              BottomButton(Icons.message),
              BottomButton(Icons.share),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color.fromRGBO(255, 160, 161, 1)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text("Life Saver Is About To Reach",
            style: TextStyle(color: Colors.redAccent),),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {}),
        ),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height) / 1.5,
              child: currentLocation == null
                  ? const Center(
                      child: Text("Loading"),
                    )
                  : GoogleMap(
                    zoomGesturesEnabled: true, //enable Zoom in, out on map
                      minMaxZoomPreference: MinMaxZoomPreference(10, 20),
                      onCameraMove:(CameraPosition cameraPosition){
                      print(cameraPosition.zoom);},
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                          zoom: 10.0),
                      polylines: {
                        Polyline(
                          polylineId: PolylineId("route"),
                          points: polylineCoordinates,
                          color: Colors.pink,
                          width: 6,
                        )
                      },
                      markers: {
                        Marker(
                          markerId: const MarkerId("currentLocation"),
                          icon: BitmapDescriptor.defaultMarkerWithHue(240),
                          position: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                        ),
                        Marker(
                          markerId: MarkerId("source"),
                          // icon: sourceIcon,
                          position: sourceLocation,
                        ),
                        Marker(
                            markerId: MarkerId("destination"),
                            // icon: destinationIcon,
                            position: destinationLocation),
                      },
                      onMapCreated: (mapController) {
                        _controller.complete(mapController);
                      },
                    ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Stack(
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: 30.0, top: 10.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Harry Potter",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "+923331234567",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 15,
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
                          color: Color.fromRGBO(255, 241, 236, 1),
                          width: 2,
                        ),
                        image: DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fGh1bWFufGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
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

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [],
        // Details of life saver
      ),
    );
  }

  Widget DrawerListItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {});
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget BottomButton(IconData icon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ElevatedButton(
        onPressed: () {},
        child: Icon(icon, color: Colors.white),
        style: ElevatedButton.styleFrom(
          primary: Colors.redAccent,
          padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
        ),
      ),
    );
  }

  Widget BottomButton_2() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          "CANCEL",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.redAccent,
          padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
        ),
      ),
    );
  }
}
