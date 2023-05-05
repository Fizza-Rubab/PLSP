// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps/Welcome/ForgotPassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Lifesaver/Lifesaver.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import '../Home/Citizen.dart';
import '../input_design.dart';
import '../constants.dart';
import '../shared.dart';
import 'ForgotPassword.dart';
import '../appbar.dart';
import '../Welcome/Welcome.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}



class _LoginState extends State<Login> {
  bool rememberFlag = true;
  bool is_lifesaver = false;
  bool loginSuccess = true;
  bool _obscureText = true;
  //TextController to read text entered in text field
  
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();



  Future<File> _saveImageToFile(String url, String fileName) async {
  var response = await http.get(Uri.parse(url));
  var bytes = response.bodyBytes;
  var directory = await getApplicationDocumentsDirectory();
  var file = File('${directory.path}/$fileName');
  await file.writeAsBytes(bytes.buffer.asUint8List(0, bytes.length));
  return file;
  }

  Future userLogin() async {
    final http.Response result = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint),
        body: {'email': email.text, 'password': password.text});
    Map<String, dynamic> body = json.decode(result.body);
    print(body);
    if (body.containsKey('access')) {
      putBool('logged_in', true);
      putString('token', body['access']);
      if (body['is_lifesaver']) {
        putBool('is_lifesaver', body['is_lifesaver']);
        setState(() {
          is_lifesaver = true;
        });
        final http.Response ls_result = await http.get(Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.lifesaverEndpoint}/${body['id']}'));
        Map<String, dynamic> ls_body = json.decode(ls_result.body);
        putString('id', ls_body['id'].toString());
        putString('first_name', ls_body['first_name']);
        putString('last_name', ls_body['last_name']);
        putString('date_of_birth', ls_body['date_of_birth']);
        putString('address', ls_body['address']);
        putString('contact_no', ls_body['contact_no']);
        putBool('is_available', ls_body['is_available']);
        if (ls_body['profile_picture'] != null) {
            var fileName = Uri.parse(ls_body['profile_picture']).pathSegments.last;
            var file = await _saveImageToFile(ls_body['profile_picture'], fileName);
            var prefs = await SharedPreferences.getInstance();
            await prefs.setString('profile_image', file.path);
            print("setting prefs image");
        }
        String fcm_token = await NotificationController.getFirebaseMessagingToken();
        final http.Response token_result = await http.put(Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.lifesaverEndpoint}/${body['id']}'), body: {'registration_token':fcm_token});
        Map<String, dynamic> resbody = json.decode(token_result.body);
        print(resbody);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Lifesaver()));
      } else {
        putBool('is_lifesaver', body['is_lifesaver']);
        setState(() {
          is_lifesaver = false;
        });
        final http.Response ct_result = await http.get(Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.citizenEndpoint}/${body['id']}'));
        Map<String, dynamic> ct_body = json.decode(ct_result.body);
        putString('id', ct_body['id'].toString());
        putString('email', email.text);
        putString('password', password.text);
        putString('first_name', ct_body['first_name']);
        putString('last_name', ct_body['last_name']);
        putString('date_of_birth', ct_body['date_of_birth']);
        putString('address', ct_body['address']);
        putString('contact_no', ct_body['contact_no']);
        if (ct_body['profile_picture'] != null) {
            var fileName = Uri.parse(ApiConstants.baseUrl + ct_body['profile_picture']).pathSegments.last;
            var file = await _saveImageToFile(ApiConstants.baseUrl+ct_body['profile_picture'], fileName);
            var prefs = await SharedPreferences.getInstance();
            await prefs.setString('profile_image', file.path);
            print("setting prefs image");
        }
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Citizen()));
      }
      // ignore: use_build_context_synchronously

    } else {
      loginSuccess = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SimpleAppBar(""),
          body: Padding(
            padding:
                EdgeInsets.all(defaultPadding),
            child: Form(
              key: _formkey,
              // child: Expanded(l
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.welcome_back,
                    style: boldheader,
                  ),
                  Text(
                    AppLocalizations.of(context)!.login_desc,
                    style: header_disc,

                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.125),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: TextFormField(
                      controller: email,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      decoration: buildInputDecoration(Icons.email_rounded,
                          AppLocalizations.of(context)!.email),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return 'Email is invalid';
                        }
                        return null;
                      },
                    ),
                  ),
                  TextFormField(
                    obscureText: _obscureText,
                    controller: password,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Colors.white), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: AppLocalizations.of(context)!.password,
                      prefixIcon: Icon(Icons.key_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else if (!loginSuccess) {
                        return 'Email or password is incorrect';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(
                        right: defaultPadding,
                        left: defaultPadding,
                        bottom: 4.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            // handle tap event here
                           Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword())); 
                          },
                          child: Text(
                           AppLocalizations.of(context)!.forgot_password,
                            style: urlfontStyle,
                          ),
                        )),
                  ),

                 
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.platform,
                    title: Text(AppLocalizations.of(context)!.rememberme,
                        style: Theme.of(context).textTheme.caption),
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
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0,
                                  color: PrimaryColor),
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
          )),
    );
  }
}
