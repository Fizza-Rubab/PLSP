import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/Home/Citizen_Home.dart';
import '../Home/Citizen.dart';
import '../input_design.dart';
import '../constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String name, email, phone;
  bool rememberFlag = false;
  //TextController to read text entered in text field
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();

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
              // child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome\nBack",
                    style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -0.5, color: Colors.black54),
                  ),
                  Text(
                    "Please enter your credentials to login",
                    style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: Colors.black45),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.125),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: TextFormField(
                      autofocus: true,
                      style: Theme.of(context).textTheme.caption,
                      keyboardType: TextInputType.text,
                      decoration: buildInputDecoration(Icons.email_rounded, "Email"),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please a Enter';
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                          return 'Please a valid Email';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        email = value!;
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
                      decoration: buildInputDecoration(Icons.key_rounded, "Password"),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please a Enter Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text("Remember Me?", style: Theme.of(context).textTheme.caption),
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Citizen()));
                          },
                          child: Row(children: [
                            Text(
                              'Login',
                              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1.0, color: PrimaryColor),
                            ),
                            const Icon(Icons.chevron_right_rounded, color: PrimaryColor,)
                          ])),
                    ],
                  )
                ],
              ),
            )));
  }
}
