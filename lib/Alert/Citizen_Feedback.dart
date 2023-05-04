// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps/Alert/Thankyou.dart';
import '../appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home/Citizen.dart';
import '../input_design.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import '../constants.dart';
import 'package:http/http.dart' as http;

class Citizen_Feedback extends StatefulWidget {
  final Map<String, dynamic> incident_obj;

  Citizen_Feedback({required this.incident_obj});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Citizen_Feedback> {
  Future FeedbackSave() async {
    print(widget.incident_obj);
    print('here' + ApiConstants.baseUrl + ApiConstants.citizenFeedback);
    print({
          "intervention": "CPR",
          "name_of_patients":  _entries.join(", "),
          "details": _detailsController.text,
          "lifesaver_rating": _rating,
          "incident": widget.incident_obj['incident'],
          "citizen": await SharedPreferences.getInstance().then((prefs) => prefs.getString('id') ?? "") 
        }); 
    final http.Response result = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.citizenFeedback),
        body: jsonEncode({
          "intervention": "CPR",
          "name_of_patients":  _entries.isEmpty?"":_entries.join(", "),
          "details": _detailsController.text,
          "lifesaver_rating": _rating,
          "incident": widget.incident_obj['incident'],
          "citizen": await SharedPreferences.getInstance().then((prefs) => prefs.getString('id') ?? "")
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });
    print(result);
    Map<String, dynamic> body = json.decode(result.body);
    print(body);
    print("Done....."); 
  }

  final _textController = TextEditingController();
  final _detailsController = TextEditingController();

  List<String> _entries = [];

  void _addEntry() {
    setState(() {
      _entries.add(_textController.text);
      _textController.clear();
    });
  }

  void _deleteEntry(int index) {
    setState(() {
      _entries.removeAt(index);
    });
  }

  double _rating = 0.0;
  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SimpleAppBar(localizations.post_emergency_form),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(localizations.patient_name, style: generalfontStyle),
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: _entries.length + 1,
                itemBuilder: (context, index) {
                  if (index == _entries.length) {
                    // Add a new entry field with the plus icon
                    return TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outline),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        focusColor: Colors.red.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(
                              style: BorderStyle.none, width: 0),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _addEntry,
                        ),
                      ),
                    );
                  } else {
                    // Show the existing entry
                    return ListTile(
                      title: Text(_entries[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteEntry(index);
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            Text(
              "Details:",
              style: generalfontStyle,
            ),
            TextField(
              controller: _detailsController,
              maxLines: 3,
              decoration: buildInputDecoration(Icons.person_outline, "",
                  border: BorderRadius.all(Radius.circular(20))),
            ),
            const Divider(
              color: Colors.redAccent,
            ),
            Text(localizations.lifesaver_details, style: titleFontStyle),
            Text(
              "Name: " + widget.incident_obj['lifesaver_name'],
              style: generalfontStyle,
            ),
            Text(
              "Contact: " + widget.incident_obj['lifesaver_contact'],
              style: generalfontStyle,
            ),
            Text(
              "Rate the Life saver",
              style: titleFontStyle,
            ),
            Center(
              child: RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.health_and_safety,
                  color: Colors.redAccent,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.redAccent,
                  fixedSize: Size(MediaQuery.of(context).size.width / 2.4, 30),
                  textStyle: const TextStyle(
                      fontSize: 18, fontFamily: 'Poppins', color: Colors.white),
                ),
                onPressed: () {
                  FeedbackSave() ; 
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ThankYouScreen()));
                },
                child: Text(
                  localizations.submit,
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                      color: Colors.grey.shade100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
