// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps/Alert/Arrival.dart';
import 'package:google_maps/Home/Citizen_History.dart';
import 'package:google_maps/Lifesaver/Lifesaver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart';
import 'shared.dart';
import 'Welcome/Welcome.dart';
import 'Home/Citizen.dart';
import 'Lifesaver/Lifesaver_Home.dart';
import 'Alert/searching.dart';
import 'Alert/about_to_reach.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:location/location.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:isolate';
import 'package:get/get.dart';
import 'shared.dart';
import 'Welcome/Welcome.dart';
import 'package:awesome_notifications/awesome_notifications.dart';


sendLocation() async{
    bool is_lifesaver = await SharedPreferences.getInstance().then((prefs) => prefs.getBool('is_lifesaver') ?? false);
    String user_id = await SharedPreferences.getInstance().then((prefs) => prefs.getString('id') ?? "0");
    if (is_lifesaver){
    print("Attempting to send location");
    print(is_lifesaver);
    final location = Location();
    final currentLocation = await location.getLocation();
    print(currentLocation.latitude);
    final locationJson = jsonEncode({
      'user_id': user_id,
      'latitude': currentLocation.latitude,
      'longitude': currentLocation.longitude,
    });
    WebSocketChannel channel;
    while (true) {
      try {
        channel = WebSocketChannel.connect(
          Uri.parse('ws://44.230.76.47:8000/ws/socket-server/'),
        );
        break;
      } catch (e) {
        print('Connection failed: $e');
        await Future.delayed(Duration(seconds: 5));
      }
    }
    channel.sink.add(locationJson);
    print("Location for ls " + user_id + "updated by "+ currentLocation.latitude.toString() + "," +currentLocation.longitude.toString());
  }
}

void runBackgroundTask(RootIsolateToken rootIsolateToken) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  const duration = const Duration(seconds: 60);
  new Timer.periodic(duration, (Timer t) => sendLocation());
}

Future<void> main() async {
  AwesomeNotifications().initialize(
    'resource://drawable/res_img_test',
    [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'basic notifications',
          defaultColor: Colors.redAccent,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          )
    ],
  );
  sharedPrefInit();
  NotificationController.initializeLocalNotifications();
  NotificationController.initializeRemoteNotifications(debug: true);
  NotificationController.getFirebaseMessagingToken().toString();
  WidgetsFlutterBinding.ensureInitialized();
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance;
  Isolate.spawn(runBackgroundTask, rootIsolateToken);
  bool x =  await SharedPreferences.getInstance().then((prefs) => prefs.getBool('logged_in') ?? false);
  print("checking status " + x.toString());
  x = false;
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Welcome(
    who: x?'logged_in':'logged_out',
  )));
}
