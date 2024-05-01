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

  Circle copyWith({
    double? x,
    double? y,
    double? dx,
    double? dy,
  }) {
    return Circle(
      color: color,
      size: size,
      x: x ?? this.x,
      y: y ?? this.y,
      endX: endX,
      endY: endY,
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
    );
  }
}

class CircleAnimation extends StatefulWidget {
  const CircleAnimation({Key? key}) : super(key: key);

  @override
  _CircleAnimationState createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation> {
  late List<Circle> circles;
  late Timer timer;
  Size? previousSize;
  final Random _random = Random();
  final int maxCircles = 10; // Limit maximum number of circles

  @override
  void initState() {
    super.initState();
    circles = [];
    startAnimation();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startAnimation() {
    timer = Timer.periodic(const Duration(milliseconds: 16), (Timer t) {
      final List<Circle> updatedCircles = [];
      for (final circle in circles) {
        double newX = circle.x + circle.dx;
        double newY = circle.y + circle.dy;

        // Check if circle reaches the edges
        if (newX < 0 ||
            newX > MediaQuery.of(context).size.width - circle.size) {
          circle.dx *= -1; // Reverse horizontal direction
        }
        if (newY < 0 ||
            newY > MediaQuery.of(context).size.height - circle.size) {
          circle.dy *= -1; // Reverse vertical direction
        }
        updatedCircles.add(circle.copyWith(x: newX, y: newY));
      }

      setState(() {
        circles = updatedCircles;
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
    // Limit the number of circles to maxCircles
    while (circles.length < maxCircles) {
      double startX, startY, endX, endY;
      double dx, dy;

      if (circles.length % 2 == 0) {
        // Move from top-left to bottom-right
        startX = 0;
        startY = 0;
        endX = MediaQuery.of(context).size.width;
        endY = MediaQuery.of(context).size.height;
        dx = _random.nextDouble() * 2 + 1; // Random speed between 1 and 3
        dy = _random.nextDouble() * 2 + 1; // Random speed between 1 and 3
      } else {
        // Move from bottom-right to top-left
        startX = MediaQuery.of(context).size.width;
        startY = MediaQuery.of(context).size.height;
        endX = 0;
        endY = 0;
        dx = -(_random.nextDouble() * 2 + 1); // Random speed between -1 and -3
        dy = -(_random.nextDouble() * 2 + 1); // Random speed between -1 and -3
      }

      circles.add(
        Circle(
          color: getRandomBlue().withOpacity(1.0),
          size: _random.nextDouble() * 150 + 150,
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
    final int blue =
        _random.nextInt(256); // Random blue value between 0 and 255

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
