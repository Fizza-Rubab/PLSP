import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/Lifesaver/Lifesaver_Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'Login.dart';

// Generate a random OTP
String generateOTP() {
  Random random = new Random();
  int randomNumber = random.nextInt(9999);
  return randomNumber.toString().padLeft(4, '0');
}

bool verifyOtp(String enteredOtp, String expectedOtp) {
  return enteredOtp == expectedOtp;
}

void sendOtpEmail(String recipientEmail, String recipientName,
    String generatedOTP, SmtpServer smtpServer) async {
  print(recipientEmail);
  // Create the email message

  try {
    // final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username)
      ..recipients.add(recipientEmail.toString())
      ..subject = 'Registeration OTP - PLSP Application'
      ..text =
          'Dear $recipientName ,\n\nYour OTP for verification is ${generatedOTP}. Please enter this code to complete your verification process.\n\nThank you,\n\nTeam Pakistan Lifesavers Programme';

    final sendReport = await send(message, smtpServer);
    print('OTP email sent: ' + sendReport.toString());
  } catch (e) {
    print('Error sending OTP email: ' + e.toString());
    rethrow;
  }
  // return generatedOTP;
}

class Otp extends StatefulWidget {
  final String last_name;
  final String address;
  final String contact_no;
  final String DOB;
  final String email;
  final String name;
  final String generatedOTP;
  final String username;
  final String password;
  final SmtpServer smtpServer;
  // final String generatedOTP;
  // final String email;
  // final String firstName;
  // final SmtpServer smtpServer;
  const Otp({
    required this.last_name,
    required this.address,
    required this.contact_no,
    required this.DOB,
    required this.email,
    required this.name,
    required this.generatedOTP,
    required this.username,
    required this.password,
    required this.smtpServer,
  });

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  late String enteredOTP = "XXXX";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SimpleAppBar(""),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(padding_val),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Verify OTP",
                  style: boldheader,
                ),
                Text(
                  'Enter the OTP sent to ${widget.email}',
                  style: header_disc,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _textFieldOTP(first: true, last: false, index: 0),
                    _textFieldOTP(first: false, last: false, index: 1),
                    _textFieldOTP(first: false, last: false, index: 2),
                    _textFieldOTP(first: false, last: true, index: 3),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Did not receive any code? ', style: generalfontStyle),
                    GestureDetector(
                      onTap: () {
                        // print(Text(widget.email));
                        _resendOTP();
                      },
                      child: Text(
                        "Resend Code",
                        style: urlfontStyle,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                TextButton(
                  onPressed: () async {
                    if (enteredOTP == widget.generatedOTP) {
                      print({
                        "email": widget.email,
                        "password": widget.password,
                        "citizen": {
                          "citizen": null,
                          "first_name": widget.name,
                          "last_name": widget.last_name,
                          "date_of_birth": widget.DOB.toString(),
                          "address": widget.address,
                          "contact_no": widget.contact_no.toString(),
                          "calls_made": 0,
                          "profile_picture": null
                        }
                      });
                      final http.Response result = await http.post(
                          Uri.parse(ApiConstants.baseUrl +
                              ApiConstants.citizenEndpoint +
                              ApiConstants.signupEndpoint),
                          body: jsonEncode({
                            "email": widget.email,
                            "password": widget.password,
                            "citizen": {
                              "citizen": null,
                              "first_name": widget.name,
                              "last_name": widget.last_name,
                              "date_of_birth": widget.DOB.toString(),
                              "address": widget.address,
                              "contact_no": widget.contact_no.toString(),
                              "calls_made": 0,
                            }
                          }),
                          headers: {
                            'Accept': 'application/json',
                            'Content-Type': 'application/json'
                          });
                      print(result.body);

                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.topSlide,
                          descTextStyle: generalfontStyle,
                          titleTextStyle: titleFontStyle,
                          title: "OTP Verified",
                          desc:
                              "You can now log in to your account using your email and password",
                          btnOkOnPress: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          }).show();
                    } else {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.topSlide,
                              descTextStyle: generalfontStyle,
                              titleTextStyle: titleFontStyle,
                              title: "Incorrect OTP",
                              desc:
                                  "Please enter the correct OTP sent to your email and try again",
                              btnOkOnPress: () {})
                          .show();
                    }
                  },
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      "Verify",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                          color: PrimaryColor),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: PrimaryColor,
                    )
                  ]),
                ),
              ]),
        ),
      ),
    );
  }

  Widget _textFieldOTP({required bool first, last, required int index}) {
    return Container(
      height: 60,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            print("Values: " + value);
            if (value.length == 0) {
              enteredOTP = enteredOTP.substring(0, index) +
                  "X" +
                  enteredOTP.substring(index + 1);
              print("After back: ");
              print(enteredOTP);
            } else if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
              enteredOTP = enteredOTP.substring(0, index) +
                  value.toString() +
                  enteredOTP.substring(index + 1);
            } else if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
              enteredOTP = enteredOTP.substring(0, index) +
                  value.toString() +
                  enteredOTP.substring(index + 1);
            } else {
              enteredOTP = enteredOTP.substring(0, index) +
                  value.toString() +
                  enteredOTP.substring(index + 1);
            }

            print("OTP Entered so far: " + enteredOTP);
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.redAccent),
                borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
    );
  }

  Future<void> _resendOTP() async {
    try {
      final message = Message()
        ..from = Address(widget.username)
        ..recipients.add(widget.email)
        ..subject = 'OTP for Verification'
        ..text =
            'Dear ${widget.name},\n\nYour OTP for verification is ${widget.generatedOTP}. Please enter this code to complete your verification process.\n\nThank you,\n\nTeam Pakistan Lifesavers Programme';
      final sendReport = await send(message, widget.smtpServer);
      print('OTP email sent: ' + sendReport.toString());
    } catch (e) {
      print('Error sending OTP email: ' + e.toString());
      rethrow;
    }
  }
}
