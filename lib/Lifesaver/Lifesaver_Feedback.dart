// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps/Alert/Thankyou.dart';
import '../Home/Citizen.dart';
import '../input_design.dart';
import '../appbar.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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

  TextStyle question_style = GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
                color: Colors.grey.shade800,
              ); 

  TextStyle option_style = GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    color: Colors.grey.shade800,
                  ); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SimpleAppBar("Post Emergency form"),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Did you perform any life-saving intervention?',
              style: question_style
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  style: option_style
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
                Text(
                  'No',
                  style:option_style
                ),
              ],
            ),

            SizedBox(height: 20.0),
            Text(
              'What was the life-saving intervention you performed?',
              style: question_style
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
                Text(
                  'CPR',
                  style: option_style
                ),
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
                Text(
                  'Bleeding Control',
                  style: option_style
                ),
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
                Text(
                  'Both',
                  style: option_style
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Did the medical help arrive at the location or was the patient taken to the hospital?',
              style: question_style
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
                Text(
                  'Yes',
                  style: option_style
                ),
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
                Text(
                  'No',
                  style: option_style
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Any other feedback?',
              style: question_style
            ),
            TextField(
              maxLines: 2,
              decoration: buildInputDecoration(
                Icons.edit,
                "",
                border: BorderRadius.all(Radius.circular(20)),
                
              ),
            ),
            // TextField(controller: _feedbackController, maxLines: 2),
            SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.redAccent,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width / 2.4, 30),
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Colors.white),
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
            ),
          ],
        ),
      ),
    );
  }
}
