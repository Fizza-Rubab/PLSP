import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration buildInputDecoration(IconData icons, String hinttext, {BorderRadius border = const BorderRadius.all(Radius.circular(50))}) {
  return InputDecoration(
    labelText: hinttext,
    labelStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.8),
    // hintText: hinttext,
    prefixIcon: Icon(icons),
    filled: true,
    fillColor: Colors.grey.shade200,
    focusColor: Colors.red.shade50,

    focusedBorder: OutlineInputBorder(
      borderRadius: border,
      borderSide: const BorderSide(style: BorderStyle.none, width: 0),
    ),
    border: OutlineInputBorder(
      borderRadius: border,
      borderSide: const BorderSide(
        style: BorderStyle.none, width: 0
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: border,
      borderSide: const BorderSide(
        style: BorderStyle.none, width: 0
      ),
    ),
  );
}
