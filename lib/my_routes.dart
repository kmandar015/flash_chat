import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/splash_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case WelcomeScreen.id:
        return MaterialPageRoute(builder: (context) => WelcomeScreen());
      case LoginScreen.id:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RegistrationScreen.id:
        return MaterialPageRoute(builder: (context) => RegistrationScreen());
      case ChatScreen.id:
        return MaterialPageRoute(builder: (context) => ChatScreen());
      case SplashScreen.id:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      default:
    }

    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Text('No Routes Found'),
      ),
    );
  }
}
