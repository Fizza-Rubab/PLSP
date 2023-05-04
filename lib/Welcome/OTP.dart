import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/Lifesaver/Lifesaver_Home.dart';
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

void sendOtpEmail(
    String recipientEmail, String recipientName, String generatedOTP) async {
  final String username = 'teamplsp2023@gmail.com';
  final String password = 'qtzhoqtegpyvyfik';
  print(recipientEmail);
  // Create the email message

  try {
    final smtpServer = gmail(username, password);
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
  final String generatedOTP;
  final String email;
  final String firstName;
  const Otp(
      {Key? key,
      required this.generatedOTP,
      required this.email,
      required this.firstName})
      : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String _otp = "XXXX";
  @override
  void initState() {
    super.initState();

    // widget.myFuture.then((value) {
    //   setState(() {
    //     _myString = value;
    //   });
    // });
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
                  "Enter your OTP here",
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
                        print(_otp);
                        // print(generated);
                        if (_otp == Text(widget.generatedOTP)) {
                          print("valid OTP");
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Login()));
                              }).show();
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          // print(Text(widget.email));
                          sendOtpEmail(
                              Text(widget.email).toString(),
                              Text(widget.firstName).toString(),
                              Text(widget.generatedOTP).toString());
                        },
                        child: Text(
                          "Resend Code",
                          style: urlfontStyle,
                        ),
                      ),
                    )
                  ],
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    if (_otp == Text(widget.generatedOTP)) {
                      print("valid OTP");
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Login()));
                          }).show();
                    } else {
                      print("Invalid OTP");
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
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
            _otp = _otp.substring(0, index) +
                value.toString() +
                _otp.substring(index + 1);
            print("OTP Entered so far: " + _otp);
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
}
