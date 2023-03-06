import 'package:flutter/material.dart';
import 'package:multi_language_json/multi_language_json.dart';
import 'old_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPage createState() => _DisplayPage();
}

class _DisplayPage extends State<DisplayPage> {
  final language = MultiLanguageBloc(
      initialLanguage: 'en_US',
      defaultLanguage: 'en_US',
      commonRoute: 'common',
      supportedLanguages: ['en_US', 'pt_BR', 'ur_PK', 'sd_PK']);

  @override
  Widget build(BuildContext context) {
    return MultiLanguageStart(
        future: language.init(),
        builder: (c) => MultiStreamLanguage(
            screenRoute: ['home'],
            builder: (c, d) => Scaffold(
                  appBar: AppBar(
                    title: Text(d.getValue(route: ['title'])),
                    backgroundColor: Color.fromRGBO(255, 0, 95, 1),
                  ),
                  body: Center(
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(0, 80, 0, 0)),
                        Image.asset('assets/images/Image2.png', scale: 0.75,),
                        Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                        ElevatedButton(
                          child: Text(d.getValue(route: ['btn'])),
                          onPressed: () => language.showAlertChangeLanguage(
                              context: context,
                              title: d.getValue(
                                  route: ['dialog', 'title'], inRoute: false),
                              btnNegative: d.getValue(
                                  route: ['dialog', 'btn_negative'],
                                  inRoute: false)),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(255, 0, 95, 1)),
                          ),
                        ),
                        ElevatedButton(
                          child: Text(d.getValue(route: ['btn2'])),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LogIn()));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(255, 0, 95, 1)),
                          ),
                        ),
                      
                      ],
                      
                    ),
                  ),
                )));
  }
}
