import 'package:flutter/material.dart';
import 'package:google_maps/Home/Citizen_History.dart';
import 'package:google_maps/Home/Citizen_Home.dart';
import 'package:google_maps/Home/Citizen_Profile.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class Citizen extends StatefulWidget {
  const Citizen({super.key});

  @override
  State<Citizen> createState() => _CitizenState();
}

class _CitizenState extends State<Citizen> {
  List<Widget> bodyList = [
    const CitizenHome(),
    const CitizenHistory(),
    CitizenProfile(),
  ];
  PageController _pageController = PageController();
  int index = 0; // To change to 0 

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: bodyList,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: index,
        onDestinationSelected: (index) {
          _pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.ease);
          setState(() {
            this.index = index;
          });
        },
        //
        destinations: [
          NavigationDestination(
              selectedIcon: Icon(
                Icons.home_outlined,
                size: 28,
                color: Colors.red.shade900,
              ),
              icon: const Icon(Icons.home_outlined),
              label: localizations.home_icon),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.history_rounded,
                size: 28,
                color: Colors.red.shade900,
              ),
              icon: const Icon(Icons.history_rounded),
              label: localizations.history),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.person_outline_rounded,
                size: 28,
                color: Colors.red.shade900,
              ),
              icon: const Icon(Icons.person_outline_rounded),
              label: localizations.profile),
        ],
      ),
    );
  }
}
