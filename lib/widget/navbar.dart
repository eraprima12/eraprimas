import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/responsive.dart';

List<Map<String, dynamic>> navLinks = [
  {"name": "Blog", "icons": Icons.menu_book},
  {"name": "Journey", "icons": Icons.rocket_launch_rounded},
  {"name": "Portfolio", "icons": Icons.workspace_premium}
];

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

class NavBar extends StatelessWidget {
  const NavBar({super.key});
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
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context) {
                    return _buildPopupMenu(context);
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

Widget _buildPopupMenu(BuildContext context) {
  return Dialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    child: Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(
                              context); // Close the dialog when close button is pressed
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(navLinks.length, (index) {
                    return ListTile(
                      leading: Icon(
                        navLinks[index]["icons"],
                      ),
                      title: Text(navLinks[index]["name"]),
                      onTap: () {
                        // Handle onTap event here
                        Navigator.pop(context); // Close the dialog
                        // You can add more logic to handle menu clicks
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
