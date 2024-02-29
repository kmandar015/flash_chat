// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/my_routes.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    log('Firebase initialized successfully');

    runApp(FlashChat());
  } catch (e) {
    log('Error initializing Firebase: $e');
  }
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: MyRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
    );
  }
}
