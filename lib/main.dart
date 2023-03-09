import 'package:flutter/material.dart';
import 'package:google_maps/homepage.dart';
import 'package:google_maps/post_arrival.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'login.dart';
import 'profile.dart';
import 'register.dart';
import 'towards_emergency.dart';
import 'alert_details.dart';
import 'searching.dart';
import 'dart:async';
import 'coming.dart';
import 'arrived.dart';
import 'homepage.dart';
import 'display.dart';
import 'shared.dart';


void main() {
  sharedPrefInit();
  runApp(DisplayPage());
}