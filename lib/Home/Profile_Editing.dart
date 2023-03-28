import 'package:flutter/material.dart';
import '../input_design.dart';
import 'Citizen.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditing extends StatefulWidget {
  const ProfileEditing({Key? key}) : super(key: key);

  @override
  State<ProfileEditing> createState() => _ProfileEditingState();
}

class _ProfileEditingState extends State<ProfileEditing> {
  final expandedHeight = 220.0;

  final collapsedHeight = 60.0;
  bool isObscurePass = true;


  late SharedPreferences _prefs;
  DateTime DOB = DateTime.parse("2021-01-01");
  String first_name = '';
  String last_name = '';
  String address = '';
  String contact_no = '';
  String email = '';
  String password = '';


    @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        first_name = _prefs.getString('first_name') ?? '';
        last_name = _prefs.getString('last_name') ?? '';
        address = _prefs.getString('address') ?? '';
        DOB = DateTime.parse(_prefs.getString('date_of_birth') ?? '');
        contact_no = _prefs.getString('contact_no') ?? '';
        email = _prefs.getString('email') ?? '';
        password = _prefs.getString('password') ?? '';
      });
    });
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(expandedHeight),
        child: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.profile,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
                color: Colors.black45,
              )),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            // title: Text(AppLocalizations.of(context)!.profile,
            //     style: GoogleFonts.poppins(
            //       fontSize: 24,
            //       fontWeight: FontWeight.w600,
            //       letterSpacing: 0,
            //       color: Colors.black45,
            //     )),
            background: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  color: Colors.transparent,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/welcome-bg.png"),
                          fit: BoxFit.cover,
                          // colorFilter: ColorFilter.mode(Colors.white12, BlendMode.overlay)
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(),
                    ),
                    child: const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/profileicon.png"),
                      radius: 60,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 4, color: Colors.white),
                      color: Colors.redAccent),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              TextField(
                controller: TextEditingController(text: first_name),
                decoration:
                    buildInputDecoration(Icons.person_outline, "First Name"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: TextEditingController(text: last_name),
                decoration:
                    buildInputDecoration(Icons.person_outline, "Last Name"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: TextEditingController(
                    text: address),
                decoration: buildInputDecoration(Icons.location_on, "Address"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: TextEditingController(text: contact_no),
                decoration: buildInputDecoration(Icons.call, "Contact"),
              ),
              const SizedBox(
                height: 10,
              ),
              buildTextField("Password", password, true),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Color.fromARGB(250, 245, 171, 61),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width / 2.4, 30),
                        textStyle: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: Colors.white),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Save',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                            color: Colors.grey.shade100),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Color.fromARGB(255, 253, 129, 107),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width / 2.4, 30),
                        textStyle: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Citizen()));
                      },
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                            color: Colors.grey.shade100),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: TextEditingController(text: placeholder),
        obscureText: isPasswordTextField ? isObscurePass : false,
        decoration: InputDecoration(
          labelText: "Password",
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscurePass = !isObscurePass;
                    });
                  },
                  icon: const Icon(Icons.remove_red_eye),
                  color: Colors.grey,
                )
              : null,
          prefixIcon: const Icon(Icons.key),
          filled: true,
          fillColor: Colors.grey.shade100,
          focusColor: Colors.red.shade50,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(style: BorderStyle.none, width: 0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(style: BorderStyle.none, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(style: BorderStyle.none, width: 0),
          ),
        ),
        // decoration: InputDecoration(
        //   suffixIcon: isPasswordTextField
        //       ? IconButton(
        //           onPressed: () {
        //             setState(() {
        //               isObscurePass = !isObscurePass;
        //             });
        //           },
        //           icon: Icon(Icons.remove_red_eye),
        //           color: Colors.grey,
        //         )
        //       : null,
        //   contentPadding: EdgeInsets.only(bottom: 5),
        //   labelText: labelText,
        //   floatingLabelBehavior: FloatingLabelBehavior.always,
        //   hintText: placeholder,
        //   hintStyle: TextStyle(
        //     fontSize: 16,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.grey,
        //   ),
        // ),
      ),
    );
  }
}
