import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const PrimaryColor = Colors.redAccent;
const greyWhite = Color(0xffEFF2F4);

const peachColor = Color.fromARGB(255, 253, 129, 107);

var titleFontStyle = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    color: Colors.black);

var generalfontStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: Colors.black38);

var whitegeneralfontStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: Colors.white);

var header_disc = GoogleFonts.lato(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    color: Colors.black45);
    
var boldheader = GoogleFonts.poppins(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: Colors.black54);

var urlfontStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: Colors.redAccent,
    decoration: TextDecoration.underline);

const double defaultPadding = 16.0;

class ApiConstants {
  // static String baseUrl = 'http://kaavish2023.pythonanywhere.com';
  // http://10.0.2.2:8000
  static String baseUrl = 'http://kaavish2023.pythonanywhere.com';
  static String lifesaverEndpoint = '/lifesaver';
  static String userEndpoint = '/users';
  static String citizenEndpoint = '/citizen';
  static String loginEndpoint = '/login/';
  static String signupEndpoint = '/register';
  static String incidentEndpoint = '/incident';
}
