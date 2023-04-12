import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps/Home/Citizen.dart';
import 'package:google_maps/Lifesaver/Lifesaver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class ThankYouScreen extends StatefulWidget {
  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black54,
        title: Center(
          child: Text("A Token of Thanks",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
                color: Colors.black45,
              )),
        ),
          automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              'Well done, Aiman!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          ),
          Image.asset(
            'assets/images/thanku.gif',
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text(
            'Thank you for saving a life!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                'Your appropriate use of this help has made an impact in health care. We appreciate your efforts.',
              style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: Colors.grey.shade800,
                  
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.redAccent,
                          fixedSize:
                              Size(MediaQuery.of(context).size.width / 2.4, 30),
                          textStyle: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              color: Colors.white),
                        ),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          bool value = prefs.getBool("is_lifesaver")??false;
                          print(value); // or do whatever you want with the retrieved value 
                          if (value)
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Lifesaver()));
                          else
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Citizen()));
                          },
                        child: Text(
                          'Goto Home',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                              color: Colors.grey.shade100),
                        ),
                      ),
          SizedBox(height: 20,),
                    
        ],
      ),
    );
  }
}
