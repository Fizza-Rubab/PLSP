import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class CitizenHistory extends StatefulWidget {
  const CitizenHistory({super.key});

  @override
  State<CitizenHistory> createState() => _CitizenHistoryState();
}

class _CitizenHistoryState extends State<CitizenHistory> {
  List names = ["Shamsa", "Ruhama", "Sameer", "Fizza"];
  List details = [
    "Address comes here: Garden East, Karachi.i.........Address comes here: Garden East, Karachi.i.........",
    "Johar",
    "Johar",
    "Outside planet Earth"
  ];
  List rating = [1.0, 2.0, 3.0, 4.0];

  List date_time = [
    DateTime.now().toString(),
    DateTime.now().toString(),
    DateTime.now().toString(),
    DateTime.now().toString()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Card(
                    elevation: 5.0,
                    color: Colors.red.shade50,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 5,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  names[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.5,
                                      fontSize: 18.0,
                                      fontFamily: 'Poppins'),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  details[index],
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: -0.5,
                                    fontFamily: 'Poppins',
                                    color: Colors.black45,
                                    fontSize: 12.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  date_time[index],
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: -0.5,
                                    fontFamily: 'Poppins',
                                    color: Colors.black45,
                                    fontSize: 12.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                RatingBar.builder(
                                  initialRating: rating[index],
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 30,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.health_and_safety,
                                    color: Colors.redAccent,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5.0),
                            child: TextButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                // side: const BorderSide(
                                //   width: 2.0,
                                //   // color: Colors.redAccent,
                                // ),
                                // primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: Text(
                                "Details",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}