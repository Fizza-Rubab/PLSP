import 'package:flutter/material.dart';
import '../input_design.dart';
import 'Citizen.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared.dart';
import '../constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class ProfileEditing extends StatefulWidget {
  const ProfileEditing({Key? key}) : super(key: key);

  @override
  State<ProfileEditing> createState() => _ProfileEditingState();
}

class _ProfileEditingState extends State<ProfileEditing> {
  final expandedHeight = 220.0;
  final collapsedHeight = 60.0;
  bool isObscurePass = true;
  String DOB = '2001-02-12';
  final _formKey = GlobalKey<FormState>();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contact_no = TextEditingController();


  Future<void> _loadProfileData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String fn = prefs.getString('first_name') ?? '';
  String ln = prefs.getString('last_name') ?? '';
  String add = prefs.getString('address') ?? '';
  String cont = prefs.getString('contact_no') ?? '';
  String dob = prefs.getString('date_of_birth') ?? '';
  setState(() {
    first_name.text = fn;
    last_name.text = ln;
    address.text = add;
    contact_no.text = cont;
    DOB = dob;
  });
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }


  Future _updateProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id') ?? '';
    print(ApiConstants.baseUrl + ApiConstants.citizenEndpoint + '/' + id);
    final http.Response result = await http.put(
    Uri.parse(ApiConstants.baseUrl + ApiConstants.citizenEndpoint + '/' + id),
    body: {
          "first_name": first_name.text,
          "last_name": last_name.text,
          "date_of_birth": DOB,
          "address": address.text,
          "contact_no": contact_no.text
      }
    );
    if (result.statusCode == 200) {
      Map<String, dynamic> res_body = json.decode(result.body);
        putString('first_name', res_body['first_name']);
        putString('last_name', res_body['last_name']);
        putString('date_of_birth', res_body['date_of_birth']);
        putString('address', res_body['address']);
        putString('contact_no', res_body['contact_no']);
        Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Citizen()));
    }
    else {
      throw Exception('Failed to update.');
    }
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: first_name,
                decoration:
                    buildInputDecoration(Icons.person_outline, "First Name"),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: last_name,
                decoration:
                    buildInputDecoration(Icons.person_outline, "Last Name"),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: address,
                decoration: buildInputDecoration(Icons.location_on, "Address"),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: contact_no,
                decoration: buildInputDecoration(Icons.call, "Contact"),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              // buildTextField("Password", password, true),
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
                      onPressed: (){
                        if (_formKey.currentState!.validate()) {
                          _updateProfileData();
                        }
                      },
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
