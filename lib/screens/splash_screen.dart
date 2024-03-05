import 'dart:async';

import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    var duration = Duration(seconds: 2);
    return Timer(
      duration,
      () => Navigator.pushReplacementNamed(context, RegistrationScreen.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF305A6F), //#305a6f
        ),
        child: Center(
          child: Lottie.asset(
            'images/splash_animation.json',
            fit: BoxFit.cover,
            frameRate: FrameRate.max,
            repeat: false,
          ),
        ),
      ),
    );
  }
}
