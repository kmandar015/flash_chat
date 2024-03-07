import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/firebase_options.dart';
// import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/splash_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/my_routes.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(
      FlashChat(),
    );
    log('Firebase initialized successfully');
  } catch (e) {
    log('Error initializing Firebase: $e');
  }
}

class FlashChat extends StatefulWidget {
  @override
  State<FlashChat> createState() => _FlashChatState();
}

class _FlashChatState extends State<FlashChat> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: MyRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
    );
  }
}
