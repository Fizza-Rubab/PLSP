import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const PrimaryColor = Colors.redAccent;



var titleFontStyle = GoogleFonts.poppins(fontSize: 20, 
                fontWeight: FontWeight.bold, 
                letterSpacing: 0, 
                color: Colors.black); 

var generalfontStyle = GoogleFonts.poppins(fontSize: 14, 
                fontWeight: FontWeight.w500, 
                letterSpacing: 0, 
                color: Colors.black38); 

const double defaultPadding = 16.0;


class ApiConstants {
  // static String baseUrl = 'http://kaavish2023.pythonanywhere.com';
  static String baseUrl = 'http://44.230.76.47:8000';
  static String lifesaverEndpoint = '/lifesaver';
  static String userEndpoint = '/users';
  static String citizenEndpoint = '/citizen';
  static String loginEndpoint = '/login/';
  static String signupEndpoint = '/register';
  static String incidentEndpoint = '/incident';
  static String lifesaverHistory = '/incident/lifesaver/';
  static String citizenHistory = '/citzen/lifesaver/';
  static String citizenFeedback = '/postinfo/citizen';
  static String lifesaverFeedback = '/postinfo/lifesaver';





}
