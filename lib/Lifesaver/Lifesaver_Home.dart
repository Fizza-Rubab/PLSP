import 'package:flutter/src/widgets/container.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../texttheme.dart';
import '../constants.dart';
import 'appbar.dart';
import 'ButtonOption.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:url_launcher/url_launcher_string.dart';
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
  Icons.handshake,
  Icons.call,
  Icons.accessible,
];
List<String> titles = [
  "Patient Safety",
  "Notes",
  "Values",
  "Accessability",
  "Helpline",
  "Others"
];

List<String> urls = [
  "www.plsp.com", // Brochure 
  "www.plsp.org.pk/Style%20Library/Images/EducationalResources/PLSP%20Brochure%20-%20Email.pdf", // Training Presentation  
  "https://plsp.org.pk/Pages/educationalresources.aspx", // Manual 
   "https://plsp.org.pk/Style%20Library/Images/EducationalResources/PLSP%20Brochure%20-%20Email.pdf", // Brochure 
  "https://plsp.org.pk/Pages/educationalresources.aspx", // Training Presentation  
  "https://plsp.org.pk/Pages/educationalresources.aspx" //
]; 

//  TextSpan(
//                                   text: "Terms and privacy policy.",
//                                   style: urlfontStyle,
//                                   recognizer: TapGestureRecognizer()
//                                     ..onTap = () {
//                                       const url = "https://google.com.pk";
//                                       launchUrlString(url);
//                                     }),
class _LifesaverHomeState extends State<LifesaverHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Hello\n", "Shamsa Hafeez"),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(padding_val),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Change Availability",
                    style: generalfontStyle,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  LiteRollingSwitch(
                    value: true,
                    textOn: "Available",
                    textOff: "Unavailable",
                    colorOn: Colors.green,
                    colorOff: Colors.red,
                    iconOn: Icons.event_available,
                    iconOff: Icons.event_busy,
                    textSize: 12.0,
                    onChanged: (bool position) {
                      print("The button is $position");
                    },
                  ),
                ],
              )),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(252, 220, 172, 1),
                  Color.fromRGBO(252, 172, 166, 1)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: List.generate(6, (index) {
                return Center(
                  child: ButtonOption(icons[index], titles[index], urls[index]),
                );
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(padding_val),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.red),
                  ),
                  backgroundColor: Colors.white),
              onPressed: () {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.topSlide,
                        descTextStyle: generalfontStyle,
                        titleTextStyle: titleFontStyle,
                        title: "Request Sent",
                        desc:
                            "Your request has been sent successfully. Our team will contact you shortly",
                        btnOkOnPress: () {})
                    .show();
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Become a Master Trainer",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.25,
                      color: Colors.red.shade800),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
