import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'Citizen_Feedback.dart';
import '../config.dart';
import './lifesaver_feedback.dart'; 


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
        snippet: 'Here',
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
    snippet: 'Lifesaver here',
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), //Icon for Marker
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 241, 236, 1),
        appBar: AppBar(
          // iconTheme: IconThemeData(color: appbar_icon_color),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Center(
            child: Text("Life Saver Arrived", style: TextStyle(color: Colors.redAccent),),
          ),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.redAccent,
              ),
              onPressed: () {
                
              }),
        ),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height) / 14,
              child: Container(
                color: Colors.green,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Lifesaver_Feedback()));
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text(
                      "Verify arrival",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height) * (11.6 / 19.6),
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
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                        children: const [
                          Text(
                            "Sameer Pervez",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "+923352395720",
                              style: TextStyle(
                                color: Colors.white,
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
