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

enum LocaleMenu { itemOne, itemTwo, itemThree, itemFour }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PLSP',
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          textTheme: customTextTheme,
          navigationBarTheme: NavigationBarThemeData(
              backgroundColor: Colors.red.shade50,
              height: 64,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
          textDirection: TextDirection.ltr,
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
                          "Pakistan Lifesavers\nProgramme",
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
                                });
                                // widget.setLocale(Locale.fromSubtags(languageCode: selected_lang.split(' - ')[1]));
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<LocaleMenu>>[
                                const PopupMenuItem<LocaleMenu>(
                                  value: LocaleMenu.itemOne,
                                  child: Text('English - en'),
                                ),
                                const PopupMenuItem<LocaleMenu>(
                                  value: LocaleMenu.itemTwo,
                                  child: Text('Urdu - ur'),
                                ),
                                const PopupMenuItem<LocaleMenu>(
                                  value: LocaleMenu.itemThree,
                                  child: Text('Pashto - ps'),
                                ),
                                const PopupMenuItem<LocaleMenu>(
                                  value: LocaleMenu.itemFour,
                                  child: Text('Panjabi - pa'),
                                ),
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
                                        "Register",
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
                                      "Login",
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
                                "Do you want to help\nsave lives?",
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
                                    "Become a Lifesaver",
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
