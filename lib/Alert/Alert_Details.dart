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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black54,
        title: Text("Emergency Details",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
              color: Colors.black45,
            )),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: buildInputDecoration(Icons.location_on, "Location of Emergency",
                  border: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
            ),
            Container(
              height: MediaQuery.of(context).size.height * (1 / 3.5),
              decoration: const BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
            ),
            const Spacer(flex: 2),
            Text("Patient's Information:",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colors.black45,
                )),
            const Spacer(flex: 2,),
            TextField(
              decoration: buildInputDecoration(Icons.groups, "How Many Patients?", border: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),),
            
            const SizedBox(height: 4,),
            TextField(
              maxLines: 3,
              textAlignVertical: TextAlignVertical.top,
              decoration: buildInputDecoration(Icons.info, "Other Important Details (optional)", border: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
            ),
            const Spacer(flex: 2),
            Text("Caller's Information:",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colors.black45,
                )),
            const Spacer(flex: 2,),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: TextField(
                    controller: TextEditingController(text: "Sameer Pervez"),
                    decoration: buildInputDecoration(Icons.person, "Name", border: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  )),
                  ),
                ),
                SizedBox(width: 4,),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: TextField(
                    controller: TextEditingController(text: "03352395720"),
                    decoration: buildInputDecoration(Icons.call, "Contact Number",border: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 4),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  fixedSize: Size(MediaQuery.of(context).size.width, 30),
                  textStyle: Theme.of(context).textTheme.bodyText2,
                ),
                onPressed: () {},
                child: const Text('Launch Alert'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
