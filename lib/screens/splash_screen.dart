import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/models/FirebaseHelper.dart';
import 'package:flash_chat/models/UserModel.dart';
import 'package:flash_chat/screens/login_screen.dart';
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
    return Timer(duration, () async {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Logged In
        UserModel? thisUserModel =
            await FirebaseHelper.getUserModelById(currentUser.uid);
        if (thisUserModel != null) {
          //Login
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => LoginScreen())));
        } else {
          //register
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => RegistrationScreen())));
        }
      } else {
        // Not logged in
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => RegistrationScreen())));
      }
    });
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
