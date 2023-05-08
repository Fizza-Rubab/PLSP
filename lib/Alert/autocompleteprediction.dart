// import 'package:flutter_google_places_autocomplete/flutter_google_places_autocomplete.dart';
// import 'autocompleteprediction.dart';
import 'autocompleteprediction.dart';
import 'place_auto_complete_response.dart';

class StructuredFormatting {
  final String? mainText;
  final String? secondaryText;
  StructuredFormatting({this.mainText, this.secondaryText});
  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['main_text'] as String?,
      secondaryText: json['secondary_text'] as String?,
    );
  }
}

class AutoCompletePrediction {
  String? description;
  final StructuredFormatting? structuredFormatting;
  final String? placeId;
  final String? reference;


  AutoCompletePrediction({
    this.description,
    this.structuredFormatting,
    this.placeId,
    this.reference,

  });

  factory AutoCompletePrediction.fromJson(Map<String, dynamic> json) {
    print("*******************");
    return AutoCompletePrediction(
      description: json['description'] as String?,
      placeId: json['place_id'] as String?,
      reference: json['reference'] as String?,
      structuredFormatting: json['structured_formatting'] != null
          ? StructuredFormatting.fromJson(json['structured_formatting'])
          : null,
    );
  }
}
