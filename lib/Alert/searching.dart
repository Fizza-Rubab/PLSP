import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../towards_emergency.dart';
import '../myheaderdrawer.dart';
import '../Home/Citizen_Home.dart';
import '../coming.dart';
import '../about_to_reach.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';


class Searching extends StatefulWidget {
  final Map<String, dynamic> args;
  const Searching({Key? key, required this.args}) : super(key: key);

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    startTime();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }
  startTime() async {
    var duration = new Duration(seconds: 299);
    return new Timer(duration, route);
  }
  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => AboutToReach(args:this.widget.args)
    )
    );
  }
  Widget build(BuildContext context) {
    final Set<Marker> markers = new Set();
    markers.add(Marker( //add first marker
      markerId: MarkerId(LatLng(24.9059, 67.1383).toString()),
      position: LatLng(24.9059, 67.1383), //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Aga Khan University Hospital',
        snippet: 'Health comes first!',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black54,
        title: Text("Emergency Details",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
              color: Colors.black45,
            )),
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
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height) / 1.5,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(24.9059, 67.1383),
                  zoom: 15.0,
                ),
                mapType: MapType.normal,
                compassEnabled: true,
                markers: markers,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Searching for Lifesaver Nearby",
                          style: GoogleFonts.poppins(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
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
                  ),
                ],
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
              
              BottomButton_2(),
             
            ],
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 10),
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
        onPressed: ()async{
          if (icon==Icons.call)
            launch("tel://03222336019");
          else {
            Uri sms = Uri.parse('sms:101022?body=your+text+here');
            if (await launchUrl(sms)) {
              //app opened
            } else {
              //app is not opened
            }
          }
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
      padding: EdgeInsets.fromLTRB(5,0,5,10),
      child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CitizenHome(),
            ));
          },
          child: Text(
            "CANCEL",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
            ),
          ),
          style: ElevatedButton.styleFrom(
            
            primary: Colors.redAccent,
            padding: EdgeInsets.fromLTRB(60, 12, 60, 12),
          ),
        ),
    );
  }
}
