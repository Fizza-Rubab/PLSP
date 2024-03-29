import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import '../input_design.dart';
import '../config.dart';
import '../constants.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import 'Lifesaver_Feedback.dart';

class LifesaverArrived extends StatefulWidget {
  final Map<String, dynamic> incident_obj;
  const LifesaverArrived({Key? key, required this.incident_obj}) : super(key: key);

  @override
  State<LifesaverArrived> createState() => _LifesaverArrivedState();
}

class _LifesaverArrivedState extends State<LifesaverArrived> {
  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        setState(() {
          currentLocation = location;  
        });
        ;
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = new Set();
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    markers.add(Marker(
      //add first marker
      markerId: MarkerId(
          LatLng(double.parse(widget.incident_obj['latitude'].toString()), double.parse(widget.incident_obj['longitude'].toString())).toString()),
      position: LatLng(double.parse(widget.incident_obj['latitude'].toString()), double.parse(widget.incident_obj['longitude'].toString())), //position of markerconst
      infoWindow: const InfoWindow(
        //popup info
        title: 'Incident Location',
        snippet: 'Please look around for caller',

      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    if (currentLocation!=null){
    markers.add(Marker(
      //add first marker
      //37.42681245606211, -122.08065576215935
      markerId: MarkerId(LatLng(currentLocation!.latitude!,
              currentLocation!.latitude!)
          .toString()),
      position: LatLng(currentLocation!.latitude!,
          currentLocation!.longitude!), //position of markerconst
      infoWindow: const InfoWindow(
        //popup info
        title: 'My Location',
        snippet: 'You have reached the place of incident',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueBlue), //Icon for Marker
    ));
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black54,
          title: Center(
            child: Text("You have Arrived",
                style: GoogleFonts.poppins(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colors.black45,
                )),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height) / 13,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                color: Colors.blue.shade50,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Lifesaver_Feedback(incident_obj:widget.incident_obj)));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade100),
                    child: Text(
                      "Verify arrival",
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height) * (9.6 / 19.6),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(double.parse(widget.incident_obj['latitude'].toString()), double.parse(widget.incident_obj['longitude'].toString())),
                  zoom: 15.0,
                ),
                mapType: MapType.normal,
                compassEnabled: true,
                markers: markers,
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                            padding: EdgeInsets.only(top: 0.0),
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
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Text(
                'Please locate and contact the citizen immediately. ',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: Colors.grey.shade800,
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BottomButton(Icons.call),
              BottomButton_2(context),
              BottomButton(Icons.message),
            ],
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: const [],
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
          padding: const EdgeInsets.all(10.0),
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
                  style: const TextStyle(color: Colors.black, fontSize: 16),
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
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ElevatedButton(
        onPressed: () async {
          if (icon == Icons.call)
          launch("tel://${widget.incident_obj['citizen_contact']}");
          else {
            Uri sms = Uri.parse('sms:${widget.incident_obj['citizen_contact']}?body=Hello, regarding emergency...');
            if (await launchUrl(sms)) {
              //app opened
            } else {
              //app is not opened
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget BottomButton_2(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Container(
                  child: AlertDialog(
                    title: const Text(
                      "Please verify your arrival to incident",
                      style: TextStyle(color: Colors.black45),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "YES",
                            style: TextStyle(color: Colors.redAccent),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "NO",
                            style: TextStyle(color: Colors.redAccent),
                          )),
                    ],
                  ),
                );
              });
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.redAccent,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        ),
        child: const Text(
          "CANCEL",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
