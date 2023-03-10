// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Home/Citizen.dart';
import '../input_design.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Citizen_Feedback extends StatefulWidget {
  const Citizen_Feedback({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Citizen_Feedback> {
  final _textController = TextEditingController();
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

  // void dispose() {
  //   _textController.dispose();
  //   super.dispose();
  // }
  double _rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          "Post-Emergency Form",
          style: TextStyle(fontFamily: "Poppins", color: Colors.redAccent),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.redAccent,
          ),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Name of patient(s):", style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colors.redAccent,
                ),
            ),
            SizedBox(
              height: 200,
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
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(
                              style: BorderStyle.none, width: 0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(
                              style: BorderStyle.none, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
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
              style:GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colors.redAccent,
                ),
            ),
            TextField(
              maxLines: 2,
              decoration: buildInputDecoration(Icons.person_outline, ""),
            ),
            const Divider(
              color: Colors.redAccent,
            ),
            const Text(
              "Caller Details:",
              style: TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.redAccent),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                "Caller: Sara Khan",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ),
            ),
            const Center(
              child: Text(
                "Contact: 03332428145",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              maxLines: 2,
              decoration: buildInputDecoration(
                  Icons.person_outline, "Post Emergency Details"),
            ),
            const Text(
              "Rate the Life saver",
              style: TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.redAccent),
            ),
            RatingBar.builder(
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
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  fixedSize: Size(MediaQuery.of(context).size.width, 30),
                  textStyle: const TextStyle(
                      fontSize: 18, fontFamily: 'Poppins', color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Citizen()));
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
