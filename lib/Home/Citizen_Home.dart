// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/Alert/alert_details.dart';
import 'package:google_maps/Lifesaver/appbar.dart';
import '../constants.dart';
import '../profile.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
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
  File? pickedImage;

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
    _loadImageFromLocal();
  }
  void _loadImageFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');
    if (imagePath != null) {
      setState(() {
        pickedImage = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: MyAppBar(name:localizations.hello, name1:'$first_name $last_name', imageProvider:FileImage(pickedImage!)),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14, 48, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * (1 / 32)),
                  child: Text(
                    localizations.help,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        color: PrimaryColor),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Text(
                      localizations.instruct,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                          color: Colors.black45,
                          height:
                              MediaQuery.of(context).size.height * (1 / 512)),
                    )),
                const Spacer(),
                Container(
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Alert_Details()));
                      },
                      child: Icon(
                        Icons.call_outlined,
                        size: MediaQuery.of(context).size.width / 4,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            )));
  }
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(StringProperty('last_name', last_name));
  // }
}
