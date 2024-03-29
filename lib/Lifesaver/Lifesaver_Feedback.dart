// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps/Alert/Thankyou.dart';
import 'package:google_maps/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../input_design.dart';
import '../appbar.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class Lifesaver_Feedback extends StatefulWidget {
  final Map<String, dynamic> incident_obj;
  const Lifesaver_Feedback({Key? key, required this.incident_obj}) : super(key: key);

  @override
  _Lifesaver_FeedbackState createState() => _Lifesaver_FeedbackState();
}

class _Lifesaver_FeedbackState extends State<Lifesaver_Feedback> {
  Future FeedbackSave() async {
    print('here' + ApiConstants.baseUrl + ApiConstants.lifesaverFeedback);
    print({
      "is_intervention": _didPerformLifeSavingIntervention,
      "intervention": _lifeSavingIntervention,
      "taken_to_hospital": _didMedicalHelpArrive,
      "details": _feedbackController.text,
      "incident": widget.incident_obj['incident'],
      "lifesaver": await SharedPreferences.getInstance()
          .then((prefs) => prefs.getString('id') ?? '')
    });
    final http.Response result = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.lifesaverFeedback),
        body: jsonEncode({
          "is_intervention": _didPerformLifeSavingIntervention,
          "intervention": _lifeSavingIntervention,
          "taken_to_hospital": _didMedicalHelpArrive,
          "details": _feedbackController.text,
          "incident": widget.incident_obj['incident'],
          "lifesaver": await SharedPreferences.getInstance()
              .then((prefs) => prefs.getString('id') ?? "")
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });
    print(result);
    Map<String, dynamic> body = json.decode(result.body);
    print(body);
  }

  final _feedbackController = TextEditingController();
  List<String> _entries = [];
  String _lifeSavingIntervention = 'CPR';

  bool _didPerformLifeSavingIntervention = true;
  bool _didMedicalHelpArrive = false;

  TextStyle question_style = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: Colors.grey.shade800,
  );

  TextStyle option_style = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: Colors.grey.shade800,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: SimpleAppBar("Post Emergency form"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text('Did you perform any life-saving intervention?',
                  style: question_style),
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
                  Text('Yes', style: option_style),
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
                  Text('No', style: option_style),
                ],
              ),
      
              SizedBox(height: 20.0),
              Text('What was the life-saving intervention you performed?',
                  style: question_style),
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
                  Text('CPR', style: option_style),
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
                  Text('Bleeding Control', style: option_style),
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
                  Text('Both', style: option_style),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                  'Did the medical help arrive at the location or was the patient taken to the hospital?',
                  style: question_style),
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
                  Text('Yes', style: option_style),
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
                  Text('No', style: option_style),
                ],
              ),
              SizedBox(height: 20.0),
              Text('Any other feedback?', style: question_style),
              TextFormField(
                controller: _feedbackController,
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
                      FeedbackSave();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ThankYouScreen()
      
                          ));
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
      ),
    );
  }
}
