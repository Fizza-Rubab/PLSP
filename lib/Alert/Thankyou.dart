import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps/Home/Citizen.dart';

class ThankYouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          Image.network(
            'https://i.pinimg.com/originals/a7/7f/7b/a77f7bf8d6aa5d82ffc2565132ca9c40.gif',
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
                        onPressed: () {
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
