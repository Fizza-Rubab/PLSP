import 'package:flutter/material.dart';
import 'package:google_maps/Lifesaver/Lifesaver_Feedback.dart';
import 'package:google_maps/Lifesaver/RedirectDestination.dart';
import 'Lifesaver_Home.dart';
import 'Lifesaver_History.dart';
import 'Lifesaver_Profile.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.red, // Set the background color to red
      title: Row(
        children: [
          Icon(
            Icons.local_hospital,
            color: Colors.white,
          ),
          SizedBox(width: 9),
          Text(
            'EMERGENCY ALERT!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
      content: Text(
        'There is an emergency in 5km vicinity.\nDo you want to accept the request?',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        ButtonBar(
          children: [
            ElevatedButton(
              onPressed: () => {Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => RedirectDestination()))
                      },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Set the accept button color to green
              ),
              child: Text('Accept'),
            ),
            TextButton(
              onPressed:  () => {Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Lifesaver_Feedback()))
                      },
              style: TextButton.styleFrom(
                backgroundColor: Colors.orangeAccent.shade700,
                foregroundColor: Colors.white// Set the reject button color to orange
              ),
              child: Text('Reject'),
            ),
          ],
        ),
      ],
    );
  }
}


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
    Future.delayed(Duration(seconds: 30), () {
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) => CustomAlertDialog(),
      // );
      Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => RedirectDestination()));
  });
 
  }

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
