import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../appbar.dart';
import '../constants.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class EmergencyService {
  final String name;
  final String phoneNumber;

  EmergencyService({required this.name, required this.phoneNumber});
}

class Helplines extends StatelessWidget {
  Helplines({super.key});
  final List<EmergencyService> emergencyServices = [
    EmergencyService(name: 'Edhi Foundation', phoneNumber: '115'),
    EmergencyService(name: 'Chhipa Ambulance', phoneNumber: '1020'),
    EmergencyService(name: 'Aman Ambulance', phoneNumber: '1021'),
    EmergencyService(name: 'Karachi Rescue', phoneNumber: '1122'),
    EmergencyService(name: 'Sindh Police Madadgar', phoneNumber: '15'),
    EmergencyService(name: 'Women Helpline', phoneNumber: '1094'),
  ];


  Future<void> _launchPhoneApp(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double space_between = 20.0;
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: SimpleAppBar("Helpline Contacts"),
      body: ListView.builder(
        itemCount: emergencyServices.length,
        itemBuilder: (context, index) {
          final service = emergencyServices[index];
          return Card(
            child: ListTile(
              title: Text(service.name),
              subtitle: Text(service.phoneNumber),
              onTap: () => _launchPhoneApp(service.phoneNumber),
            ),
          );
        },
      ),
    );
  }
}

  