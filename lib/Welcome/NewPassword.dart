import 'package:google_fonts/google_fonts.dart';
import './register.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import '../constants.dart';
import '../appbar.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  _MyStaNewPassword createState() => _MyStaNewPassword();
}

class _MyStaNewPassword extends State<NewPassword> {
   bool _obscureText = true;
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
                  "Enter New Password",
                  style: header_disc,
                ),
                const Spacer(),
                TextFormField(
                    obscureText: _obscureText,
                    // controller: password,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Colors.white), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: "New Password",
                      prefixIcon: const Icon(Icons.key_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    // validator: (String? value) {
                    //   if (value!.isEmpty) {
                    //     return 'Please enter your password';
                    //   } else if (!loginSuccess) {
                    //     return 'Email or password is incorrect';
                    //   }
                    //   return null;
                    // },
                  ),



                  const SizedBox(
                    height: 4,
                  ),
                   TextFormField(
                    obscureText: _obscureText,
                    // controller: password,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Colors.white), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: "Confirm new Password",
                      prefixIcon: const Icon(Icons.key_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    // validator: (String? value) {
                    //   if (value!.isEmpty) {
                    //     return 'Please enter your password';
                    //   } else if (!loginSuccess) {
                    //     return 'Email or password is incorrect';
                    //   }
                    //   return null;
                    // },
                  ),

                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        
                             AppLocalizations.of(context)!.no_account,
                        style: generalfontStyle),
                   GestureDetector(
                      onTap: () {
                        // handle tap event here
                       Navigator.push(context, MaterialPageRoute(builder: (context) => const Register())); 
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
                    onPressed: () {},
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Submit",
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
