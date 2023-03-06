import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:plsp/RegisterLogin/Login.dart';
import '../constants.dart';
import 'Login.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 5 / 8,
            padding: const EdgeInsets.fromLTRB(14, 86, 14, 28),
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/welcome-bg.png"), fit: BoxFit.cover),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Pakistan Lifesavers\nProgramme",
                style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -0.5, color: Colors.black38),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(onPressed: () {}, color: Colors.white, icon: const Icon(Icons.language_rounded)),
                  const Spacer(),
                  SizedBox(
                      height: 48,
                      child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(width: 1.0, color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Text(
                              "Register",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ))),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                        onPressed: () => (
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Login()))
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const StadiumBorder(),
                          backgroundColor: PrimaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            "Login",
                            style: Theme.of(context).textTheme.bodyText2,
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
                      child: Text("Do you want to help save lives?", textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 19, fontWeight: FontWeight.w400, letterSpacing: 0.15, color: Colors.black45))
                    ),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(width: 1.0, color: PrimaryColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Text(
                              "Become a Lifesaver",
                              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0.25, color: PrimaryColor),
                            ),
                          )),
                    ),
                  ],
                )))
      ],
    ));
  }
}
