import 'package:flutter/material.dart';
import '../input_design.dart';
import 'Citizen.dart';

class ProfileEditing extends StatefulWidget {
  const ProfileEditing({Key? key}) : super(key: key);

  @override
  State<ProfileEditing> createState() => _ProfileEditingState();
}

class _ProfileEditingState extends State<ProfileEditing> {
  bool isObscurePass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          "Editing Profile",
          style: TextStyle(fontFamily: "Poppins", color: Colors.redAccent),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.redAccent,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.redAccent),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.redAccent.withOpacity(0.1),
                          ),
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            color: Colors.redAccent),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: TextEditingController(text: "Fizza"),
                decoration:
                    buildInputDecoration(Icons.person_outline, "First Name"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: TextEditingController(text: "Rubab"),
                decoration:
                    buildInputDecoration(Icons.person_outline, "Last Name"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: TextEditingController(
                    text: "Blue Moon Apartment, Garden East, Karachi"),
                decoration: buildInputDecoration(Icons.location_on, "Address"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: TextEditingController(text: "03332428145"),
                decoration: buildInputDecoration(Icons.call, "Contact"),
              ),
              const SizedBox(
                height: 10,
              ),
              buildTextField("Password", "*****", true),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height:48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ), backgroundColor: Colors.grey,
                        fixedSize:
                            Size(MediaQuery.of(context).size.width / 2.4, 30),
                        textStyle: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: Colors.white),
                      ),
                      onPressed: () {},
                      child: const Text('Save'),
                    ),
                  ),
                  SizedBox(height:48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ), backgroundColor: Colors.redAccent,
                        fixedSize:
                            Size(MediaQuery.of(context).size.width / 2.4, 30),
                        textStyle: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Citizen()));
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: TextEditingController(text: "abc"),
        obscureText: isPasswordTextField ? isObscurePass : false,
        decoration: InputDecoration(
          labelText: "Password",
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscurePass = !isObscurePass;
                    });
                  },
                  icon: const Icon(Icons.remove_red_eye),
                  color: Colors.grey,
                )
              : null,
          prefixIcon: const Icon(Icons.key),
          filled: true,
          fillColor: Colors.grey.shade200,
          focusColor: Colors.red.shade50,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(style: BorderStyle.none, width: 0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(style: BorderStyle.none, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(style: BorderStyle.none, width: 0),
          ),
        ),
        // decoration: InputDecoration(
        //   suffixIcon: isPasswordTextField
        //       ? IconButton(
        //           onPressed: () {
        //             setState(() {
        //               isObscurePass = !isObscurePass;
        //             });
        //           },
        //           icon: Icon(Icons.remove_red_eye),
        //           color: Colors.grey,
        //         )
        //       : null,
        //   contentPadding: EdgeInsets.only(bottom: 5),
        //   labelText: labelText,
        //   floatingLabelBehavior: FloatingLabelBehavior.always,
        //   hintText: placeholder,
        //   hintStyle: TextStyle(
        //     fontSize: 16,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.grey,
        //   ),
        // ),
      ),
    );
  }
}
