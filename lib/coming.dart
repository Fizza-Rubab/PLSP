import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'towards_emergency.dart';
import 'myheaderdrawer.dart';
import 'arrived.dart';

class Coming extends StatefulWidget {
  final Map<String, dynamic> args;
  const Coming({Key? key, required this.args}) : super(key: key);

  @override
  State<Coming> createState() => _ComingState();
}

class _ComingState extends State<Coming> {
  @override
  void initState() {
    super.initState();
    startTime();
  }
  startTime() async {
    var duration = new Duration(seconds: 15);
    return new Timer(duration, route);
  }
  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Arrived(args:this.widget.args)
    )
    );
  }
  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = new Set();
    Set<Polyline> _polylines = {};
    GoogleMapController _controller;

// this will hold each polyline coordinate as Lat and Lng pairs
    List<LatLng> routeCoords;

// this is the key object - the PolylinePoints
// which generates every polyline between start and finish
    PolylinePoints polylinePoints = PolylinePoints();
    markers.add(Marker(
      //add first marker
      markerId: MarkerId(LatLng(this.widget.args['latitude'], this.widget.args['longitude']).toString()),
      position: LatLng(this.widget.args['latitude'], this.widget.args['longitude']), //position of markerconst
      infoWindow: const InfoWindow(
        //popup info
        title: 'My Location',
        snippet: 'Here',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    markers.add(Marker(
      //add first marker
      //24.909401386474187, 67.13412843984875
      markerId: MarkerId(LatLng(24.909401386474187, 67.13412843984875).toString()),
      position: LatLng(24.909401386474187, 67.13412843984875), //position of markerconst
      infoWindow: const InfoWindow(
        //popup info
        title: 'Lifesavers Location',
        snippet: 'Lifesaver here',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), //Icon for Marker
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 241, 236, 1),
        appBar: AppBar(
          // iconTheme: IconThemeData(color: appbar_icon_color),
          elevation: 0,
          backgroundColor: Colors.red,
          title: Center(
            child: Text("Life Saver Is About To Reach",
            style: TextStyle(
              fontSize: 17.0,
            ),),
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
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(this.widget.args['latitude'], this.widget.args['longitude']),
                  zoom: 15.0,
                ),
                mapType: MapType.normal,
                compassEnabled: true,
                markers: markers,
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
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: 30.0, top: 10.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Sameer Pervez",
                            style: TextStyle(
                              color: Colors.black45,
                              fontFamily: "Poppins",
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "+923331234567",
                              style: TextStyle(
                                color: Colors.black45,
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
        endDrawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  MyHeaderDrawer(),
                  MyDrawerList(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BottomButton(Icons.call),
              BottomButton_2(),
              BottomButton(Icons.message),
              BottomButton(Icons.share),
            ],
          ),
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller){
    setState(() {
      controller = controller;
    });

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
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => TowardsEmergency(args:this.widget.args),
          // ));
        },
        child: Icon(icon, color: Colors.redAccent),
        style: ElevatedButton.styleFrom(
          primary: Colors.orangeAccent,
          padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
        ),
      ),
    );
  }

  Widget BottomButton_2() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: ElevatedButton(
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => TowardsEmergency(args: this.widget.args,),
          // ));
        },
        child: Text(
          "CANCEL",
          style: TextStyle(
            color: Colors.redAccent,
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.orangeAccent,
          padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
        ),
      ),
    );
  }
}
