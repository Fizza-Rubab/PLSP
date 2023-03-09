import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/gestures.dart';
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

const text_field_1 = TextStyle(
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

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 241, 236, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(240),
        child: AppBar(
          backgroundColor: Color.fromRGBO(255, 241, 236, 1),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.red,
            ),
            onPressed: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogIn()))},
          ),
          elevation: 0,
          flexibleSpace: Padding(
            padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 70,
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: AssetImage('assets/images/profileicon.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    "Sameer Pervez",
                    style: Profile_Name,
                  ),
                ),
                // Divider(
                //   indent: 60,
                //   endIndent: 60,
                //   color: Colors.black45,
                // ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "Citizen",
                    style: role_style,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.email_outlined,
                    color: Colors.black45,
                  ),
                  SizedBox(width: 10), // Just for spacing
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: text_field_1,
                      ),
                    ),
                  ),
                ],
              ),

              //Full Name
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle, color: Colors.black45),
                  SizedBox(width: 10), // Just for spacing
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: text_field_1,
                      ),
                    ),
                  )
                ],
              ),

              //Phone Number
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.phone, color: Colors.black45),
                  SizedBox(width: 10), // Just for spacing
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: text_field_1,
                      ),
                    ),
                  )
                ],
              ),

              // CNIC
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.card_membership, color: Colors.black45),
                  SizedBox(width: 10), // Just for spacing
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'CNIC',
                        labelStyle: text_field_1,
                      ),
                    ),
                  )
                ],
              ),

              // Address
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_city, color: Colors.black45),
                  SizedBox(width: 10), // Just for spacing
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: text_field_1,
                      ),
                    ),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 2)),
              // Password
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Icon(Icons.lock_outline, color: Colors.black45),
              //     SizedBox(width: 10), // Just for spacing
              //     Expanded(
              //       child: TextField(
              //         obscureText: true,
              //         decoration: InputDecoration(
              //           labelText: 'Password',
              //           labelStyle: text_field_1,
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              //
              // // Confirm
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Icon(Icons.lock_outline, color: Colors.black45),
              //     SizedBox(width: 10), // Just for spacing
              //     Expanded(
              //       child: TextField(
              //         obscureText: true,
              //         decoration: InputDecoration(
              //           labelText: 'Confirm Password',
              //           labelStyle: text_field_1,
              //         ),
              //       ),
              //     )
              //   ],
              // ),

              ElevatedButton(
                onPressed: () => {print('hey')},
                child: const Text(
                  'Update Profile',
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
                  padding: EdgeInsets.fromLTRB(110, 2, 110, 2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
