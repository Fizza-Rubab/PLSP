import 'package:flutter/material.dart';
import 'package:google_maps/Lifesaver/Lifesaver_Feedback.dart';
import 'package:google_maps/Lifesaver/RedirectDestination.dart';
import 'Lifesaver_Home.dart';
import 'Lifesaver_History.dart';
import 'Lifesaver_Profile.dart';
// import 'testing.dart'; 
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
    const LifesaverProfile(),
  ];
  final PageController _pageController = PageController();
  int index = 0;

  @override
  // void initState() {
    
    // TODO: implement initState
  //   super.initState();
  //   Future.delayed(Duration(seconds: 20), () {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) => CustomAlertDialog(),
  //     );
  // });
 
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //   Future.delayed(Duration(seconds: 30), () {
  //     // showDialog(
  //     //   context: context,
  //     //   builder: (BuildContext context) => CustomAlertDialog(),
  //     // );
  //     Navigator.of(context)
  //                     .push(MaterialPageRoute(builder: (context) => RedirectDestination()));
  // });
 
  }

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
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: index,
        onDestinationSelected: (index) {
          _pageController.jumpToPage(index);
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
