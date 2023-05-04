import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../appbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants.dart';
import '../input_design.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'searching.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:http/http.dart' as http;

class Alert_Details extends StatefulWidget {
  const Alert_Details({Key? key}) : super(key: key);

  @override
  State<Alert_Details> createState() => _Alert_DetailsState();
}

class _Alert_DetailsState extends State<Alert_Details> {
  late SharedPreferences _prefs;
  // String first_name = '';
  // String last_name = '';
  // String contact_no = '';

  //number of patients
  final _quantityController = TextEditingController(text: 1.toString());
  final _addressController = TextEditingController(text: "Address");
  final _callercontactController = TextEditingController(text: "");
  final _callernameController = TextEditingController(text: "");
  final _detailsController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        String first_name = _prefs.getString('first_name') ?? '';
        String last_name = _prefs.getString('last_name') ?? '';
        _callercontactController.text = _prefs.getString('contact_no') ?? '';
        _callernameController.text = first_name + ' ' + last_name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = new Set();
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    markers.add(Marker(
      //add first marker
      markerId: MarkerId(LatLng(24.8918, 67.0731).toString()),
      position: LatLng(24.90587, 67.3827), //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'My current location',
        snippet: 'Lifesaver to come here',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SimpleAppBar(localizations.emergency_details),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: TextEditingController(text: _addressController.text),
              decoration: buildInputDecoration(
                  Icons.location_on, localizations.emergency_location,
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
                height: (MediaQuery.of(context).size.height) / 2.5,
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
            const Spacer(flex: 2),
            Text(localizations.patients_information,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colors.black45,
                )),
            const Spacer(
              flex: 2,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _quantityController,
              decoration: buildInputDecoration(
                  Icons.groups, localizations.patient_quantity,
                  border: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
            ),
            const SizedBox(
              height: 3,
            ),
            TextField(
              controller: _detailsController,
              maxLines: 2,
              textAlignVertical: TextAlignVertical.top,
              decoration:
                  buildInputDecoration(Icons.info, localizations.other_details,
                      border: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      )),
            ),
            const Spacer(flex: 2),
            Text(localizations.caller_information,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colors.black45,
                )),
            const Spacer(
              flex: 2,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: TextField(
                    readOnly: true,
                    controller:
                        TextEditingController(text: _callernameController.text),
                    decoration: buildInputDecoration(
                      Icons.person,
                      localizations.name,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: TextField(
                    readOnly: true,
                    controller: _callercontactController,
                    decoration: buildInputDecoration(
                      Icons.call,
                      localizations.contact,
                    ),
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
                  onPressed: () async {
                    print('here' +
                        ApiConstants.baseUrl +
                        ApiConstants.incidentEndpoint);

                    ///////////////////// checks
                    int number = 1;
                    try {
                      number = int.parse(_quantityController.text);
                    } catch (e) {
                      number = 1; //default
                    }

                    ////////////////////////////
                    print({
                      "location": _addressController.text,
                      "latitude": 24.9077,
                      "longitude": 67.13913,
                      "info": "Heart Attack",
                      "created": DateTime.now().toString(),
                      "updated": DateTime.now().toString(),
                      "no_of_patients": number,
                      "status": "launched",
                      "lifesaver": null,
                      "citizen": await SharedPreferences.getInstance()
                          .then((prefs) => prefs.getString('id') ?? '')
                    });

                    final http.Response result = await http.post(
                        Uri.parse(ApiConstants.baseUrl +
                            ApiConstants.incidentEndpoint),
                        body: jsonEncode({
                          "location": _addressController.text,
                          "latitude": 24.9077,
                          "longitude": 67.13913,
                          "info": _detailsController.text,
                          "created": DateTime.now().toString(),
                          "updated": DateTime.now().toString(),
                          "no_of_patients": number,
                          "status": "launched",
                          "lifesaver": null,
                          "citizen": await SharedPreferences.getInstance()
                              .then((prefs) => prefs.getString('id') ?? '')
                        }),
                        headers: {
                          'Accept': 'application/json',
                          'Content-Type': 'application/json'
                        });

                    Map<String, dynamic> body = json.decode(result.body);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Searching(
                              args: {"latitude": 24.9059, "longitude": 24.9059},
                            )));
                  },
                  child: Text(localizations.launch_alert),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
