import 'package:google_fonts/google_fonts.dart';
import './register.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import '../Home/Citizen.dart';
import '../input_design.dart';
import '../constants.dart';
import '../shared.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../appbar.dart';
import 'NewPassword.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _MyStaForgotPassword createState() => _MyStaForgotPassword();
}

class _MyStaForgotPassword extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SimpleAppBar(""),
        body: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  AppLocalizations.of(context)!.reset_pass,
                  style: boldheader,
                ),
                Text(
                  AppLocalizations.of(context)!.reset_pass_disc,
                  style: header_disc,
                ),
                Spacer(),
                TextFormField(
                  // controller: "Email",
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: buildInputDecoration(
                      Icons.email_rounded, AppLocalizations.of(context)!.email),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return 'Please a valid Email';
                    }
                    return null;
                  },
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.no_account,
                        style: generalfontStyle),
                    GestureDetector(
                      onTap: () {
                        // handle tap event here
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        AppLocalizations.of(context)!.register,
                        style: urlfontStyle,
                      ),
                    )
                  ],
                ),
                Spacer(),
                TextButton(
                    // icon: Icon(Icons.chevron_right),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewPassword()));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.send_code_via_email,
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
                        ])),
              ]),
        ),
      ),
    ); // replace this with your own widget tree
  }
}
