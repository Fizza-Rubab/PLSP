import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({Key? key}) : super(key: key);

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange),
              image: DecorationImage(
                image: AssetImage('assets/images/profileicon.png'),
              ),
            ),
          ),
          Text(
            "Sameer Pervez",
            style: TextStyle(
              color: Color.fromRGBO(255, 241, 236, 1),
              fontSize: 20,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            "Life Saver",
            style: TextStyle(
                color: Colors.grey[200], fontSize: 14, fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }
}
