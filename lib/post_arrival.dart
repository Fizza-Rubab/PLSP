import 'package:flutter/material.dart';
import 'myheaderdrawer.dart';
import 'towards_emergency.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/alert_details.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/gestures.dart';

const text_field_1 = TextStyle(
  fontStyle: FontStyle.italic,
  color: Colors.black45,
  fontFamily: 'Poppins',
  fontSize: 18,
  letterSpacing: 0,
  fontWeight: FontWeight.normal,
);

class PostArrival extends StatefulWidget {
  final Map<String, dynamic> args;
  const PostArrival({Key? key, required this.args}) : super(key: key);

  @override
  State<PostArrival> createState() => _PostArrivalState();
}

class _PostArrivalState extends State<PostArrival> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 241, 236, 1),
        appBar: AppBar(
          iconTheme: IconThemeData(color: appbar_icon_color),
          elevation: 0,
          backgroundColor: Colors.red,
          title: Center(
            child: Text("Life Saver Arrived"),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {}),
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                child: Image.asset('assets/images/paramedic-png.png', scale: 0.3,),
                ),
              ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "THE EMERGENCY SITUATION IS BEING DEALT! MEANWHILE, PLEASE STAY CALM FOR FURTHER ASSISTANCE:",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.red
                    ),
                  ),
                ),
              ),
            ),
            Divider(indent: 40, endIndent: 40, color: Colors.orange,),
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                "Life Saver On Duty:",
                style: text_field_1,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
              child: Stack(
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: 30.0, top: 10.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Sameer Pervez",
                            style: TextStyle(
                              color: Colors.black45,
                              fontFamily: "Poppins",
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "+923352395720",
                              style: TextStyle(
                                color: Colors.black45,
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
                          color: Color.fromRGBO(255, 241, 236, 1),
                          width: 2,
                        ),
                        image: DecorationImage(
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
        // bottomNavigationBar: BottomAppBar(
        //   color: Colors.transparent,
        //   elevation: 0,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       BottomButton(Icons.call),
        //       BottomButton_2(context),
        //       BottomButton(Icons.message),
        //       BottomButton(Icons.share),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
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
      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TowardsEmergency(args:this.widget.args),
          ));
        },
        child: Icon(icon, color: Colors.redAccent),
        style: ElevatedButton.styleFrom(
          primary: Colors.orangeAccent,
          padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
        ),
      ),
    );
  }

  Widget BottomButton_2(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Container(
                  child: AlertDialog(
                    title: Text(
                      "Please verify the arrival of lifesaver",
                      style: TextStyle(color: Colors.black45),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "YES",
                            style: TextStyle(color: Colors.redAccent),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "NO",
                            style: TextStyle(color: Colors.redAccent),
                          )),
                    ],
                  ),
                );
              });
        },
        child: Text(
          "CANCEL",
          style: TextStyle(
            color: Colors.redAccent,
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.orangeAccent,
          padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
        ),
      ),
    );
  }
}
