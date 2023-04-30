import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter/services.dart';
import 'texttheme.dart';
import 'constants.dart';


 class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {

  SimpleAppBar(this.title_text);
  

  final String title_text; 

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override 
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.redAccent,),
          onPressed: () => Navigator.pop(context),
        ),
        // iconTheme: IconThemeData(color: appbar_icon_color),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          title_text,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
            color: Colors.redAccent,
          ),
        ),
        centerTitle: true,
      );   }

}



class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  MyAppBar({
    ImageProvider<Object>? imageProvider,
    this.name = 'Default Title',
    this.name1 = 'he',
  }) : this.imageProvider = imageProvider ?? AssetImage('assets/images/profileicon.png');

  final String name; 
  final String name1; 
  final ImageProvider<Object> imageProvider;
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
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0, color: Colors.black38, height: 1.1),
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
              child: CircleAvatar(
                radius: 22,
                foregroundImage: imageProvider,
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