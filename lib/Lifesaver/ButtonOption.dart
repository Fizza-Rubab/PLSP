import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter/services.dart';
import '../texttheme.dart';
import '../constants.dart';

class ButtonOption extends StatelessWidget implements PreferredSizeWidget {
  ButtonOption(this.icon, this.title, this.url);

  final IconData icon;
  final String title;
  final String url;
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Icon(icon, color: PrimaryColor),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            shadowColor: PrimaryColor,
            padding: EdgeInsets.all(20),
            backgroundColor: Colors.white, // <-- Button color
            foregroundColor: PrimaryColor, // <-- Splash color
          ),
        ),
        SizedBox(height: 8), // add some spacing between the button and text
        Text(
          title,
          style: generalfontStyle,
        ),
      ],
    );
  }
}
