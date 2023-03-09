import 'package:flutter/material.dart';
import 'package:google_maps/Home/Citizen_History.dart';
import 'package:google_maps/Home/Citizen_Home.dart';
import 'package:google_maps/Home/Citizen_Profile.dart';

class Citizen extends StatefulWidget {
  const Citizen({super.key});

  @override
  State<Citizen> createState() => _CitizenState();
}

class _CitizenState extends State<Citizen> {
  List<Widget> bodyList =  [
    CitizenHome(),
    CitizenHistory(),
    CitizenProfile(),
    ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyList[index],
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: index,
        onDestinationSelected: (index) {
          setState(() {
            this.index = index;
          });
        },
        //
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home_outlined, size:28, color: Colors.red.shade900,), 
            icon: const Icon(Icons.home_outlined), 
            label: "Home"),
          NavigationDestination(
            selectedIcon: Icon(Icons.history_rounded, size:28, color: Colors.red.shade900,), 
            icon: const Icon(Icons.history_rounded), 
            label: "History"),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_outline_rounded, size:28, color: Colors.red.shade900,), 
            icon: const Icon(Icons.person_outline_rounded), 
            label: "Profile"),
        ],
      ),
    );
  }
}
