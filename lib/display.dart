import 'package:flutter/material.dart';
import 'package:multi_language_json/multi_language_json.dart';
import 'old_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_localizations/flutter_localizations.dart";

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPage createState() => _DisplayPage();
}

class _DisplayPage extends State<DisplayPage> {
  Locale? _locale;
  void setLocale(Locale val) {
    setState(() {
      print("here");
      print(val);
      _locale = val;
      print(_locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        home: DisplayContent(setLocale: setLocale));
  }
}

class DisplayContent extends StatefulWidget {
  const DisplayContent({
    required this.setLocale,
    super.key,
  });
  final void Function(Locale locale) setLocale;

  @override
  State<DisplayContent> createState() => _DisplayContentState();
}

class _DisplayContentState extends State<DisplayContent> {
  String dropdownValue = 'Select Language';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.language),
        backgroundColor: Color.fromRGBO(255, 0, 95, 1),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 80, 0, 0)),
            Image.asset(
              'assets/images/Image2.png',
              scale: 0.75,
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            DropdownButton<String>(
              // Step 3.
              value: dropdownValue,
              // Step 4.
              items: <String>[
                'Select Language',
                'English - en',
                'Urdu - ur',
                'Pashto - ps',
                'Panjabi - pa'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    // style: TextStyle(fontSize: 20),
                  ),
                );
              }).toList(),
              // Step 5.
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
                if (dropdownValue!='Select Language'){
                    widget.setLocale(Locale.fromSubtags(languageCode: dropdownValue.split(' - ')[1]));
                }
              },
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            ElevatedButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogIn()));}, child: Text('Proceed'))

          ],
        ),
      ),
    );
  }
}
