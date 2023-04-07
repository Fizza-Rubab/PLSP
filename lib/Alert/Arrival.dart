import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Citizen_Feedback.dart';
import '../input_design.dart';
import '../config.dart';
import '../constants.dart';


class Arrived extends StatefulWidget {
  final Map<String, dynamic> args;
  const Arrived({Key? key, required this.args}) : super(key: key);

  @override
  State<Arrived> createState() => _ArrivedState();
}

class _ArrivedState extends State<Arrived> {
  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = new Set();

    markers.add(Marker(
      //add first marker
      markerId: MarkerId(LatLng(widget.args['latitude'], widget.args['longitude']).toString()),
      position: LatLng(widget.args['latitude'], widget.args['longitude']), //position of markerconst
      infoWindow: const InfoWindow(
        //popup info
        title: 'My Location',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    markers.add(Marker(
    //add first marker
      //37.42681245606211, -122.08065576215935
    markerId: MarkerId(LatLng(widget.args['latitude']+0.000003052, widget.args['longitude']-0.0000040210).toString()),
    position: LatLng(widget.args['latitude']+0.000070052, widget.args['longitude']-0.0000050210), //position of markerconst
    infoWindow: const InfoWindow(
    //popup info
    title: 'Lifesavers Location',
    snippet: 'Lifesaver is here',
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), //Icon for Marker
    ));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black54,
        title: Center(
          child: Text("Lifesaver has Arrived",
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
                margin: EdgeInsets.fromLTRB(0,5,0,0),
                color: Colors.blue.shade50,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Citizen_Feedback()));
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade100),
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
                  target: LatLng(widget.args['latitude'], widget.args['longitude']),
                  zoom: 15.0,
                ),
                mapType: MapType.normal,
                compassEnabled: true,
                markers: markers,
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
                      padding:
                          const EdgeInsets.only(right: 30.0, top: 10.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Sameer Pervez",
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
                              "+923352395720",
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
              BottomButton(Icons.share),
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
       
        onPressed: ()async{
          if (icon==Icons.call)
            launch("tel://03222336019");
          else {
            Uri sms = Uri.parse('sms:03222336019?body=Hello there');
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
                      "Please verify the arrival of lifesaver",
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
