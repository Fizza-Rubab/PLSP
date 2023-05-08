import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'autocompleteprediction.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

Future<LatLng> getLatLongFromPlaceId(String placeId) async {
  final apiUrl =
      'https://maps.googleapis.com/maps/api/geocode/json?place_id=$placeId&key=$api_key';
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final location = json['results'][0]['geometry']['location'];
    final lat = location['lat'];
    final lng = location['lng'];
    print(LatLng(lat, lng).toString());
    return LatLng(lat, lng);
  } else {
    throw Exception('Failed to get location data from API.');
  }
}

class PlaceAutocompleteResponse {
  final String? status;
  final List<AutoCompletePrediction>? predictions;

  PlaceAutocompleteResponse({this.status, this.predictions});

  factory PlaceAutocompleteResponse.fromJson(Map<String, dynamic> json) {
    return PlaceAutocompleteResponse(
      status: json['status'] as String?,
      predictions: json['predictions'] != null
          ? json['predictions']
              .map<AutoCompletePrediction>(
                  (json) => AutoCompletePrediction.fromJson(json))
              .toList()
          : null,
    );
  }

  static PlaceAutocompleteResponse parseAutocompleteResult(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlaceAutocompleteResponse.fromJson(parsed);
  }
}

class LocationListTile extends StatelessWidget {
  final String location;
  final VoidCallback press;

  const LocationListTile({
    Key? key,
    required this.location,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Location------------------");
    print(location);
    return ListTile(
      tileColor: Colors.redAccent,
      title: Text(location),
      onTap: press,
    );
  }
}
