import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/firebase_options.dart';
import 'package:flash_chat/my_routes.dart';
import 'package:flash_chat/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: MyRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        // Define the primary color for buttons and cursor color
        primaryColor: Color(0xFF305A6F),
        // Define the color for the text field border
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(0xFF305A6F),
          selectionColor: Color(0xFF305A6F),
          selectionHandleColor: Color(0xFF305A6F),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF305A6F),
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF305A6F),
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF305A6F),
        ),
      ),
    );
  }
}
