// ignore_for_file: file_names, camel_case_types, avoid_print, non_constant_identifier_names, use_build_context_synchronously, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps/Alert/network_utility.dart';
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
import 'place_auto_complete_response.dart';
import 'autocompleteprediction.dart';

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
  List<AutoCompletePrediction> placePredictions = [];
  Marker _marker = const Marker(
    markerId: MarkerId('marker_1'),
    position: LatLng(24.892122463649557, 67.0747368523425), // current pos
  );

  void placeAutocomplete(String query) async {
    Uri uri =
        Uri.https("maps.googleapis.com", 'maps/api/place/autocomplete/json', {
      "input": query,
      "key": api_key,
    });
    String? response = await NetworkUtility.fetchUrl(uri);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

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
      // mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _currentLocation!, zoom: 15)));
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
    Future<void> updateCamera(LatLng newPosition) async {
      final CameraPosition newPosition = CameraPosition(
        target: _marker.position,
        zoom: 14,
      );
      await mapController!
          .animateCamera(CameraUpdate.newCameraPosition(newPosition));
    }
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
      // extendBodyBehindAppBar: true,
      appBar: SimpleAppBar(localizations.emergency_details),
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  // height: patientInfo ? MediaQuery.of(context).size.height * (1 / 4) : MediaQuery.of(context).size.height * (3 / 8),
                  decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
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
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 14.0),
                //     child: TextField(
                //       decoration: InputDecoration(
                //           contentPadding: const EdgeInsets.all(16),
                //           labelText: localizations.emergency_location,
                //           labelStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.8),
                //           // hintText: hinttext,
                //           prefixIcon: const Icon(Icons.location_on),
                //           filled: true,
                //           fillColor: Colors.white,
                //           focusColor: Colors.red.shade50,
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(25),
                //             borderSide: BorderSide(color: Colors.red.shade100),
                //           ),
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(25),
                //             borderSide: const BorderSide(style: BorderStyle.none, width: 0),
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(25),
                //             borderSide: BorderSide(color: Colors.grey.shade300),
                //           ),
                //           suffixIcon: IconButton(
                //             icon: const Icon(Icons.my_location),
                //             onPressed: () async {
                //               _getCurrentLocation();
                //               _addressController.text = "Search your address";
                //             },
                //           )),
                //       controller: TextEditingController(text: _addressController.text),
                //       readOnly: true,
                //       onTap: () async {
                //         var place = await PlacesAutocomplete.show(
                //             startText: _addressController.text.contains(", ")
                //                 ? _addressController.text.substring(0, _addressController.text.indexOf(", "))
                //                 : _addressController.text,
                //             hint: "Search your address",
                //             overlayBorderRadius: BorderRadius.circular(25),
                //             // logo: Text("Powered by Google"),
                //             context: context,
                //             apiKey: api_key,
                //             mode: Mode.overlay,
                //             types: [],
                //             strictbounds: false,
                //             components: [Component(Component.country, 'pk')],
                //             //google_map_webservice package
                //             onError: (err) {
                //               print(err);
                //             });

                //         if (place != null) {
                //           //form google_maps_webservice package
                //           final plist = GoogleMapsPlaces(
                //             apiKey: api_key,
                //             apiHeaders: await const GoogleApiHeaders().getHeaders(),
                //             //from google_api_headers package
                //           );
                //           String placeid = place.placeId ?? "0";
                //           final detail = await plist.getDetailsByPlaceId(placeid);
                //           final geometry = detail.result.geometry!;
                //           final lat = geometry.location.lat;
                //           final lang = geometry.location.lng;
                //           setState(() {
                //             _addressController.text = place.description.toString();
                //             _currentLocation = LatLng(lat, lang);
                //           });

                //           //move map camera to selected place with animation
                //           mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _currentLocation!, zoom: 15)));
                //         }
                //       },
                //     ),
                //   ),
                // ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    TextField(
                      onChanged: (value) {
                        placeAutocomplete(value);
                      },
                      controller: _addressController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _addressController.clear();
                          },
                        ),
                        filled: true,
                        labelText: localizations.emergency_location,
                        fillColor: Colors.grey[200],
                        hintText: "Current Location",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide.none),
                      ),
                    ),
                    // TextField(

                    //   controller: _addressController,
                    //   decoration: buildInputDecoration(
                    //       Icons.location_on, localizations.emergency_location,
                    //       border: const BorderRadius.only(
                    //         topLeft: Radius.circular(25),
                    //         topRight: Radius.circular(25),
                    //       )),
                    // ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: placePredictions.length,
                        itemBuilder: (context, index) {
                          final prediction = placePredictions[index];
                          if (prediction.description == null) {
                            return const SizedBox.shrink(); // don't render a tile if the location is null
                          }
                          return LocationListTile(
                            location: prediction.description!,
                            press: () {
                              getLatLongFromPlaceId(prediction.placeId!).then((latitudelongitude) {
                                setState(() {
                                  _marker = Marker(
                                    markerId: const MarkerId('marker_1'),
                                    position: latitudelongitude,
                                  );
                                });
                                updateCamera(latitudelongitude);
                              });

                              _addressController.text = prediction.description!;
                            },
                          );
                        },
                      ),
                    ),
                  ]),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (patientInfo)
                                Column(
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
                                )
                              else
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.only(left: 8, right: 12),
                                      side: const BorderSide(width: 1.0, color: Colors.red),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        patientInfo = !patientInfo;
                                      });
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 4),
                                          child: Icon(
                                            Icons.add,
                                            size: 18,
                                          ),
                                        ),
                                        Text(
                                          localizations.patients_information,
                                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.2),
                                        ),
                                      ],
                                    )),
                              Text(localizations.caller_information,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0,
                                    color: Colors.black45,
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // TextField(
                                    //     readOnly: true,
                                    //     controller: TextEditingController(text: _callernameController.text),
                                    //     decoration: const InputDecoration(
                                    //         prefixIcon: Icon(Icons.person, size: 20),
                                    //         // contentPadding: EdgeInsets.all(20),
                                    //         enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid, color: Colors.red)))),
                                    info(
                                        const Icon(
                                          Icons.person,
                                          size: 20,
                                          color: Colors.black54,
                                        ),
                                        _callernameController.text),

                                    info(
                                        const Icon(
                                          Icons.call,
                                          size: 20,
                                          color: Colors.black54,
                                        ),
                                        _callercontactController.text),
                                    // SizedBox(
                                    //   width: MediaQuery.of(context).size.width / 2.2,
                                    //   child: TextField(
                                    //       readOnly: true,
                                    //       controller: _callercontactController,
                                    //       decoration: const InputDecoration(
                                    //           prefixIcon: Icon(Icons.call, size: 20),
                                    //           contentPadding: EdgeInsets.all(4),
                                    //           enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none, color: Colors.transparent)))),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 20.0),
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
                ),
              ],
            ),
    );
  }
}

Row info(Icon icon, String text) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: icon,
      ),
      Text(
        text,
        style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: Colors.black54),
      )
    ],
  );
}
