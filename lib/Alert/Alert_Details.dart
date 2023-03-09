import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../input_design.dart';

class Alert_Details extends StatefulWidget {
  const Alert_Details({Key? key}) : super(key: key);

  @override
  State<Alert_Details> createState() => _Alert_DetailsState();
}

class _Alert_DetailsState extends State<Alert_Details> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          shadowColor: Colors.red,
          title: Text("Emergency Details",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
                color: Colors.white,
              )),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            children: [
              TextField(
                decoration: buildInputDecoration(Icons.location_on, "Location"),
              ),
              const Spacer(
                flex: 1,
              ),
              Container(
                height: MediaQuery.of(context).size.height * (1 / 4),
                color: Colors.blue,
              ),
              const Divider(
                color: Colors.redAccent,
              ),
              TextField(
                decoration: buildInputDecoration(Icons.numbers, "No. of Patients"),
              ),
              const Spacer(
                flex: 1,
              ),
              TextField(
                decoration: buildInputDecoration(Icons.menu, "Other Details (if any)"),
              ),
              const Divider(
                color: Colors.redAccent,
              ),
              const Text(
                "Callers' Information:",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const Spacer(
                flex: 1,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.15,
                    child: TextField(
                      controller: TextEditingController(text: "Default Name"),
                      decoration: buildInputDecoration(Icons.person_outline, "Name"),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.15,
                    child: TextField(
                      controller: TextEditingController(text: "Default Contact"),
                      decoration: buildInputDecoration(Icons.call, "Contact No."),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  fixedSize: Size(MediaQuery.of(context).size.width, 30),
                  textStyle: const TextStyle(fontSize: 18, fontFamily: 'Poppins', color: Colors.white),
                ),
                onPressed: () {},
                child: const Text('Launch Alert'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
