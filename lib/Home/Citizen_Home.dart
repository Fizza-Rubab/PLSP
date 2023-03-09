import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/Alert/alert_details.dart';
import 'package:google_maps/towards_emergency.dart';
import '../input_design.dart';
import '../constants.dart';
import 'package:flutter/material.dart';
import '../profile.dart';

class CitizenHome extends StatelessWidget {
  const CitizenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 14,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: RichText(
              text: TextSpan(
                  text: "Hello,\n",
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0, color: Colors.black38, height: 1.1),
                  children: [
                TextSpan(
                    text: "Fizza Rubab",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      color: Colors.black45,
                    ))
              ])),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Profile()));
                },
                child: const CircleAvatar(
                  radius: 22,
                  foregroundImage: AssetImage('assets/images/profileicon.png'),
                ),
              ),
            )
          ],
          ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(14, 48, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * (1/32)),
              child: Text(
                "Do you need help?",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: PrimaryColor),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Text(
                  "Press the button below to\ncontact a lifesaver",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: Colors.black45, height: MediaQuery.of(context).size.height * (1/512)),
                )),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * (1/10), bottom: MediaQuery.of(context).size.height * (1/10)),
              child: Container(
                height: MediaQuery.of(context).size.width / 2 + 14,
                width: MediaQuery.of(context).size.width / 2 + 14,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 20,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(14),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width / 2,
                  width: MediaQuery.of(context).size.width / 2,
                  child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    splashColor: Colors.orange.shade400,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Alert_Details()));
                    },
                    child: Icon(
                      Icons.call_outlined,
                      size: MediaQuery.of(context).size.width / 4,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ))
    );
  }
}
