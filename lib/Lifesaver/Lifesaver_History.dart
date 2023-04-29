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
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.4, color: Colors.black87),
      ),
      const SizedBox(
        width: 10,
      ),
      Flexible(
        child: Text(
          content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.8, color: Colors.black54),
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
      backgroundColor: greyWhite,
      appBar: MyAppBar(name: " ", name1: "History",),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0.0,
                color: Colors.white,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          trailing: Icon(
                            _customTileExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: PrimaryColor,
                          ),
                          title: Text(
                            names[index],
                            style: GoogleFonts.lato(fontWeight: FontWeight.w800, letterSpacing: 0, fontSize: 18.0, color: Colors.black87),
                          ),
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16, 0, 16, space_between_rows),
                                  child: DetailsAdded("Condition:", condition[index]),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical:space_between_rows),
                                  child: DetailsAdded("Intervention:", intervention[index]),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical:space_between_rows),
                                  child: DetailsAdded("From:", source_address[index]),
                                ),
                              ],
                            ),
                          ],
                          onExpansionChanged: (bool expanded) {
                            setState(() => _customTileExpanded = expanded);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical:space_between_rows),
                        child: DetailsAdded("Location:", dest_address[index]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical:space_between_rows),
                        child: DetailsAdded("Date:", date_time[index]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical:space_between_rows),
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
              );
            }),
      ),
    );
  }
}
