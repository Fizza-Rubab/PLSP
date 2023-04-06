

import 'package:flutter/src/widgets/container.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../texttheme.dart';
import '../constants.dart';
import 'appbar.dart';
import 'ButtonOption.dart'; 
import 'package:awesome_dialog/awesome_dialog.dart';

const double padding_val = 30; 

class LifeSaverMain extends StatefulWidget {
  const LifeSaverMain({super.key});
  

  @override
  State<LifeSaverMain> createState() => _LifeSaverMainState();
}
List<IconData> icons = [  Icons.monitor_heart,  
Icons.notes,  
Icons.accessibility, 
 Icons.handshake, 
  Icons.call, 
   Icons.accessible,];
List<String> titles = [
  "Patient Safety",
  "Notes",
  "Values",
  "Accessability", 
  "Helpline",
  "Others"
]; 
class _LifeSaverMainState extends State<LifeSaverMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: MyAppBar("Hello ", "Shamsa"),
   
    
      body: Column  (
       
        children: [
          
Padding(padding: EdgeInsets.all(padding_val), 
child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
  
 Text("Change Availability", style: generalfontStyle,),
 SizedBox(
  height: MediaQuery.of(context).size.width * 0.05,
 ),
LiteRollingSwitch(
  value: true,
 
  textOn: "Available",
  textOff: "Unavailable",
  colorOn: Colors.green,
  colorOff: Colors.red,
  iconOn: Icons.event_available,
  iconOff: Icons.event_busy,
  textSize: 12.0,
  onChanged: (bool position) {
    print("The button is $position"); 
  },

),
],)),        
          Container(
             decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(252,220,172, 1),
        Color.fromRGBO(252,172,166, 1)
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),), 
            child: GridView.count(
            
            shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
  crossAxisCount: 3,
  children: List.generate(6, (index) {
    return Center(
      child: ButtonOption(icons[index], titles[index]), 
    );
  }),
),
          ),
     

       Padding(padding: EdgeInsets.all(padding_val), 
       child: ElevatedButton(
  style: ElevatedButton.styleFrom(
  
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(color: Colors.red),
    ),
    backgroundColor: Colors.white
  ),
    onPressed: () {
      AwesomeDialog(
        context: context, 
        dialogType: DialogType.success,
        animType: AnimType.topSlide, 
        descTextStyle: generalfontStyle,
        titleTextStyle: titleFontStyle,
        title: "Request Sent",
        desc: "Your request has been sent successfully. Our team will contact you shortly",
      
        btnOkOnPress: (){}
      ).show(); 
    },
  child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "Become a Master Trainer",
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.25,
                                        color: Colors.red.shade800),
                                  ),
                                ),
),)
         ],
      ),
    ); 
  
  }
}
