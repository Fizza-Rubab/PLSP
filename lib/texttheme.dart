import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

var customTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.poppins(fontSize: 46, fontWeight: FontWeight.w700, letterSpacing: -0.5, color: Colors.black38),
  headline3: GoogleFonts.poppins(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.poppins(
    fontSize: 33,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.25,
  ),
  headline5: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400, color:Colors.black45),
  headline6: GoogleFonts.poppins(fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.lato(fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0.25, color: Colors.white),
  button: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1.25),
  caption: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.lato(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
