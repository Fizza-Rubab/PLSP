import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'appbar.dart';
import '../constants.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

const space_between_rows = 8.0;

Row DetailsAdded(String title, String content) {
  return Row(
    children: [
      Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 15, letterSpacing: 0, color: Colors.black),
      ),
      SizedBox(
        width: 10,
      ),
      Flexible(
        child: Text(
          content,
          maxLines: 2,
          overflow: TextOverflow.fade,
          style: generalfontStyle,
        ),
      ),
    ],
  );
}

class LifesaverHistory extends StatefulWidget {
  const LifesaverHistory({Key? key}) : super(key: key);

  @override
  _LifesaverHistoryState createState() => _LifesaverHistoryState();
}

class _LifesaverHistoryState extends State<LifesaverHistory> {
  List names = [
    "Shamsa Hafeez",
    "Ruhama Naeem",
    "Sameer",
    "Fizza",
    "Iqra",
    "Haania"
  ];
  List dest_address = [
    "C-27, Blue Moon Apartment, Plot 160, Sopariwala street, Garden East, Karachi",
    "Johar",
    "Johar",
    "Outside planet Earth",
    "This is some new address",
    "This is also an address"
  ];

  List source_address = [
    "The source location to be added here ",
    "ABC........",
    "EFG",
    "Lorem Opsem....",
    "ABC........",
    "EFG",
  ];
  List condition = [
    "Heart Attack",
    "Burns",
    "Trauma",
    "Heart Attack",
    "Burns",
    "Trauma"
  ];
  List intervention = ["CPR", "CPR", "CPR", "CPR", "CPR", "CPR"];
  List date_time = [
    DateFormat.yMMMMd().format(DateTime.now()),
    DateFormat.yMMMMd().format(DateTime.now()),
    DateFormat.yMMMMd().format(DateTime.now()),
    DateFormat.yMMMMd().format(DateTime.now()),
    DateFormat.yMMMMd().format(DateTime.now()),
    DateFormat.yMMMMd().format(DateTime.now()),
  ];

  List rating = [1.0, 2.0, 3.0, 4.0, 1.0, 2.0];
  bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(name: " ", name1: "History",),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2.0,
                        color: Colors.red.shade50,
                        shadowColor: Colors.redAccent.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ExpansionTile(
                                   trailing: Icon(
                                    _customTileExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down, color: PrimaryColor,
                                  ),
                               
                                  title: Text(
                                    names[index],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.5,
                                        fontSize: 18.0,
                                        color: Colors.black87),
                                  ),
                                  children: [
                                    Container(
                                      height: 120,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 16.0),
                                        child: Column(
                                          children: [
                                            DetailsAdded(
                                                "Condition:", condition[index]),
                                            SizedBox(
                                              height: space_between_rows,
                                            ),
                                            DetailsAdded("Intervention:",
                                                intervention[index]),
                                            SizedBox(
                                              height: space_between_rows,
                                            ),
                                            DetailsAdded(
                                                "From:", source_address[index]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  onExpansionChanged: (bool expanded) {
                                    setState(
                                        () => _customTileExpanded = expanded);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: DetailsAdded(
                                      "Location:", dest_address[index]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0,
                                      top: space_between_rows,
                                      bottom: space_between_rows),
                                  child:
                                      DetailsAdded("Date:", date_time[index]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: RatingBar.builder(
                                    ignoreGestures: true,
                                    initialRating: rating[index],
                                    minRating: 1,
                                    glow: false,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 28,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.health_and_safety,
                                      color: Colors.redAccent,
                                    ),
                                    onRatingUpdate: (rating) {
                                      // print(rating);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
