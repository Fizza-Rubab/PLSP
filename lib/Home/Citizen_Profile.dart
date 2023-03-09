import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CitizenProfile extends StatelessWidget {
  const CitizenProfile({super.key});
  final expandedHeight = 240.0;
  final collapsedHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            centerTitle: true,
            title: Text("Profile",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colors.black45,
                )),
            automaticallyImplyLeading: false,
            expandedHeight: expandedHeight,
            collapsedHeight: collapsedHeight,
            floating: true,
            pinned: true,
            snap: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              // title: Text("Profile",
              //     style: GoogleFonts.poppins(
              //       fontSize: 24,
              //       fontWeight: FontWeight.w600,
              //       letterSpacing: 0,
              //       color: Colors.black45,
              //     )),
              background: Stack(alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color: Colors.transparent,
                    height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                          image: DecorationImage(
                            image: AssetImage("assets/images/welcome-bg.png"), fit: BoxFit.cover,
                            // colorFilter: ColorFilter.mode(Colors.white12, BlendMode.overlay)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: CircleBorder(),
                      ),
                      child: const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/profileicon.png"),
                        radius: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // for (int i = 0; i < 10; i++)
          //   SliverToBoxAdapter(
          //     child: Container(
          //       height: 200,
          //       color: i % 2 == 0 ? Colors.grey : Colors.grey.shade300,
          //     ),
          //   ),
        ],
      ),
    );
  }
}
