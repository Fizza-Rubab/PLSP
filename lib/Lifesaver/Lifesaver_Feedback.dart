// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps/Alert/Thankyou.dart';
import '../Home/Citizen.dart';
import '../input_design.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class Lifesaver_Feedback extends StatefulWidget {
  const Lifesaver_Feedback({super.key});

  @override
  _Lifesaver_FeedbackState createState() => _Lifesaver_FeedbackState();
}

class _Lifesaver_FeedbackState extends State<Lifesaver_Feedback> {
  final _textController = TextEditingController();
  List<String> _entries = [];
  String _lifeSavingIntervention = 'CPR';

  bool _didPerformLifeSavingIntervention = false;
  bool _didMedicalHelpArrive = false;

  final TextEditingController _feedbackController = TextEditingController();

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // iconTheme: IconThemeData(color: appbar_icon_color),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Post Emergency Form",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
            color: Colors.redAccent,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Did you perform any life-saving intervention?',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
                color: Colors.grey.shade800,
              ),
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: true,
                  groupValue: _didPerformLifeSavingIntervention,
                  onChanged: (value) {
                    setState(() {
                      _didPerformLifeSavingIntervention = value!;
                    });
                  },
                  activeColor: Colors.redAccent,
                ),
                Text(
                  'Yes',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    color: Colors.grey.shade800,
                  ),
                ),
                Radio(
                  value: false,
                  groupValue: _didPerformLifeSavingIntervention,
                  onChanged: (value) {
                    setState(() {
                      _didPerformLifeSavingIntervention = value!;
                    });
                  },
                  activeColor: Colors.redAccent,
                ),
                Text('No',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    color: Colors.grey.shade800,
                  ),),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'What was the life-saving intervention you performed?',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
                color: Colors.grey.shade800,
              ),
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 'CPR',
                  groupValue: _lifeSavingIntervention,
                  onChanged: (value) {
                    setState(() {
                      _lifeSavingIntervention = value!;
                    });
                  },
                  activeColor: Colors.redAccent,
                ),
                Text('CPR',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    color: Colors.grey.shade800,
                  ),),
                Radio(
                  value: 'Bleeding Control',
                  groupValue: _lifeSavingIntervention,
                  onChanged: (value) {
                    setState(() {
                      _lifeSavingIntervention = value!;
                    });
                  },
                  activeColor: Colors.redAccent,
                ),
                Text('Bleeding Control',
                
                style: GoogleFonts.poppins(
                  fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    color: Colors.grey.shade800,
                  ),),
                Radio(
                  value: 'Both',
                  groupValue: _lifeSavingIntervention,
                  onChanged: (value) {
                    setState(() {
                      _lifeSavingIntervention = value!;
                    });
                  },
                  activeColor: Colors.redAccent,
                ),
                Text('Both',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    color: Colors.grey.shade800,
                  ),),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Did the medical help arrive at the location or was the patient taken to the hospital?',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
                color: Colors.grey.shade800,
              ),
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: true,
                  groupValue: _didMedicalHelpArrive,
                  onChanged: (value) {
                    setState(() {
                      _didMedicalHelpArrive = value!;
                    });
                  },
                  activeColor: Colors.redAccent,

                ),
                Text('Yes',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    color: Colors.grey.shade800,
                  ),),
                Radio(
                  value: false,
                  groupValue: _didMedicalHelpArrive,
                  onChanged: (value) {
                    setState(() {
                      _didMedicalHelpArrive = value!;
                    });
                  },
                  activeColor: Colors.redAccent,

                ),
                Text('No',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    color: Colors.grey.shade800,
                  ),),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Any other feedback?',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
                color: Colors.grey.shade800,
              ),
            ),
            TextField(
              maxLines: 3,
              decoration: buildInputDecoration(Icons.edit, "", border: BorderRadius.all(Radius.circular(20))),
            ),
            // TextField(controller: _feedbackController, maxLines: 2),
            SizedBox(
              height: 20,
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ThankYouScreen()));
                },
                child: Text(
                  'Submit',
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
