import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _rotationAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.linear));

    // Adjust offsets to match the desired movement
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -0.5), // Start from above center
      end: Offset(0, 0.3), // End slightly above "Focus." text
    ).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.easeInOutCubic),
    );

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildStar() {
    // A simplified representation of the star shape.
    // For a more accurate shape, consider using CustomPaint or an SVG.
    return Transform.rotate(
      angle: 45 * math.pi / 180, // Rotate the container to make it diamond-like
      child: Container(
        width: 180,
        height: 180,
        child: Stack(
          children: [
            Positioned.fill(
              child: Transform.rotate(
                angle: 0,
                child: ClipPath(
                  clipper: StarClipper(),
                  child: Container(color: Colors.yellow[600]?.withOpacity(0.8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    List<String> backgroundTexts = [
      "Goal-setting",
      "Dedication",
      "Workflow",
      "Efficiency",
      "Concentration",
      "Discipline",
      "Balance",
      "Productivity",
      "Time management",
      "Performance",
    ];

    return Scaffold(
      backgroundColor: Color(0xFFF08080), // Light Coral background
      body: Stack(
        children: <Widget>[
          // Background texts
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10.0,
                runSpacing: 5.0,
                children:
                    backgroundTexts
                        .map(
                          (text) => Text(
                            text,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.25),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
          // Animated Star and Focus Text
          AnimatedBuilder(
            animation: _controller!,
            builder: (context, child) {
              return SlideTransition(
                position: _slideAnimation!,
                child: RotationTransition(
                  turns: _rotationAnimation!,
                  child: Center(child: _buildStar()),
                ),
              );
            },
          ),

          // Focus Text (Position it based on the star's final position)
          Align(
            alignment: Alignment(
              0,
              0.55,
            ), // Adjust Y to be below the animated star
            child: Text(
              'Focus.',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // Get Started Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: screenHeight * 0.1,
                left: 30,
                right: 30,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: Size(screenWidth * 0.8, 60),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Get Started',
                      style: TextStyle(
                        color: Color(0xFFF08080),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Color(0xFFF08080)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for the Star Shape
class StarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    // This is a simplified four-point star. Adjust points for exact shape.
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double outerRadius = size.width / 2;
    double innerRadius = size.width / 4; // Adjust for pointiness

    List<Offset> points = [];
    for (int i = 0; i < 8; i++) {
      // 4 points means 8 segments for inner/outer
      double radius = i.isEven ? outerRadius : innerRadius;
      double angle = (i * 360 / 8) - (360 / 16); // Shift angle to align points
      points.add(
        Offset(
          centerX + radius * math.cos(angle * math.pi / 180),
          centerY + radius * math.sin(angle * math.pi / 180),
        ),
      );
    }
    path.addPolygon(points, true);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
