// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/gestures.dart';
import 'register.dart';
import "homepage.dart";
import 'constants.dart';
import 'shared.dart';
import 'package:multi_language_json/multi_language_json.dart';

var linkText = const TextStyle(
  color: Color.fromRGBO(255, 0, 95, 1),
  fontFamily: 'Poppins',
  fontSize: 10,
  letterSpacing: 0,
  fontWeight: FontWeight.normal,
  height: 0,
);
var disclaimerText = const TextStyle(
  color: Colors.black45,
  fontFamily: 'Poppins',
  fontSize: 10,
  letterSpacing: 0,
  fontWeight: FontWeight.normal,
  height: 0,
);
const not_pressed = TextStyle(
  color: Colors.black45,
  fontFamily: 'Poppins',
  fontSize: 18,
  letterSpacing: 0,
  fontWeight: FontWeight.normal,
);

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool value = true;
  bool valid = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool is_lifesaver = false;
  Map <String, dynamic> args = {};

  final language = MultiLanguageBloc(
      initialLanguage: 'ur_PK',
      defaultLanguage: 'ur_PK',
      commonRoute: 'common',
      supportedLanguages: ['en_US', 'pt_BR', 'ur_PK', 'sd_PK']);

  Future userLogin() async {
    String email = emailController.text;
    String pass = passwordController.text;
    final http.Response result = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint),
        body: {'email': email, 'password': pass});
    print(result);
    Map<String, dynamic> body = json.decode(result.body);
    print(body);
    if (body.containsKey('access')) {
      setState(() {
        putString('token', body['access']);
        valid = true;
        args = body;
      });
      if (body['is_lifesaver']) {
        putString('is_lifesaver', body['is_lifesaver']);
        setState(() {
          is_lifesaver = true;
        });
      } else{
        setState(() {
          is_lifesaver = false;
        });
      }
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(args:args)));
    } else if (body.containsKey('detail')) {
      setState(() {
        valid = false;
      });
    } else {
      setState(() {
        valid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromRGBO(255, 241, 236, 1),
      body: SingleChildScrollView(
    child: Column(
      children: [
    Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Image(
              image: AssetImage('assets/images/Image2.png'),
            ),
          ),
          // Log In and Register Buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0, 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 241, 236, 1),
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(255, 0, 95, 1),
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Register()));
                  },
                  child: const Text(
                    'Register',
                    style: not_pressed,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(255, 241, 236, 1),
                    padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),

          // Email ID and password
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.email_outlined,
                color: Colors.black45,
              ),
              const SizedBox(width: 15), // Just for spacing
              Expanded(
                child: TextFormField(
                  // obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: text_field,
                  ),
                  controller: emailController,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.lock_outline,
                color: Colors.black45,
              ),
              const SizedBox(width: 15), // Just for spacing
              Expanded(
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: text_field,
                  ),
                  controller: passwordController,
                ),
              )
            ],
          ),
          CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Remember me', style: not_pressed),
              activeColor: const Color.fromRGBO(255, 0, 95, 1),
              value: value,
              onChanged: (value) => this.value = value!),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
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
              userLogin();
            },
            child:  const Text(
              'Sign In',
              style: TextStyle(
                color: Color.fromRGBO(255, 241, 236, 1),
                fontFamily: 'Poppins',
                fontSize: 15,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(255, 0, 95, 1),
              padding: const EdgeInsets.fromLTRB(110, 2, 110, 2),
            ),
          ),
          // Image
        ],
      ),
    ),
    SizedBox(
      height: 130,
      width: 500,
      child: CustomPaint(painter: MyShape(), child: Container()),
    ),
      ],
    ),
      ),
    );
  }
}

class MyShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    final path = Path();
    final path_2 = Path();

    path.quadraticBezierTo(
      size.width * 0,
      size.height * 0.5,
      size.width * 0,
      size.height * 0.5,
    );
    path_2.quadraticBezierTo(
      size.width * 0,
      size.height * 0.5 * 0.5,
      size.width * 0,
      size.height * 0.5 * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.45,
      size.height * 0.95,
      size.width * 0.5,
      size.height * 0.85,
    );
    path_2.quadraticBezierTo(
      size.width * 0.45,
      size.height * 0.95,
      size.width * 0.5,
      size.height * 0.85,
    );
    path.quadraticBezierTo(
      size.width * 0.65,
      size.height * 0.65,
      size.width * 0.65,
      size.height * 0.65,
    );
    path_2.quadraticBezierTo(
      size.width * 0.65,
      size.height * 0.65,
      size.width * 0.65,
      size.height * 0.65,
    );
    path.quadraticBezierTo(
      size.width * 1,
      size.height * 0,
      size.width * 1,
      size.height * 0,
    );
    path_2.quadraticBezierTo(
      size.width * 0.99,
      size.height * 0,
      size.width * 0.99,
      size.height * 0,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.8);
    path_2.lineTo(size.width, size.height);
    path_2.lineTo(0, size.height);
    path_2.lineTo(0, size.height * 0.8);

    final paint2 = Paint();
    paint2.style = PaintingStyle.fill;
    paint2.color = Colors.orange;
    canvas.drawPath(path_2, paint2);
    final paint1 = Paint();
    paint1.style = PaintingStyle.fill;
    paint1.color = const Color.fromRGBO(255, 0, 95, 0.7);
    canvas.drawPath(path, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
