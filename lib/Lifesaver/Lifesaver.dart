import 'package:flutter/material.dart';
import 'Lifesaver_History.dart';
import 'Lifesaver_Home.dart';
import 'Lifesaver_Profile.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class Lifesaver extends StatefulWidget {
  const Lifesaver({super.key});

  @override
  State<Lifesaver> createState() => _LifesaverState();
}

class _LifesaverState extends State<Lifesaver> {
  List<Widget> bodyList = [
    const LifesaverHome(),
    const LifesaverHistory(),
    LifesaverProfile(),
  ];
  PageController _pageController = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: bodyList,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
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
              label: AppLocalizations.of(context)!.home_icon),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.history_rounded,
                size: 28,
                color: Colors.red.shade900,
              ),
              icon: const Icon(Icons.history_rounded),
              label: AppLocalizations.of(context)!.history),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.person_outline_rounded,
                size: 28,
                color: Colors.red.shade900,
              ),
              icon: const Icon(Icons.person_outline_rounded),
              label: AppLocalizations.of(context)!.profile),
        ],
      ),
    );
  }
}
