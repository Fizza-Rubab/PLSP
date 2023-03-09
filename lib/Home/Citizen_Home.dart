// ignore_for_file: non_constant_identifier_names

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/towards_emergency.dart';
import 'package:http/http.dart';
import '../input_design.dart';
import '../constants.dart';
import 'package:flutter/material.dart';
import '../profile.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import '../shared.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CitizenHome extends StatefulWidget {
  const CitizenHome({super.key});

  @override
  State<CitizenHome> createState() => _CitizenHomeState();
}

class _CitizenHomeState extends State<CitizenHome> {
  late SharedPreferences _prefs;
  String first_name = '';
  String last_name = '';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        first_name = _prefs.getString('first_name') ?? '';
        last_name = _prefs.getString('last_name') ?? '';
      });
    });
    
    print("initState() called");
  }
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
                  text: AppLocalizations.of(context)!.hello,
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0, color: Colors.black38, height: 1.1),
                  children: [
                TextSpan(
                    text: first_name + ' ' + last_name,
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
              padding: const EdgeInsets.only(bottom: 14),
              child: Text(
                AppLocalizations.of(context)!.help,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: PrimaryColor),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Text(
                  AppLocalizations.of(context)!.instruct,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.2, color: Colors.black45),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 42, bottom: 36),
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
                    onPressed: () {},
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
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(StringProperty('last_name', last_name));
  // }
}
