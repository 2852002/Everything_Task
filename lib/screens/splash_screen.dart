import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 13, 5, 128), // Set a background color if desired
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
               ClipRRect(
              borderRadius: BorderRadius.circular(20.0), // Set the desired border radius
                  child:  Image.asset('image.png', width:100, height: 100), // Ensure the correct path to the image
            // Ensure the correct path to the image
            ),
                  //  Image.asset('image.png', width:100, height: 100), // Ensure the correct path to the image
            SizedBox(height: 20),
            Text(
              'Everything Tasks',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Schedule your week with ease',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
