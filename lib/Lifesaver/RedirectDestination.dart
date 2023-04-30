import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps/Lifesaver/Lifesaver.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../input_design.dart';
import 'NavigateScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import '../appbar.dart'; 

class RedirectDestination extends StatefulWidget {
  const RedirectDestination({Key? key}) : super(key: key);

  @override
  State<RedirectDestination> createState() => _RedirectDestinationState();
}

class _RedirectDestinationState extends State<RedirectDestination> {
  late SharedPreferences _prefs;
  String first_name = '';
  String last_name = '';
  String contact_no = '';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        first_name = _prefs.getString('first_name') ?? '';
        last_name = _prefs.getString('last_name') ?? '';
        contact_no = _prefs.getString('contact_no') ?? '';
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = new Set();
  markers.add(Marker( //add first marker
    markerId: MarkerId(LatLng(24.8918, 67.0731).toString()),
    position: LatLng(24.90587, 67.3827), //position of marker
    infoWindow: InfoWindow( //popup info
      title: 'My current location',
      snippet: 'Lifesaver to come here',
    ),
    icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SimpleAppBar("Emergency Details") , 
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Caller's Information:",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colors.black45,
                )),
            const Spacer(flex: 2),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: TextField(
                    controller: TextEditingController(text: "Aiman Naqvi"),
                    decoration: buildInputDecoration(Icons.person, "Name", border: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    
                  )),
                  readOnly:true,
                  ),
                ),
                const SizedBox(width: 4,),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: TextField(
                    controller: TextEditingController(text: "03454181960"),
                    decoration: buildInputDecoration(Icons.call, "Contact Number",border: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 2),
            Text("Patient's Information:",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colors.black45,
                )),
            const Spacer(flex: 2,),
            TextFormField(
              initialValue: '1',
              decoration: buildInputDecoration(Icons.groups, "How Many Patients?", border: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
                  readOnly: true,
                  ),
            
            const SizedBox(height: 3,),
            TextFormField(
              initialValue: 'Cardiac Arrest Case, low pulse',
              maxLines: 1,
              textAlignVertical: TextAlignVertical.top,
              decoration: buildInputDecoration(Icons.info, "Other Important Details (optional)", border: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
              readOnly: true,
            ),
            const Spacer(flex: 2,),
            
            TextField(
              decoration: buildInputDecoration(Icons.location_on, "Location of Emergency",
                  border: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
            ),
            Container(
              height: MediaQuery.of(context).size.height * (1 / 4),
              decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
                child: SizedBox(
                                width: double.infinity,
                                height:  (MediaQuery.of(context).size.height) / 2.5,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(24.90587, 67.3827),
                                    zoom: 15.0,
                                  ),
                                  mapType: MapType.normal,
                                  compassEnabled: true,
                                  markers: markers,
                                ),
                              ),
            ),
            const Spacer(flex: 6),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 50,
                child: Center(
                  child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.redAccent,
                          textStyle: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MapScreen(args: {})));
                        },
                        child: Text(
                          'Take me there!',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                              color: Colors.grey.shade100),
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
