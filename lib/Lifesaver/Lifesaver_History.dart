import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../appbar.dart';
import '../constants.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

const space_between_rows = 8.0;
Row DetailsAdded(String title, String content) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
            color: Colors.black87),
      ),
      const SizedBox(
        width: 10,
      ),
      Flexible(
        child: Text(
          content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
              color: Colors.black54),
        ),
      ),
    ],
  );
}

class LifesaverHistory extends StatefulWidget {
  const LifesaverHistory({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LifesaverHistory> {
  bool _customTileExpanded = false;
  List<String> _destinations = [];
  List<String> _names = [];
  List<String> _conditions = [];
  List<String> _date_time = [];
  List<dynamic> _rating = [];
  List<dynamic> _number_of_patients = [];
  File? pickedImage;
  String imageUrl = '';

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.lifesaverHistory}/${await SharedPreferences.getInstance().then((prefs) => prefs.getString('id') ?? "")}'));
    final history = json.decode(response.body);
    if (mounted) {
      setState(() {
        _destinations = history
            .map<String>((hist) => (hist['location'] ?? '').toString())
            .toList();
        _names = history
            .map<String>((hist) => (hist['citizen_name'] ?? '').toString())
            .toList();
        _conditions = history
            .map<String>((hist) => (hist['info'] ?? '').toString())
            .toList();
        _date_time = history
            .map<String>(
                (hist) => (hist['created'] ?? '').toString().substring(0, 10))
            .toList();
        _rating =
            history.map<dynamic>((hist) => (hist['rating'] ?? '')).toList();
        _number_of_patients = history
            .map<dynamic>((hist) => (hist['no_of_patients'] ?? ''))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
   _loadImageFromLocal();
  }

  void _loadImageFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("trying to load the image");
    String? imagePath = prefs.getString('profile_image');
    print(imagePath);
    if (imagePath != null) {
      setState(() {
        pickedImage = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyWhite,
      appBar: pickedImage==null? MyAppBar(
        name: " ",
        name1: "History",):MyAppBar(
        name: " ",
        name1: "History",
        imageProvider: FileImage(pickedImage!),
      ),
      body: Center(
        child: _destinations==null
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: _destinations.length,
                itemBuilder: (BuildContext context, int index) {
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
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              trailing: Icon(
                                _customTileExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: PrimaryColor,
                              ),
                              title: Text(
                                _names[index],
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0,
                                    fontSize: 18.0,
                                    color: Colors.black87),
                              ),
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 0, 16, space_between_rows),
                                      child: DetailsAdded(
                                          "Condition:", _conditions[index]),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 16,
                                    //       vertical: space_between_rows),
                                    //   child: DetailsAdded(
                                    //       "Intervention:", "Intervention TBA"),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: space_between_rows),
                                      child: DetailsAdded(
                                          "Number of Patients:",
                                          _number_of_patients[index]
                                              .toString()),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: space_between_rows),
                            child:
                                DetailsAdded("Location:", _destinations[index]),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: space_between_rows),
                            child: DetailsAdded("Date:", _date_time[index]),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: space_between_rows),
                            child: RatingBar.builder(
                              ignoreGestures: true,
                              initialRating: _rating[index],
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
                },
              ),
      ),
    );
  }
}