// ignore_for_file: file_names, camel_case_types, avoid_print, non_constant_identifier_names, use_build_context_synchronously, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_webservice/places.dart';
import '../appbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../config.dart';
import '../constants.dart';
import '../input_design.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'searching.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as loc;
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';

// class Alert_Details extends StatefulWidget {
//   const Alert_Details({Key? key}) : super(key: key);

//   @override
//   State<Alert_Details> createState() => _Alert_DetailsState();
// }

// class _Alert_DetailsState extends State<Alert_Details> {
//   late SharedPreferences _prefs;
//   String first_name = '';
//   String last_name = '';
//   String contact_no = '';
//   String info = '';
//   LatLng? _currentLocation;

//   Future<void> _getCurrentLocation() async {
//     final location = Location();
//     try {
//       final currentPosition = await location.getLocation();
//       setState(() {
//         _currentLocation = LatLng(
//           currentPosition.latitude!,
//           currentPosition.longitude!,
//         );
//       });
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//   @override
//   void initState() {
//     super.initState();
//     SharedPreferences.getInstance().then((prefs) {
//       setState(() {
//         _prefs = prefs;
//         first_name = _prefs.getString('first_name') ?? '';
//         last_name = _prefs.getString('last_name') ?? '';
//         contact_no = _prefs.getString('contact_no') ?? '';
//       });
//     });
//       _getCurrentLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//   final AppLocalizations localizations = AppLocalizations.of(context)!;

//   final Set<Marker> markers = new Set();

//   markers.add(Marker( //add first marker
//     markerId: MarkerId(_currentLocation.toString()),
//     position: _currentLocation==null?LatLng(0.0,0.0):_currentLocation!, //position of marker
//     infoWindow: InfoWindow( //popup info
//       title: 'My current location',
//       snippet: 'Lifesaver to come here',
//     ),
//     icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//     ));
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         foregroundColor: Colors.black54,
//         title: Text("Emergency Details",
//             style: GoogleFonts.poppins(
//               fontSize: 24,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 0,
//               color: Colors.black45,
//             )),
//       ),
//       body: _currentLocation==null? Center(
//               child: CircularProgressIndicator(),
//             ):
//       Container(
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               decoration: buildInputDecoration(Icons.location_on, "Location of Emergency",
//                   border: const BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25),
//                   )),
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * (1 / 4),
//               decoration: BoxDecoration(
//                   color: Colors.red.shade100,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(25),
//                     bottomRight: Radius.circular(25),
//                   )),
//                 child: SizedBox(
//                                 width: double.infinity,
//                                 height:  (MediaQuery.of(context).size.height) / 2.5,
//                                 child: GoogleMap(
//                                   initialCameraPosition: CameraPosition(
//                                     target: _currentLocation!,
//                                     zoom: 15.0,
//                                   ),
//                                   mapType: MapType.normal,
//                                   compassEnabled: true,
//                                   markers: markers,
//                                 ),
//                               ),
//             ),
//             const Spacer(flex: 2),
//             Text("Patient's Information:",
//                 style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 0,
//                   color: Colors.black45,
//                 )),
//             const Spacer(flex: 2,),
//             TextField(
//               decoration: buildInputDecoration(Icons.groups, "How Many Patients?", border: const BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25),
//                   )),),

//             const SizedBox(height: 3,),
//             TextField(
//               maxLines: 2,
//               textAlignVertical: TextAlignVertical.top,
//               decoration: buildInputDecoration(Icons.info, "Other Important Details (optional)", border: const BorderRadius.only(
//                     bottomLeft: Radius.circular(25),
//                     bottomRight: Radius.circular(25),
//                   )),
//             ),
//             const Spacer(flex: 2),
//             Text("Caller's Information:",
//                 style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 0,
//                   color: Colors.black45,
//                 )),
//             const Spacer(flex: 2,),
//             Row(
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 2.2,
//                   child: TextField(
//                     controller: TextEditingController(text: first_name + ' ' + last_name),
//                     decoration: buildInputDecoration(Icons.person, "Name", border: const BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     bottomLeft: Radius.circular(25),
//                   )),
//                   ),
//                 ),
//                 const SizedBox(width: 4,),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 2.2,
//                   child: TextField(
//                     controller: TextEditingController(text: contact_no),
//                     decoration: buildInputDecoration(Icons.call, "Contact Number",border: const BorderRadius.only(
//                     topRight: Radius.circular(25),
//                     bottomRight: Radius.circular(25),
//                   )),
//                   ),
//                 ),
//               ],
//             ),
//             const Spacer(flex: 6),
//             Container(
//               margin: const EdgeInsets.only(bottom: 20.0),
//               child: SizedBox(
//                 height: 50,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.redAccent,
//                     fixedSize: Size(MediaQuery.of(context).size.width, 30),
//                     textStyle: Theme.of(context).textTheme.bodyText2,
//                   ),
//                   onPressed: () {Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) => Searching(latitude: _currentLocation!.latitude, longitude: _currentLocation!.longitude)));
//                       },
//                   child: const Text('Launch Alert'),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// ===============================================

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
  final _addressController = TextEditingController(text: "");
  final _callercontactController = TextEditingController(text: "");
  final _callernameController = TextEditingController(text: "");
  final _detailsController = TextEditingController(text: "");
  GoogleMapController? mapController;

  LatLng? _currentLocation;

  bool patientInfo = false;

  Future<void> _getCurrentLocation() async {
    final location = loc.Location();
    try {
      final currentPosition = await location.getLocation();
      setState(() {
        _currentLocation = LatLng(
          currentPosition.latitude!,
          currentPosition.longitude!,
        );
      });
      mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _currentLocation!, zoom: 15)));
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
        String first_name = _prefs.getString('first_name') ?? '';
        String last_name = _prefs.getString('last_name') ?? '';
        _callercontactController.text = _prefs.getString('contact_no') ?? '';
        _callernameController.text = '$first_name $last_name';
      });
    });
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = {};
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    markers.add(Marker(
      //add first marker
      markerId: MarkerId(_currentLocation.toString()),
      position: _currentLocation == null ? const LatLng(0.0, 0.0) : _currentLocation!, //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'My current location',
        snippet: 'Lifesaver to come here',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    return Scaffold(
      backgroundColor: greyWhite,
      resizeToAvoidBottomInset: false,
      appBar: SimpleAppBar(localizations.emergency_details),
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(18),
                        labelText: localizations.emergency_location,
                        labelStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.8),
                        // hintText: hinttext,
                        prefixIcon: const Icon(Icons.location_on),
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.red.shade50,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          borderSide: BorderSide(color: Colors.red.shade100),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          borderSide: BorderSide(style: BorderStyle.none, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.my_location),
                          onPressed: () async {
                            _getCurrentLocation();
                            _addressController.text = "Search your address";
                          },
                        )),
                    controller: TextEditingController(text: _addressController.text),
                    readOnly: true,
                    onTap: () async {
                      var place = await PlacesAutocomplete.show(
                          startText: _addressController.text.contains(", ")
                              ? _addressController.text.substring(0, _addressController.text.indexOf(", "))
                              : _addressController.text,
                          hint: "Search your address",
                          overlayBorderRadius: BorderRadius.circular(25),
                          // logo: Text("Powered by Google"),
                          context: context,
                          apiKey: api_key,
                          mode: Mode.overlay,
                          types: [],
                          strictbounds: false,
                          components: [Component(Component.country, 'pk')],
                          //google_map_webservice package
                          onError: (err) {
                            print(err);
                          });

                      if (place != null) {
                        //form google_maps_webservice package
                        final plist = GoogleMapsPlaces(
                          apiKey: api_key,
                          apiHeaders: await const GoogleApiHeaders().getHeaders(),
                          //from google_api_headers package
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        final lat = geometry.location.lat;
                        final lang = geometry.location.lng;
                        setState(() {
                          _addressController.text = place.description.toString();
                          _currentLocation = LatLng(lat, lang);
                        });

                        //move map camera to selected place with animation
                        mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _currentLocation!, zoom: 15)));
                      }
                    },
                  ),
                  Container(
                    height: patientInfo ? MediaQuery.of(context).size.height * (1 / 4) : MediaQuery.of(context).size.height * (3 / 8),
                    decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        )),
                    child: GoogleMap(
                      myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: _currentLocation!,
                          zoom: 15.0,
                        ),
                        mapType: MapType.normal,
                        compassEnabled: true,
                        markers: markers,
                        onMapCreated: (controller) {
                          //method called when map is created
                          setState(() {
                            mapController = controller;
                          });
                        }),
                  ),
                  const Spacer(flex: 2),
                  if (patientInfo) Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(localizations.patients_information,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0,
                                  color: Colors.black45,
                                )),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: _quantityController,
                              decoration: buildInputDecoration(Icons.groups, localizations.patient_quantity,
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
                              decoration: buildInputDecoration(Icons.info, localizations.other_details,
                                  border: const BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                  )),
                            ),
                          ],
                        ) else SizedBox(
                              height: 48,
                              child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      patientInfo = !patientInfo;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Icon(Icons.add, size: 18,),
                                      ),
                                      Text(
                                        "Patient Information",
                                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.2),
                                      ),
                                    ],
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
                          controller: TextEditingController(text: _callernameController.text),
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
                          print('here${ApiConstants.baseUrl}${ApiConstants.incidentEndpoint}');

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
                            "latitude": _currentLocation!.latitude,
                            "longitude": _currentLocation!.longitude,
                            "info": _detailsController.text,
                            "created": DateTime.now().toString(),
                            "updated": DateTime.now().toString(),
                            "no_of_patients": number,
                            "status": "launched",
                            "lifesaver": null,
                            "citizen": await SharedPreferences.getInstance().then((prefs) => prefs.getString('id') ?? '')
                          });

                          final http.Response result = await http.post(Uri.parse(ApiConstants.baseUrl + ApiConstants.incidentEndpoint),
                              body: jsonEncode({
                                "location": _addressController.text,
                                "latitude": _currentLocation!.latitude,
                                "longitude": _currentLocation!.longitude,
                                "info": _detailsController.text,
                                "created": DateTime.now().toString(),
                                "updated": DateTime.now().toString(),
                                "no_of_patients": number,
                                "status": "launched",
                                "lifesaver": null,
                                "citizen": await SharedPreferences.getInstance().then((prefs) => prefs.getString('id') ?? '')
                              }),
                              headers: {'Accept': 'application/json', 'Content-Type': 'application/json'});

                          Map<String, dynamic> body = json.decode(result.body);
                          print("Output: $body");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Searching(latitude: _currentLocation!.latitude, longitude: _currentLocation!.longitude, incident_obj: body)));
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
