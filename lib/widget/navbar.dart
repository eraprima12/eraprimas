import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/responsive.dart';

class NavBar extends StatelessWidget {
  List<Map<String, dynamic>> navLinks = [
    {"name": "Blog", "icons": Icons.menu_book},
    {"name": "Journey", "icons": Icons.rocket_launch_rounded},
    {"name": "Portofolio", "icons": Icons.workspace_premium}
  ];

  NavBar({super.key});

  List<Widget> navItem() {
    return navLinks.map((widget) {
      return Padding(
        padding: const EdgeInsets.only(left: 18),
        child: Text(widget['name'], style: GoogleFonts.montserrat()),
      );
    }).toList();
  }

  List<SidebarXItem> sidebarItem() {
    return navLinks.map((widget) {
      return SidebarXItem(icon: widget['icons'], label: widget['name']);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 38),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(colors: [
                      Color(0xFF242EF0),
                      Color(0xFF242EF0),
                    ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
                child: const Center(
                  child: Text("E",
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
          if (!ResponsiveLayout.isSmallScreen(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ...navItem(),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                    onTap: () async {
                      if (!await launchUrl(
                          Uri.parse('https://github.com/eraprima12'))) {
                        throw 'yes';
                      }
                    },
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0xFF242EF0), Color(0xFF242EF0)],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xFF6078ea).withOpacity(.3),
                                offset: const Offset(0, 8),
                                blurRadius: 8)
                          ]),
                      child: Material(
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            "GitHub",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            )
          else
            SidebarX(
              controller: SidebarXController(selectedIndex: 0),
              items: [
                ...sidebarItem(),
              ],
            ),
        ],
      ),
    );
  }
}
