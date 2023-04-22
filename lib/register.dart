import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/gestures.dart';
import 'constants.dart';
import 'profile.dart';

import 'old_login.dart';

const Profile_Name = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.black45,
  fontFamily: 'Poppins',
  fontSize: 20,
  letterSpacing: 0,
);

const role_style = TextStyle(
  fontStyle: FontStyle.italic,
  color: Colors.black45,
  fontFamily: 'Poppins',
  fontSize: 15,
  letterSpacing: 0,
);

const text_field = TextStyle(
  fontStyle: FontStyle.italic,
  color: Colors.black45,
  fontFamily: 'Poppins',
  fontSize: 18,
  letterSpacing: 0,
  fontWeight: FontWeight.normal,
);

const not_pressed = TextStyle(
  color: Colors.black45,
  fontFamily: 'Poppins',
  fontSize: 18,
  letterSpacing: 0,
  fontWeight: FontWeight.normal,
);
const radio_buttons = TextStyle(
  color: Colors.black45,
  fontFamily: 'Poppins',
  fontSize: 15,
  letterSpacing: 0,
  fontWeight: FontWeight.normal,
);
var linkText = TextStyle(
  color: Color.fromRGBO(255, 0, 95, 1),
  fontFamily: 'Poppins',
  fontSize: 10,
  letterSpacing: 0,
  fontWeight: FontWeight.normal,
  height: 0,
);
var disclaimerText = TextStyle(
  color: Colors.black45,
  fontFamily: 'Poppins',
  fontSize: 10,
  letterSpacing: 0,
  fontWeight: FontWeight.normal,
  height: 0,
);

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool value = true;
  int selectedRadio = 0;
  String email = '';
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String cnic = '';
  String address = '';
  String password = '';
  String password2 = '';
  bool created = false;

  setSelectedRadio(val) {
    setState(() {
      selectedRadio = val;
    });
  }
  Future<bool> register() async {
    final http.Response result;
    Map<String, dynamic> ls = {'email': email, 'password': password, 'citizen':{'first_name':firstName, 'last_name':lastName, 'date_of_birth':'2022-12-01', 'address':address, 'contact_no':phoneNumber, 'calls_made':0}
    };
    print(json.encode(ls));
    if (selectedRadio==2){
      print(ApiConstants.baseUrl + ApiConstants.citizenEndpoint + ApiConstants.signupEndpoint);
      result = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.citizenEndpoint + ApiConstants.signupEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(ls)
        );
    }
    else
      result = await http.post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.citizenEndpoint + ApiConstants.signupEndpoint),
          body: json.encode({'email': email, 'password': password, 'citizen':{'first_name':firstName, 'last_name':lastName, 'date_of_birth':'2022-12-01', 'address':address, 'latitude':1, 'longitude':0, 'cnic':cnic, 'training_id':0, 'contact_no':phoneNumber, 'calls_received':0, 'badge':'Lifesaver Hero'}}));
    Map<String, dynamic> body = json.decode(result.body);
    print(result.statusCode);
    print(body);
    if (result.statusCode==201 || result.statusCode=="201" )
      setState(() {
        created= true;
      });
    return created;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromRGBO(255, 241, 236, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Image(
                    image: AssetImage('assets/images/Image2.png'),
                    height: 80,
                    width: 150,
                  ),
                ),
                // Log In and Register Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LogIn()));
                      },
                      child: const Text(
                        'Log In',
                        style: not_pressed,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(255, 241, 236, 1),
                        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 241, 236, 1),
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(255, 0, 95, 1),
                        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      ),
                    ),
                  ],
                ),

                // Email Address
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: Colors.black45,
                    ),
                    SizedBox(width: 15), // Just for spacing
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: text_field,
                        ),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                //Full Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.account_circle, color: Colors.black45),
                    SizedBox(width: 15), // Just for spacing
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle: text_field,
                        ),
                        onChanged: (val) {
                          setState(() {
                            firstName = val;
                          });
                        },

                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.account_circle, color: Colors.black45),
                    SizedBox(width: 15), // Just for spacing
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: text_field,
                        ),
                        onChanged: (val) {
                          setState(() {
                            lastName = val;
                          });
                        },
                      ),
                    )
                  ],
                ),
                //Phone Number
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.phone, color: Colors.black45),
                    SizedBox(width: 15), // Just for spacing
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                        
                          labelText: 'Phone Number',
                          labelStyle: text_field,
                        ),
                        onChanged: (val) {
                          setState(() {
                            phoneNumber = val;
                          });
                        },
                      ),
                    )
                  ],
                ),

                // CNIC
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.card_membership, color: Colors.black45),
                    SizedBox(width: 15), // Just for spacing
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'CNIC',
                          labelStyle: text_field,
                        ),
                        onChanged: (val) {
                          setState(() {
                            cnic = val;
                          });
                        },
                      ),
                    )
                  ],
                ),

                // Address
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_city, color: Colors.black45),
                    SizedBox(width: 15), // Just for spacing
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: text_field,
                        ),
                        onChanged: (val) {
                          setState(() {
                            address = val;
                          });
                        },
                      ),
                    )
                  ],
                ),

                // Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.lock_outline, color: Colors.black45),
                    SizedBox(width: 15), // Just for spacing
                    Expanded(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: text_field,
                        ),
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                    )
                  ],
                ),

                // Confirm
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.lock_outline, color: Colors.black45),
                    SizedBox(width: 15), // Just for spacing
                    Expanded(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: text_field,
                        ),
                        onChanged: (val) {
                          setState(() {
                            password2 = val;
                          });
                        },
                      ),
                    )
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RadioListTile(
                        value: 1,
                        title: Text(
                          "Life Saver",
                          style: radio_buttons,
                        ),
                        groupValue: selectedRadio,
                        activeColor: Color.fromRGBO(255, 0, 95, 1),
                        onChanged: (val) {
                          print(val);
                          print("Radio Button value changed");
                          setSelectedRadio(val);
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        value: 2,
                        title: Text(
                          "Citizen",
                          style: radio_buttons,
                        ),
                        groupValue: selectedRadio,
                        activeColor: Color.fromRGBO(255, 0, 95, 1),
                        onChanged: (val) {
                          print(val);
                          print("Radio Button value changed");
                          setSelectedRadio(val);
                        },
                      ),
                    )
                  ],
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'By signing in to this application, you are agreeing to our',
                          style: disclaimerText,
                        ),
                        TextSpan(
                            style: linkText,
                            text: " Terms and privacy policy.",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                const url = "https://google.com.pk";
                                launchUrlString(url);
                              }),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    register();
                    print(created);
                    if (created)
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color:  Color.fromRGBO(255, 241, 236, 1),
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(255, 0, 95, 1),
                    padding: EdgeInsets.fromLTRB(100, 2, 100, 2),
                  ),
                ),
                // Image
              ],
            ),
            // SizedBox(
            //   height: 130,
            //   width: 500,
            //   child: CustomPaint(painter: MyShape(), child: Container()),
            // ),
          ],
        ),
      ),
    );
  }
}
