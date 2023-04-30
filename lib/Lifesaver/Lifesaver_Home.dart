import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/src/widgets/container.dart';
import 'dart:io';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'ButtonOption.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "../Welcome/Welcome.dart";
import '../appbar.dart';

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
List<String> titles = ["Patient Safety", "Notes", "Values", "Accessability", "Helpline", "Others"];
List<String> urls = [
  "https://plsp.org.pk/Pages/home.aspx",
  "https://plsp.org.pk/Pages/home.aspx",
  "https://plsp.org.pk/Pages/home.aspx",
  "https://plsp.org.pk/Pages/home.aspx",
  "https://plsp.org.pk/Pages/home.aspx",
  "https://plsp.org.pk/Pages/home.aspx"
];

class _LifesaverHomeState extends State<LifesaverHome> {
  File? pickedImage;
  late SharedPreferences _prefs;
  String first_name = '';
  String last_name = '';

  @override
  initState() {
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
        print("inher");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyWhite,
      appBar: pickedImage == null
          ? MyAppBar(name: "Hello\n", name1: '$first_name $last_name')
          : MyAppBar(
              name: "Hello\n",
              name1: '$first_name $last_name',
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
                        "Are you available to help?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                            color: Colors.black45,
                            height: MediaQuery.of(context).size.height * (1 / 512)),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.6,
                      child: LiteRollingSwitch(
                        value: true,
                        textOn: "Available",
                        textOff: "Unavailable",
                        colorOn: Colors.green,
                        colorOff: Colors.blueGrey.shade300,
                        iconOn: Icons.check,
                        iconOff: Icons.close,
                        textSize: 10.0,
                        onChanged: (bool position) {
                          print("The button is $position");
                        },
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
                      onPressed: () {},
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
                            child: Icon(icons[index], color: PrimaryColor, size: 28),
                          ),
                          Text(
                            titles[index],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.0, color: PrimaryColor),
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
