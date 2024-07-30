import 'dart:async';

import 'package:flutter/material.dart';

import 'homePage.dart';

class WaSplashscreen extends StatelessWidget {
  const WaSplashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SkyScrapper()));
    });
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/splashScreenImg.jpg'))),
        ),
      ),
    );
  }
}
