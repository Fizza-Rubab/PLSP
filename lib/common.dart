
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<Uint8List> getPdfFromUri(String uri) async {
  final response = await http.get(Uri.parse(uri));
  if (response.statusCode == HttpStatus.ok) {
    return response.bodyBytes;
  } else {
    throw Exception('Failed to load PDF from $uri');
  }
}

void launchUri(Uri mobileNumber) async {
  if (!await launchUrl(mobileNumber)) {
    throw Exception('Could not launch $mobileNumber');
  }
}


String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'shamsahafeez999@gmail.com',
  query: encodeQueryParameters(<String, String>{
    'subject': 'Example Subject & Symbols are allowed!',
  }),
);
