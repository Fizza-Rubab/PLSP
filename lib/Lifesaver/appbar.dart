import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter/services.dart';
import '../texttheme.dart';
import '../constants.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  MyAppBar(this.name, this.name1);
  

  final String name; 
  final String name1; 
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override 
  Widget build(BuildContext context) {
    return AppBar(
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
                text: name, 
                style: generalfontStyle,
                children: [
              TextSpan(
                  text: name1, 
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
               
              },
              child: const CircleAvatar(
                radius: 22,
                foregroundImage: AssetImage('assets/images/profileicon.png'),
              ),
            ),
          )
        ],
        );
  }

}

// class MyAppBar extends StatelessWidget with PreferredSize {
//   final String name; 
//   final String name1; 

//    MyAppBar({
//     Key? key, required this.name, required this.name1,
//   }) : super(key: key);
//   @override
//   Size get PreferredSize => Size.fromHeight(kToolbarHeight); 

//   @override

//   Widget build(BuildContext context) {
//     return 
//   }
// }