// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import '../Home/Citizen.dart';
import '../input_design.dart';
import '../constants.dart';
import '../shared.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool rememberFlag = false;
  bool is_lifesaver = false;
  DateTime DOB = DateTime(2000, 1);
  //TextController to read text entered in text field
  TextEditingController email = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController contact_no = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: DOB, firstDate: DateTime(1950, 8), lastDate: DateTime(2101));
    if (picked != null && picked != DOB) {
      setState(() {
        DOB = picked;
      });
    }
  }

  Future userRegister() async {
    final http.Response result =
        await http.post(Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint), body: {'email': email.text, 'password': password.text});
    Map<String, dynamic> body = json.decode(result.body);
    print(body);
    if (body.containsKey('access')) {
      putString('token', body['access']);
      if (body['is_lifesaver']) {
        putBool('is_lifesaver', body['is_lifesaver']);
        setState(() {
          is_lifesaver = true;
        });
        final http.Response ls_result = await http.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.lifesaverEndpoint}/${body['id']}'));
        Map<String, dynamic> ls_body = json.decode(ls_result.body);
        putString('id', ls_body['id'].toString());
        putString('first_name', ls_body['first_name']);
        putString('last_name', ls_body['last_name']);
        putString('date_of_birth', ls_body['date_of_birth']);
        putString('address', ls_body['address']);
        putString('contact_no', ls_body['contact_no']);
        putString('cnic', ls_body['cnic']);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Citizen()));
      } else {
        putBool('is_lifesaver', body['is_lifesaver']);
        setState(() {
          is_lifesaver = false;
        });
        final http.Response ct_result = await http.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.citizenEndpoint}/${body['id']}'));
        Map<String, dynamic> ct_body = json.decode(ct_result.body);
        putString('id', ct_body['id'].toString());
        putString('email', email.text);
        putString('password', password.text);
        putString('first_name', ct_body['first_name']);
        putString('last_name', ct_body['last_name']);
        putString('date_of_birth', ct_body['date_of_birth']);
        putString('address', ct_body['address']);
        putString('contact_no', ct_body['contact_no']);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Citizen()));
      }
      // ignore: use_build_context_synchronously

    } else {
      email.clear();
      password.clear();
    }

    // else if (body.containsKey('detail')) {
    //   setState(() {
    //     valid = false;
    //   });
    // } else {
    //   setState(() {
    //     valid = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14, 86, 14, 14),
            // child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.register,
                  style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -0.5, color: Colors.black54),
                ),
                Text(
                  AppLocalizations.of(context)!.register_desc,
                  style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: Colors.black45),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Form(
                  key: _formkey,
                  // child: Expanded(l
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: TextFormField(
                            controller: email,
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(Icons.email_rounded, AppLocalizations.of(context)!.email),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please a Enter';
                              }
                              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                                return 'Please a valid Email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: TextFormField(
                            style: Theme.of(context).textTheme.caption,
                            obscureText: true,
                            controller: password,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(Icons.key_rounded, AppLocalizations.of(context)!.password),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please a Enter Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: TextFormField(
                            style: Theme.of(context).textTheme.caption,
                            obscureText: true,
                            controller: password,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(Icons.key_rounded, AppLocalizations.of(context)!.confirm_password),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please re-enter Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: TextFormField(
                            controller: email,
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(Icons.email_rounded, AppLocalizations.of(context)!.first_name),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: TextFormField(
                            controller: email,
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(Icons.email_rounded, AppLocalizations.of(context)!.last_name),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: TextFormField(
                            controller: email,
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(Icons.email_rounded, AppLocalizations.of(context)!.address),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: TextFormField(
                            controller: email,
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(Icons.email_rounded, AppLocalizations.of(context)!.contact_no),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: ElevatedButton(
                            onPressed: () => _selectDate(context),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300),
                            child: Text(
                              'Select date',
                              style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: 0.2, color: Colors.black45),
                            ),
                          ),
                        ),
                        // const Spacer(),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                                // icon: Icon(Icons.chevron_right),
                                onPressed: () {},
                                child: Row(children: [
                                  Text(
                                    AppLocalizations.of(context)!.register,
                                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1.0, color: PrimaryColor),
                                  ),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    color: PrimaryColor,
                                  )
                                ])),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
