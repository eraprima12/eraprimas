import 'dart:ui';

import 'package:eraprimas/widget/animatedobj.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'widget/navbar.dart';
import 'utils/responsive.dart';

void main() => runApp(MaterialApp(
      title: 'Era Prima S',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ));

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF8FBFF),
            Color(0xFFFCFDFD),
          ],
        ),
      ),
      child: Scaffold(
        drawer: Drawer(
          child: ListView.builder(
            itemCount: navLinks.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(navLinks[index]["icon"]),
                title: Text(navLinks[index]["name"]),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              );
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            const CircleAnimation(),
            _buildFrostedBackground(),
            ListView(
              children: const [
                NavBar(),
                Body(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      largeScreen: LargeChild(),
      smallScreen: SmallChild(),
    );
  }
}

class LargeChild extends StatelessWidget {
  const LargeChild({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.centerRight,
            widthFactor: .6,
            child: Lottie.asset(
              'assets/dashboards.json',
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: .6,
            child: Padding(
              padding: const EdgeInsets.only(left: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Hi! 👋, I'm ",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat-Regular",
                        color: Color(0xFF8591B0),
                      ),
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 60, color: Color(0xFF8591B0)),
                      children: [
                        TextSpan(
                          text: "Era Prima S",
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8591B0)),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  // const Search()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildFrostedBackground() {
  return Positioned.fill(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
      child: Container(
        color: Colors.transparent,
      ),
    ),
  );
}

class SmallChild extends StatelessWidget {
  const SmallChild({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Hi! 👋, I'm ",
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 40,
                  color: Color(0xFF8591B0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 40,
                  color: Color(0xFF8591B0),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Era Prima S",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Color(0xFF8591B0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Lottie.asset(
                'assets/dashboards.json',
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
