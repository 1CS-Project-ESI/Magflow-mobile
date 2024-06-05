import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo/magflow.png', // Replace with your asset path
          fit: BoxFit.cover, // Adjust as needed
        ),
      ),
    );
  }
}
