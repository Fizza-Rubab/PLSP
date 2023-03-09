import 'package:flutter/material.dart';
import 'package:google_maps/homepage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import "searching.dart";
import 'old_login.dart';
import 'constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

var input_style = TextStyle(
  color: Color.fromRGBO(146, 98, 81, 1),
  fontFamily: 'Poppins',
);

var card_decoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(211, 211, 211, 1),
      blurRadius: 3,
      offset: Offset(4, 5), // Shadow position
    ),
  ],
  border: Border.all(
      color: Color.fromRGBO(255, 222, 210, 1),
      width: 0.0,
      style: BorderStyle.solid),
  borderRadius: BorderRadius.circular(20),
  color: Color.fromRGBO(255, 222, 210, 1),
);

class AlertDetails extends StatefulWidget {
  final Map<String, dynamic> args;
  const AlertDetails({Key? key, required this.args}) : super(key: key);

  @override
  State<AlertDetails> createState() => _AlertDetailsState();
}

class _AlertDetailsState extends State<AlertDetails> {
  String info = '';
  int noPatient = 1;
  String patientName = '';
  int incidentId = 0;

  Future<void> alertLifesavers() async {
    final http.Response result;
    Map<String, dynamic> data = {
      "location": "Some location",
      "latitude": this.widget.args['latitude'],
      "longitude": this.widget.args['latitude'],
      "info": info,
      "no_of_patients": noPatient,
      "patient_name": patientName,
      "lifesaver": null,
      "citizen": this.widget.args['id']
    };
    print(ApiConstants.baseUrl + ApiConstants.incidentEndpoint);
    result = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.citizenEndpoint + ApiConstants.signupEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data)
    );
    print(result.body.toString());
    setState(() {
      incidentId = json.decode(result.body)['id'];
    });

  }
  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = new Set();
    markers.add(Marker( //add first marker
      markerId: MarkerId(LatLng(this.widget.args['latitude'], this.widget.args['longitude']).toString()),
      position: LatLng(this.widget.args['latitude'], this.widget.args['longitude'] ), //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'My current location',
        snippet: 'Lifesaver will reach here',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 241, 236, 1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon:Icon(Icons.arrow_back,
            color: Colors.red,)
                , onPressed: (){
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => HomePage()));
          },
          ),
          title: Text(
            "Emergency Alert",
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              letterSpacing: 0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                // Map location
                Padding(
                  padding: page_padding(context),
                  child: Column(
                    children: [
                      card_Header('Location:'),
                      Container(
                        height: (MediaQuery.of(context).size.height) / 1.9,
                        width: (MediaQuery.of(context).size.width),
                        decoration: card_decoration,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 40,
                              MediaQuery.of(context).size.height / 80,
                              MediaQuery.of(context).size.width / 40,
                              MediaQuery.of(context).size.height / 80),
                          child: Column(
                            children: [
                              // Location and Map
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Color.fromRGBO(146, 98, 81, 1),
                                  ),
                                  SizedBox(width: 5), // Just for spacing
                                  Expanded(
                                    child: TextField(
                                      style: input_style,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(0.0),
                                        isDense: true,
                                        labelText: 'Default Location: ' + widget.args["latitude"].toString() + ', ' +  widget.args['longitude'].toString(),
                                        labelStyle: TextStyle(
                                          color: Colors.black45,
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                width: double.infinity,
                                height:  (MediaQuery.of(context).size.height) / 2.3,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(this.widget.args['latitude'], this.widget.args['longitude'] ),
                                    zoom: 15.0,
                                  ),
                                  mapType: MapType.normal,
                                  compassEnabled: true,
                                  markers: markers,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Number and Name of Patients
                Row(
                  children: [
                    Column(
                      children: [
                        card_Header("No. of patients"),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 20, 0, 0, 10),
                          child: Container(
                            height: (MediaQuery.of(context).size.height) / 15,
                            width: MediaQuery.of(context).size.width / 3.3,
                            decoration: card_decoration,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              initialValue: "1",
                              style: input_style,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(
                                    (MediaQuery.of(context).size.height) / 45),
                                isDense: true,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        card_Header("Name of patient(s)"),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 20, 0, 0, 10),
                          child: Container(
                            height: (MediaQuery.of(context).size.height) / 15,
                            width: MediaQuery.of(context).size.width / 1.8,
                            decoration: card_decoration,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              initialValue: "Unknown",
                              style: input_style,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(
                                    (MediaQuery.of(context).size.height) / 45),
                                isDense: true,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                Padding(
                  padding: page_padding(context),
                  child: Column(
                    children: [
                      card_Header("Other Details (if any):"),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Container(
                          height: (MediaQuery.of(context).size.height) / 15,
                          width: MediaQuery.of(context).size.width,
                          decoration: card_decoration,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: input_style,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(
                                  (MediaQuery.of(context).size.height) / 45),
                              isDense: true,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Padding(
            padding: page_padding(context),
            child: ElevatedButton(
              onPressed: () {
                alertLifesavers();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Searching(args:this.widget.args)));
              },
              child: const Text(
                'Launch Alert',
                style: TextStyle(
                  color: Color.fromRGBO(255, 241, 236, 1),
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(255, 0, 95, 1),
                padding: EdgeInsets.fromLTRB(110, 2, 110, 2),
              ),
            ),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}

EdgeInsets page_padding(BuildContext context) {
  var right = MediaQuery.of(context).size.width / 20;
  var top = 0.0;
  var left = MediaQuery.of(context).size.width / 20;
  var bottom = MediaQuery.of(context).size.height / 80;

  return EdgeInsets.fromLTRB(left, top, right, bottom);
}

Align card_Header(String header_text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
      child: Text(
        header_text,
        style: TextStyle(
            color: Color.fromRGBO(146, 98, 81, 1),
            fontFamily: 'Poppins',
            fontSize: 14,
            fontStyle: FontStyle.italic),
      ),
    ),
  );
}
