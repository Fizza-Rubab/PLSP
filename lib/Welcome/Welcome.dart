import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:plsp/RegisterLogin/Login.dart';
import '../constants.dart';
import 'Login.dart';
import '../shared.dart';
import '../texttheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import 'package:flutter/services.dart';

enum LocaleMenu { en, ur, pa, ps }
TextDirection td = TextDirection.ltr;


class Welcome extends StatefulWidget {
  @override
  _Welcome createState() => _Welcome();
}

class _Welcome extends State<Welcome> {
  Locale? _locale;
  void setLocale(Locale val) {
    setState(() {
      _locale = val;
    });
  }

  
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PLSP',
        theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.redAccent),
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          textTheme: customTextTheme,
          navigationBarTheme: NavigationBarThemeData(
              backgroundColor: Colors.red.shade50,
              height: 72,
              labelTextStyle: MaterialStateProperty.all(
                GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.red.shade900),
              )),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: const StadiumBorder(),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              shape: const StadiumBorder(),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              shape: const StadiumBorder(),
            ),
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        home: WelcomeContent(setLocale: setLocale));
  }
}

class WelcomeContent extends StatefulWidget {
  const WelcomeContent({required this.setLocale, super.key});
  final void Function(Locale locale) setLocale;
  @override
  State<WelcomeContent> createState() => _WelcomeContentState();
}

class _WelcomeContentState extends State<WelcomeContent> {
  String selected_lang = 'English - en';

  // @override
  // void initState() {
  //   super.initState();
  //   if (Platform.isAndroid) {
  //     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //         systemNavigationBarColor: Colors.deepOrange,
  //         systemNavigationBarIconBrightness: Brightness.light));
  //   }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
          textDirection: td,
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 5 / 8,
                  padding: const EdgeInsets.fromLTRB(14, 86, 14, 28),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/welcome-bg.png"),
                        fit: BoxFit.cover,
                        // colorFilter: ColorFilter.mode(Colors.white12, BlendMode.overlay)
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.plsp,
                          style: GoogleFonts.poppins(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                              color: Colors.black38),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PopupMenuButton<LocaleMenu>(
                              icon: const Icon(
                                Icons.translate_outlined,
                                size: 30,
                                color: Colors.white,
                              ), //use this icon
                              onSelected: (LocaleMenu item) {
                                setState(() {
                                  selected_lang = item.name;
                                  if (selected_lang=='ur')
                                    td = TextDirection.rtl;
                                  else
                                    td = TextDirection.ltr;
                                });
                                print(selected_lang);
                                widget.setLocale(Locale.fromSubtags(languageCode: selected_lang));
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<LocaleMenu>>[
                                const PopupMenuItem<LocaleMenu>(
                                  value: LocaleMenu.en,
                                  child: Text('English - en'),
                                ),
                                const PopupMenuItem<LocaleMenu>(
                                  value: LocaleMenu.ur,
                                  child: Text('Urdu - ur'),
                                ),
                                // const PopupMenuItem<LocaleMenu>(
                                //   value: LocaleMenu.ps,
                                //   child: Text('Pashto - ps'),
                                // ),
                                // const PopupMenuItem<LocaleMenu>(
                                //   value: LocaleMenu.pa,
                                //   child: Text('Panjabi - pa'),
                                // ),
                              ],
                            ),

                            // IconButton(
                            //   onPressed: () {},
                            //   color: Colors.white,
                            //   icon: const Icon(Icons.translate_outlined),
                            //   iconSize: 30,
                            // ),
                            const Spacer(),
                            SizedBox(
                                height: 48,
                                child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.white24),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 8),
                                      child: Text(
                                        AppLocalizations.of(context)!.register,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ))),
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                  onPressed: () => (Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Login()))),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: const StadiumBorder(),
                                    backgroundColor: PrimaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      AppLocalizations.of(context)!.login,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ])),
              Expanded(
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 28),
                      // decoration: const BoxDecoration(
                      //     image: DecorationImage(image: AssetImage("assets/images/welcome-bg.png"), fit: BoxFit.cover),
                      //     borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Text(
                                AppLocalizations.of(context)!.welcome_caption,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.0,
                                    color: Colors.black38),
                              )),
                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red.withOpacity(0.15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12),
                                  child: Text(
                                    AppLocalizations.of(context)!.become_lifesaver,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.25,
                                        color: Colors.red.shade800),
                                  ),
                                )),
                          ),
                        ],
                      )))
            ],
          )),
    );
  }
}
