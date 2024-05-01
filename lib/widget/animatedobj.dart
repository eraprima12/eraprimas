import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Circle {
  final Color color;
  final double size;
  double x;
  double y;
  double endX;
  double endY;
  double dx;
  double dy;

  Circle({
    required this.color,
    required this.size,
    required this.x,
    required this.y,
    required this.endX,
    required this.endY,
    required this.dx,
    required this.dy,
  });
}

class CircleAnimation extends StatefulWidget {
  const CircleAnimation({super.key});

  @override
  _CircleAnimationState createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation> {
  List<Circle> circles = [];
  late Timer timer;
  Size? previousSize;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startAnimation() {
    timer = Timer.periodic(const Duration(milliseconds: 16), (Timer t) {
      setState(() {
        for (int i = 0; i < circles.length; i++) {
          circles[i].x += circles[i].dx;
          circles[i].y += circles[i].dy;

          // Check if circle reaches the edges
          if (circles[i].x < 0 ||
              circles[i].x >
                  MediaQuery.of(context).size.width - circles[i].size) {
            circles[i].dx *= -1; // Reverse horizontal direction
          }
          if (circles[i].y < 0 ||
              circles[i].y >
                  MediaQuery.of(context).size.height - circles[i].size) {
            circles[i].dy *= -1; // Reverse vertical direction
          }
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentSize = MediaQuery.of(context).size;
    if (previousSize != currentSize) {
      previousSize = currentSize;
      circles.clear(); // Clear the circles when screen is resized
      generateCircles();
    }
  }

  void generateCircles() {
    for (int i = 0; i < 10; i++) {
      double startX, startY, endX, endY;
      double dx, dy;

      if (i % 2 == 0) {
        // Move from top-left to bottom-right
        startX = 0;
        startY = 0;
        endX = MediaQuery.of(context).size.width;
        endY = MediaQuery.of(context).size.height;
        dx = Random().nextDouble() * 2 + 1; // Random speed between 1 and 3
        dy = Random().nextDouble() * 2 + 1; // Random speed between 1 and 3
      } else {
        // Move from bottom-right to top-left
        startX = MediaQuery.of(context).size.width;
        startY = MediaQuery.of(context).size.height;
        endX = 0;
        endY = 0;
        dx = -(Random().nextDouble() * 2 + 1); // Random speed between -1 and -3
        dy = -(Random().nextDouble() * 2 + 1); // Random speed between -1 and -3
      }

      circles.add(
        Circle(
          color: getRandomBlue().withOpacity(1.0),
          size: Random().nextDouble() * 150 + 150,
          x: startX,
          y: startY,
          endX: endX,
          endY: endY,
          dx: dx,
          dy: dy,
        ),
      );
    }
  }

  Color getRandomBlue() {
    final Random random = Random();
    final int blue = random.nextInt(256); // Random blue value between 0 and 255

    return Color.fromARGB(255, 0, 0, blue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: circles
            .map(
              (circle) => Positioned(
                left: circle.x,
                top: circle.y,
                child: Container(
                  width: circle.size,
                  height: circle.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: circle.color,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
