import 'package:flutter/material.dart';
import './constants.dart';

InputDecoration buildInputDecoration(IconData icons, String hinttext) {
  return InputDecoration(
    hintText: hinttext,
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
