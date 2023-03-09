import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './constants.dart';

InputDecoration buildInputDecoration(IconData icons, String hinttext) {
  return InputDecoration(
    labelText: hinttext,
    labelStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    // hintText: hinttext,
    prefixIcon: Icon(icons),
    filled: true,
    fillColor: Colors.grey.shade200,
    focusColor: Colors.red.shade50,

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide: const BorderSide(style: BorderStyle.none, width: 0),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide: const BorderSide(
        style: BorderStyle.none, width: 0
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide: const BorderSide(
        style: BorderStyle.none, width: 0
      ),
    ),
  );
}
