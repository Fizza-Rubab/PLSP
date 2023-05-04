import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../appbar.dart';
import '../common.dart';
import 'termsAndPolicy.dart';
import 'TrainingBrochure.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_pdfview/flutter_pdfview.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

const double padding_val = 30;

class LifesaverHome extends StatefulWidget {
  const LifesaverHome({super.key});

  @override
  State<LifesaverHome> createState() => _LifesaverHomeState();
}

List<IconData> icons = [
  Icons.monitor_heart,
  Icons.notes,
  Icons.accessibility,
  Icons.web_rounded,
  Icons.call,
  Icons.book_online_outlined,
];

class _LifesaverHomeState extends State<LifesaverHome> {
  File? pickedImage;
   var first_name;
   var last_name; 
 
  @override
  initState() {
    super.initState();
    _loadImageFromLocal();
    _fetchName(); 
  }

  @override
  Future<void> _fetchName() async {
    final response = await http.get(Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.lifesaverEndpoint}/${await SharedPreferences.getInstance().then((prefs) => prefs.getString('id') ?? "")}'));
    setState(() {
      first_name = json.decode(response.body)['first_name'];
      last_name = json.decode(response.body)['last_name'];
    });
  }

  void _loadImageFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');
    
    if (imagePath != null) {
      setState(() {
        pickedImage = File(imagePath);
        print("inher");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    List<String> titles = [
      localizations.ourision,
      localizations.terms_and_conditions,
      localizations.brochure,
      localizations.website,
      localizations.helpline,
      localizations.manual
    ];
    print(first_name); 
    print(last_name); 
    return Scaffold(
      backgroundColor: greyWhite,
      appBar: pickedImage == null
          ? MyAppBar(name: localizations.hello, name1: "$first_name $last_name")
          : MyAppBar(
              name: localizations.hello,
              name1: "$first_name $last_name",
              imageProvider: FileImage(pickedImage!),
            ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
        child: Column(
          children: [
            const Spacer(),
            Padding(
                padding: const EdgeInsets.all(padding_val),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 36.0),
                      child: Text(
                       localizations.ask_availibility,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                            color: Colors.black45,
                            height:
                                MediaQuery.of(context).size.height * (1 / 512)),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.6,
                      child: LiteRollingSwitch(
                        value: true,
                        textOn:localizations.available,
                        textOff: localizations.unavailable,
                        colorOn: Colors.green,
                        colorOff: Colors.red,
                        iconOn: Icons.check,
                        iconOff: Icons.close,
                        textSize: 10.0,
                        onChanged: (bool position) {},
                      ),
                    ),
                  ],
                )),
            // Padding(
            //   padding: const EdgeInsets.all(padding_val),
            //   child: OutlinedButton(
            //     // style: ElevatedButton.styleFrom(
            //     //     shape: RoundedRectangleBorder(
            //     //       borderRadius: BorderRadius.circular(20),
            //     //       side: const BorderSide(color: Colors.red),
            //     //     ),
            //     //     backgroundColor: Colors.white),
            //     onPressed: () {
            //       AwesomeDialog(
            //               context: context,
            //               dialogType: DialogType.success,
            //               animType: AnimType.topSlide,
            //               descTextStyle: generalfontStyle,
            //               titleTextStyle: titleFontStyle,
            //               title: "Request Sent",
            //               desc: "Your request has been sent successfully. Our team will contact you shortly",
            //               btnOkOnPress: () {})
            //           .show();
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.all(10),
            //       child: Text(
            //         "Become a Master Trainer",
            //         style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0.25, color: Colors.red.shade800),
            //       ),
            //     ),
            //   ),
            // ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(20.0),
              //   gradient: const LinearGradient(
              //     colors: [Color.fromRGBO(252, 220, 172, 1), Color.fromRGBO(252, 172, 166, 1)],
              //     begin: Alignment.centerLeft,
              //     end: Alignment.centerRight,
              //   ),
              // ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 8.0,
                children: List.generate(6, (index) {
                  return SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (_) => PDFViewerFromAsset(
                                pdfAssetPath: 'assets/pdf/vision_mission.pdf',
                              ),
                            ),
                          );
                        }
                        if (index == 5) {
                          Navigator.push(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (_) => PDFViewerFromAsset(
                                pdfAssetPath: 'assets/pdf/training_manual.pdf',
                              ),
                            ),
                          );
                        }
                        if (index == 4) {
                          launchUri(helpline);
                        }
                        if (index == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (_) => PDFViewerFromAsset(
                                pdfAssetPath: 'assets/pdf/brochure.pdf',
                              ),
                            ),
                          );
                        }
                        if (index == 3) {
                          launchUri(website);
                        }
                        if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TermsAndConditions()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          backgroundColor: Colors.white),
                      child: Column(
                        children: [
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Icon(icons[index],
                                color: PrimaryColor, size: 28),
                          ),
                          Text(
                            titles[index],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.0,
                                color: PrimaryColor),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
