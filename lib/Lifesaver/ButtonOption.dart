import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../texttheme.dart';
import '../constants.dart';

import 'package:url_launcher/url_launcher_string.dart';

class ButtonOption extends StatefulWidget implements PreferredSizeWidget {
  ButtonOption(this.icon, this.title, this.urls);

  final IconData icon;
  final String title;
  final String urls;

  @override
  _ButtonOptionState createState() => _ButtonOptionState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _ButtonOptionState extends State<ButtonOption> {
  Future <void> _launchURL(String Url) async {
    final Uri uri = Uri(scheme: "https", host: Url ); 
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Can not launch url"; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            _launchURL(widget.urls);
          },
          child: Icon(widget.icon, color: PrimaryColor),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            shadowColor: PrimaryColor,
            padding: EdgeInsets.all(20),
            backgroundColor: Colors.white,
            foregroundColor: PrimaryColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          widget.title,
          style: generalfontStyle,
        ),
      ],
    );
  }
}
