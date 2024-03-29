// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps/Lifesaver/termsAndPolicy.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:mailer/smtp_server.dart';
import '../Home/Citizen.dart';
import '../input_design.dart';
import '../constants.dart';
import '../shared.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'OTP.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool rememberFlag = false;
  double space_between_val = 10;
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
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DOB,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != DOB) {
      setState(() {
        DOB = picked;
      });
    }
  }

  TextEditingController dateInput = TextEditingController();
  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.redAccent),
            elevation: 0,
          ),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: defaultPadding, right: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    AppLocalizations.of(context)!.register,
                    style: boldheader,
                  ),
                  Text(
                    AppLocalizations.of(context)!.register_desc,
                    style: header_disc,
                  ),
                  SizedBox(
                      height:
                          space_between_val), // MediaQuery.of(context).size.height * 0.03),
                  Form(
                    key: _formkey,
                    // child: Expanded(l
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email,
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: buildInputDecoration(Icons.email_rounded,
                              AppLocalizations.of(context)!.email),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please a Enter';
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return 'Please a valid Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: space_between_val,
                        ),
                        TextFormField(
                          style: Theme.of(context).textTheme.caption,
                          obscureText: true,
                          controller: password,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(Icons.key_rounded,
                              AppLocalizations.of(context)!.password),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please a Enter Password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: space_between_val,
                        ),
                        TextFormField(
                          style: Theme.of(context).textTheme.caption,
                          obscureText: true,
                          controller: confirmpassword,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(Icons.key_rounded,
                              AppLocalizations.of(context)!.confirm_password),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please re-enter Password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: space_between_val,
                        ),
                        TextFormField(
                          controller: first_name,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(Icons.person,
                              AppLocalizations.of(context)!.first_name),
                        ),
                        SizedBox(
                          height: space_between_val,
                        ),
                        TextFormField(
                          controller: last_name,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(Icons.person,
                              AppLocalizations.of(context)!.last_name),
                        ),
                        SizedBox(
                          height: space_between_val,
                        ),
                        TextFormField(
                          controller: address,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(Icons.location_city,
                              AppLocalizations.of(context)!.address),
                        ),
                        SizedBox(
                          height: space_between_val,
                        ),
                        TextFormField(
                          controller: contact_no,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          decoration: buildInputDecoration(Icons.call,
                              AppLocalizations.of(context)!.contact),
                        ),
                        SizedBox(
                          height: space_between_val,
                        ),
                        TextField(
                          controller: dateInput,
                          //editing controller of this TextField
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.date_of_birth,
                            prefixIcon: const Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              setState(() {
                                dateInput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                        ),
                        SizedBox(
                          height: space_between_val,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      AppLocalizations.of(context)!.disclaimer,
                                  style: generalfontStyle),
                              TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .disclaimer_url,
                                  style: urlfontStyle,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TermsAndConditions()));
                                    }),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                                onPressed: () async {
                                  String generatedOTP = generateOTP();
      
                                  final smtpServer =
                                      gmail(username, apppassword);
                                  sendOtpEmail(email.text, first_name.text,
                                      generatedOTP, smtpServer);
                               
                                  print(generatedOTP);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Otp(
                                          last_name: last_name.text, 
                                          address: address.text, 
                                          contact_no: contact_no.text,
                                          DOB: dateInput.text,  
                                            email: email.text,
                                            name: first_name.text,
                                            generatedOTP: generatedOTP,
                                            username: username,
                                            password: password.text,
                                            smtpServer: smtpServer)),
                                  );
                                },
                                child: Row(children: [
                                  Text(
                                    AppLocalizations.of(context)!.register,
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
                ],
              ),
            ),
          )),
    );
  }
}
