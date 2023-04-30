// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:google_fonts/google_fonts.dart';
import '../Lifesaver/Lifesaver.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import '../Home/Citizen.dart';
import '../input_design.dart';
import '../constants.dart';
import '../shared.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool rememberFlag = false;
  bool is_lifesaver = false;
  bool loginSuccess = true;
  //TextController to read text entered in text field
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future userLogin() async {
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
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Lifesaver()));
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
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Citizen()));
      }
      putBool('logged_in', true);
      // ignore: use_build_context_synchronously

    } else {
      loginSuccess = false;
      setState(() {
        
      });
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
            child: Form(
              key: _formkey,
              // child: Expanded(l
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.welcome_back,
                    style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -0.5, color: Colors.black54),
                  ),
                  Text(
                    AppLocalizations.of(context)!.login_desc,
                    style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: Colors.black45),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.125),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: TextFormField(
                      controller: email,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      decoration: buildInputDecoration(Icons.email_rounded, AppLocalizations.of(context)!.email),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                          return 'Email is invalid';
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
                          return 'Please enter your password';
                        }
                        else if(!loginSuccess) {
                          return 'Email or password is incorrect';
                        }
                        return null;
                      },
                    ),
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text(AppLocalizations.of(context)!.rememberme, style: Theme.of(context).textTheme.caption),
                    activeColor: PrimaryColor,
                    value: rememberFlag,
                    onChanged: ((value) {
                      setState(() {
                        rememberFlag = value!;
                      });
                    }),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          // icon: Icon(Icons.chevron_right),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              userLogin();
                            }
                          },
                          child: Row(children: [
                            Text(
                              AppLocalizations.of(context)!.login,
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
            )));
  }
}
