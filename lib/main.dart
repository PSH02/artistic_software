import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'home_screen.dart';
import 'applications_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Color(
          0xFFF5F5F5,
        ), // Light grey background similar to images
        fontFamily: 'SFProDisplay', // Example font, use appropriate font
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/applications': (context) => ApplicationsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
