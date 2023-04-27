// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps/Home/Profile_Editing.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:shared_preferences/shared_preferences.dart';

class CitizenProfile extends StatefulWidget {
  const CitizenProfile({super.key});

  @override
  State<CitizenProfile> createState() => _CitizenProfileState();
}

class _CitizenProfileState extends State<CitizenProfile> {
  final expandedHeight = 240.0;

  final collapsedHeight = 60.0;

  late SharedPreferences _prefs;
  DateTime DOB = DateTime.parse("2021-01-01");
  String first_name = '';
  String last_name = '';
  String address = '';
  String contact_no = '';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        first_name = _prefs.getString('first_name') ?? '';
        last_name = _prefs.getString('last_name') ?? '';
        address = _prefs.getString('address') ?? '';
        DOB = DateTime.parse(_prefs.getString('date_of_birth') ?? '');
        contact_no = _prefs.getString('contact_no') ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
        backgroundColor: greyWhite,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(expandedHeight),
          child: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title: Text(localizations.profile,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colors.black45,
                )),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              // title: Text(localizations.profile,
              //     style: GoogleFonts.poppins(
              //       fontSize: 24,
              //       fontWeight: FontWeight.w600,
              //       letterSpacing: 0,
              //       color: Colors.black45,
              //     )),
              background: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color: Colors.transparent,
                    height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                          image: DecorationImage(
                            image: AssetImage("assets/images/welcome-bg.png"), fit: BoxFit.cover,
                            // colorFilter: ColorFilter.mode(Colors.white12, BlendMode.overlay)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: CircleBorder(),
                      ),
                      child: const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/profileicon.png"),
                        radius: 55,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text('$first_name $last_name',
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0,
                                  color: Colors.black45,
                                )),
                            Text(
                              "Citizen",
                              style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.4, color: Colors.black38, height: 1),
                            )
                          ],
                        ))),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: infoCard(double.infinity, "Address", address)),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6), child: infoCard(double.infinity, "Date of Birth", DateFormat.yMMMMd().format(DOB))),
                      Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: infoCard(double.infinity, "Contact", contact_no)),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          TextButton(
                              // icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileEditing()));
                              },
                              child: Row(children: [
                                const Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: PrimaryColor,
                                  ),
                                ),
                                Text(
                                  'Edit Profile',
                                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1.0, color: PrimaryColor),
                                ),
                              ])),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}

Container infoCard(double width, String title, String text) {
  return Container(
      alignment: Alignment.centerLeft,
      width: width,
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              title,
              style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0.4, color: Colors.black54),
            ),
          ),
          Text(
            text,
            style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.8, color: Colors.black45),
          )
        ],
      ));
}

// SliverAppBar(
//   elevation: 0.0,
//   centerTitle: true,
//   title: Text("Profile",
//       style: GoogleFonts.poppins(
//         fontSize: 24,
//         fontWeight: FontWeight.w600,
//         letterSpacing: 0,
//         color: Colors.black45,
//       )),
//   automaticallyImplyLeading: false,
//   expandedHeight: expandedHeight,
//   collapsedHeight: collapsedHeight,
//   floating: true,
//   pinned: true,
//   snap: true,
//   backgroundColor: Colors.transparent,
//   flexibleSpace: FlexibleSpaceBar(
//     collapseMode: CollapseMode.pin,
//     // title: Text("Profile",
//     //     style: GoogleFonts.poppins(
//     //       fontSize: 24,
//     //       fontWeight: FontWeight.w600,
//     //       letterSpacing: 0,
//     //       color: Colors.black45,
//     //     )),
//     background: Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         Container(
//           color: Colors.transparent,
//           height: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 60),
//             child: Container(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
//                 image: DecorationImage(
//                   image: AssetImage("assets/images/welcome-bg.png"), fit: BoxFit.cover,
//                   // colorFilter: ColorFilter.mode(Colors.white12, BlendMode.overlay)
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 0,
//           child: Container(
//             padding: const EdgeInsets.all(5),
//             decoration: const ShapeDecoration(
//               color: Colors.white,
//               shape: CircleBorder(),
//             ),
//             child: const CircleAvatar(
//               backgroundImage: AssetImage("assets/images/profileicon.png"),
//               radius: 60,
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
// for (int i = 0; i < 10; i++)
//   SliverToBoxAdapter(
//     child: Container(
//       height: 200,
//       color: i % 2 == 0 ? Colors.grey : Colors.grey.shade300,
//     ),
//   ),