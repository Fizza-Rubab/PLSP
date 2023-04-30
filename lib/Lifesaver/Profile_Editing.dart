import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps/Lifesaver/Lifesaver_Profile.dart';
import 'package:google_maps/Welcome/NewPassword.dart';
import '../input_design.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared.dart';
import '../constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';

import '../Welcome/NewPassword.dart'; 
class ProfileEditing extends StatefulWidget {
  const ProfileEditing({Key? key}) : super(key: key);

  @override
  State<ProfileEditing> createState() => _ProfileEditingState();
}

class _ProfileEditingState extends State<ProfileEditing> {
  File? pickedImage;
  String imageUrl = '';


  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _loadImageFromLocal();
  }

  void _loadImageFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');
    if (imagePath != null) {
      setState(() {
        pickedImage = File(imagePath);
      });
    }
  }

  Future<void> _uploadImage() async {
    final url = 'http://kaavish2023.pythonanywhere.com/lifesaver/upload_photo/2';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    print("path" + pickedImage!.path);
    request.files.add(await http.MultipartFile.fromPath('image', pickedImage!.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      print("response.statusCode");
      // Image uploaded successfully, update profile screen
    } else {
      print("error uploading image");
      // Error uploading image
    }
  }
  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.select_image_from,
                    style: titleFontStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: peachColor, // Background color
                    ),
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: Text(
                        AppLocalizations.of(context)!.camera,
                      style: whitegeneralfontStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: peachColor, // Background color
                    ),
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: Text(
                       AppLocalizations.of(context)!.gallery,
                      style: whitegeneralfontStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: peachColor, // Background color
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: Text(  AppLocalizations.of(context)!.cancel, style: whitegeneralfontStyle),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveImageToLocal(File image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', image.path);
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
      _uploadImage();
      if (pickedImage != null){
        _saveImageToLocal(pickedImage!);}
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  final expandedHeight = 220.0;
  final collapsedHeight = 60.0;
  bool isObscurePass = true;
  String DOB = '2001-02-12';
  final _formKey = GlobalKey<FormState>();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contact_no = TextEditingController();

  Future<void> _loadProfileData() async {
    DateTime DOB = DateTime(2000, 1);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fn = prefs.getString('first_name') ?? '';
    String ln = prefs.getString('last_name') ?? '';
    String add = prefs.getString('address') ?? '';
    String cont = prefs.getString('contact_no') ?? '';
    String dob = prefs.getString('date_of_birth') ?? '';
    setState(() {
      first_name.text = fn;
      last_name.text = ln;
      address.text = add;
      contact_no.text = cont;
      // DOB = dob;
    });
  }

  TextEditingController dateInput = TextEditingController();

  Future _updateProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id') ?? '';
    print(ApiConstants.baseUrl + ApiConstants.lifesaverEndpoint + '/' + id);
    final http.Response result = await http.put(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.lifesaverEndpoint + '/' + id),
        body: {
          "first_name": first_name.text,
          "last_name": last_name.text,
          "date_of_birth": DOB,
          "address": address.text,
          "contact_no": contact_no.text
        });
    if (result.statusCode == 200) {
      Map<String, dynamic> res_body = json.decode(result.body);
      putString('first_name', res_body['first_name']);
      putString('last_name', res_body['last_name']);
      putString('date_of_birth', res_body['date_of_birth']);
      putString('address', res_body['address']);
      putString('contact_no', res_body['contact_no']);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LifesaverProfile()));
    } else {
      throw Exception('Failed to update.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(expandedHeight),
        child: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.profile,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
                color: Colors.black45,
              )),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            // title: Text(AppLocalizations.of(context)!.profile,
            //     style: GoogleFonts.poppins(
            //       fontSize: 24,
            //       fontWeight: FontWeight.w600,
            //       letterSpacing: 0,
            //       color: Colors.black45,
            //     )),
            background: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  color: Colors.transparent,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/welcome-bg.png"),
                          fit: BoxFit.cover,
                          // colorFilter: ColorFilter.mode(Colors.white12, BlendMode.overlay)
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(),
                        ),
                        child: ClipOval(
                          child:pickedImage!=null? Image.file(
                                  pickedImage!,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ): Image.asset("assets/images/profileicon.png",width: 120, height: 120,),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // border: Border.all(width: 3, color: Colors.white),
                              color: peachColor),
                          child: IconButton(
                            onPressed: imagePickerOption,
                            icon: Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: first_name,
                decoration:
                    buildInputDecoration(Icons.person_outline,   AppLocalizations.of(context)!.first_name),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: last_name,
                decoration:
                    buildInputDecoration(Icons.person_outline,   AppLocalizations.of(context)!.last_name),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: address,
                decoration: buildInputDecoration(Icons.location_on,   AppLocalizations.of(context)!.address),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: contact_no,
                decoration: buildInputDecoration(Icons.call,   AppLocalizations.of(context)!.contact),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
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
                    borderSide: BorderSide(
                        width: 1, color: Colors.white), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  labelText:   AppLocalizations.of(context)!.date_of_birth,
                  prefixIcon: Icon(Icons.calendar_today),
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
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                      // icon: Icon(Icons.chevron_right),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  NewPassword()));
                      },
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.all(2),
                          child: Icon(
                            Icons.edit_outlined,
                            color: PrimaryColor,
                          ),
                        ),
                        Text(
                           AppLocalizations.of(context)!.change_password,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                              color: PrimaryColor),
                        ),
                      ])),
                ],
              ),
               const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Color.fromARGB(250, 245, 171, 61),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width / 2.4, 30),
                        textStyle: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _updateProfileData();
                        }
                      },
                      child: Text(
                          AppLocalizations.of(context)!.save,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                            color: Colors.grey.shade100),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: peachColor,
                        fixedSize:
                            Size(MediaQuery.of(context).size.width / 2.4, 30),
                        textStyle: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                          AppLocalizations.of(context)!.cancel,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                            color: Colors.grey.shade100),
                      ),
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
        controller: TextEditingController(text: placeholder),
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
          fillColor: Colors.grey.shade100,
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
