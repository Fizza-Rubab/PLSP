import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/towards_emergency.dart';
import '../input_design.dart';
import '../constants.dart';
import 'package:flutter/material.dart';

class Citizen_Home extends StatelessWidget {
  const Citizen_Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14, 86, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: "Hello,\n",
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0, color: Colors.black45, height: 1.1),
                            children: [
                          TextSpan(
                            text: "Fizza Rubab",
                            style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w600, letterSpacing: 0, color: Colors.black45),
                          )
                        ])),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.black12,
                        child: CircleAvatar(
                          radius: 24,
                          foregroundImage: AssetImage('assets/images/profileicon.png'),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Text(
                    "Do you need help?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: PrimaryColor),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Text(
                      "Press the button below to\ncontact a lifesaver",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0, color: Colors.black45),
                    ))
              ],
            )));
  }
}
