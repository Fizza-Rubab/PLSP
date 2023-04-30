import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps/Alert/Searching.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../input_design.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";


class Alert_Details extends StatefulWidget {
  const Alert_Details({Key? key}) : super(key: key);

  @override
  State<Alert_Details> createState() => _Alert_DetailsState();
}

class _Alert_DetailsState extends State<Alert_Details> {
  late SharedPreferences _prefs;
  String first_name = '';
  String last_name = '';
  String contact_no = '';
  String info = '';
  LatLng? _currentLocation;

  

  Future<void> _getCurrentLocation() async {
    final location = Location();
    try {
      final currentPosition = await location.getLocation();
      setState(() {
        _currentLocation = LatLng(
          currentPosition.latitude!,
          currentPosition.longitude!,
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }
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
      _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
  final AppLocalizations localizations = AppLocalizations.of(context)!;
  
  final Set<Marker> markers = new Set();
  
  markers.add(Marker( //add first marker
    markerId: MarkerId(_currentLocation.toString()),
    position: _currentLocation==null?LatLng(0.0,0.0):_currentLocation!, //position of marker
    infoWindow: InfoWindow( //popup info
      title: 'My current location',
      snippet: 'Lifesaver to come here',
    ),
    icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    return Scaffold(
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
      body: _currentLocation==null? Center(
              child: CircularProgressIndicator(),
            ):
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                    target: _currentLocation!,
                                    zoom: 15.0,
                                  ),
                                  mapType: MapType.normal,
                                  compassEnabled: true,
                                  markers: markers,
                                ),
                              ),
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
            TextField(
              decoration: buildInputDecoration(Icons.groups, "How Many Patients?", border: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),),
            
            const SizedBox(height: 3,),
            TextField(
              maxLines: 2,
              textAlignVertical: TextAlignVertical.top,
              decoration: buildInputDecoration(Icons.info, "Other Important Details (optional)", border: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
            ),
            const Spacer(flex: 2),
            Text("Caller's Information:",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colors.black45,
                )),
            const Spacer(flex: 2,),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: TextField(
                    controller: TextEditingController(text: first_name + ' ' + last_name),
                    decoration: buildInputDecoration(Icons.person, "Name", border: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  )),
                  ),
                ),
                const SizedBox(width: 4,),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: TextField(
                    controller: TextEditingController(text: contact_no),
                    decoration: buildInputDecoration(Icons.call, "Contact Number",border: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 6),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    fixedSize: Size(MediaQuery.of(context).size.width, 30),
                    textStyle: Theme.of(context).textTheme.bodyText2,
                  ),
                  onPressed: () {Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Searching(latitude: _currentLocation!.latitude, longitude: _currentLocation!.longitude)));
                      },
                  child: const Text('Launch Alert'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
