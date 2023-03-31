import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

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

  List date_time = [DateFormat.yMMMMd().format(DateTime.now()), DateFormat.yMMMMd().format(DateTime.now()),DateFormat.yMMMMd().format(DateTime.now()),DateFormat.yMMMMd().format(DateTime.now()),];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        foregroundColor: Colors.black54,
        title: Text("History",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
              color: Colors.black45,
            )),
      ),
      body: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Card(
            elevation: 2.0,
            color: Colors.red.shade50,
            shadowColor: Colors.redAccent.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 12.0),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Expanded(
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          names[index],
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, letterSpacing: -0.5, fontSize: 18.0, color: Colors.black87),
                        ),
                        const Spacer(),
                        TextButton(
                            // icon: Icon(Icons.chevron_right),
                            onPressed: () {},
                            child: Row(children: [
                              Text(
                                "Details",
                                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1.0, color: PrimaryColor),
                              ),
                              const Icon(
                                Icons.expand_more,
                                color: PrimaryColor,
                              )
                            ])),
                        // Container(
                        //     alignment: Alignment.topRight,
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 5.0, vertical: 5.0),
                        //     child: TextButton(
                        //       onPressed: () {},
                        //       style: ElevatedButton.styleFrom(
                        //         // side: const BorderSide(
                        //         //   width: 2.0,
                        //         //   // color: Colors.redAccent,
                        //         // ),
                        //         // primary: Colors.white,
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(20.0),
                        //         ),
                        //       ),
                        //       child: const Text(
                        //         "Details",
                        //         style: TextStyle(
                        //           color: Colors.redAccent,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                    Text(
                      details[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        letterSpacing: 0,
                        color: Colors.black45,
                        fontSize: 14.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      date_time[index],
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        letterSpacing: -0.5,
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    RatingBar.builder(
                      ignoreGestures: true,
                      initialRating: rating[index],
                      minRating: 1,
                      glow:false,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
