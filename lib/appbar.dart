import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:google_maps/Welcome/Login.dart';
import 'package:google_maps/Welcome/Welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';


 class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {

  const SimpleAppBar(this.title_text, {super.key});
  

  final String title_text; 

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override 
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.redAccent,),
          onPressed: () {
            Navigator.pop(context);  
          },
        ),
        // iconTheme: IconThemeData(color: appbar_icon_color),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          title_text,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
            color: Colors.redAccent,
          ),
        ),
        centerTitle: true,
      );   }

}





class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  const MyAppBar({super.key, 
    ImageProvider<Object>? imageProvider,
    this.name = 'John',
    this.name1 = 'Doe',
  }) : imageProvider = imageProvider ?? const AssetImage('assets/images/profileicon.png');

  final String name; 
  final String name1; 
  final ImageProvider<Object> imageProvider;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void logout(BuildContext context) async {
    print("attempting to logout");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('${ApiConstants.baseUrl}${ApiConstants.lifesaverEndpoint}/${prefs.getString('id')}');
    final http.Response ls_result = await http.put(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.lifesaverEndpoint}/${await SharedPreferences.getInstance().then((prefs) => prefs.getString('id') ?? '')}'),body:{"registration_token":"-"});
    Map<String, dynamic> ls_body = json.decode(ls_result.body);
    print(ls_body);
    await prefs.clear();
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Login()),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  });
  }


  @override 
  Widget build(BuildContext context) {
    return AppBar(
        titleSpacing: 14,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: RichText(
            text: TextSpan(
                text: name, 
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0, color: Colors.black38, height: 1.1),
                children: [
              TextSpan(
                  text: name1, 
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                    color: Colors.black45,
                  ))
            ])),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: GestureDetector(
              onTap: () {
               
              },
              child: CircleAvatar(
                radius: 22,
                foregroundImage: imageProvider,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(Icons.logout, color: Colors.redAccent,),
          ),
        ],
        );
  }

}

// class MyAppBar extends StatelessWidget with PreferredSize {
//   final String name; 
//   final String name1; 

//    MyAppBar({
//     Key? key, required this.name, required this.name1,
//   }) : super(key: key);
//   @override
//   Size get PreferredSize => Size.fromHeight(kToolbarHeight); 

//   @override

//   Widget build(BuildContext context) {
//     return 
//   }
// }