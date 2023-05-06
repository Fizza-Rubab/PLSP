import 'package:google_fonts/google_fonts.dart';
import './register.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import '../input_design.dart';
import '../constants.dart';
import '../appbar.dart';
import 'NewPassword.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _MyStaForgotPassword createState() => _MyStaForgotPassword();
}

class _MyStaForgotPassword extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const SimpleAppBar(""),
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
                const Spacer(),
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
                const Spacer(),
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
                                builder: (context) => const Register()));
                      },
                      child: Text(
                        AppLocalizations.of(context)!.register,
                        style: urlfontStyle,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                TextButton(
                    // icon: Icon(Icons.chevron_right),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewPassword()));
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
