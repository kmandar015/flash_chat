import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:flash_chat/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password;

  bool spinner = false;
  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<bool>? handsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final reenterPasswordFocusNode = FocusNode();

  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    reenterPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    height: 250,
                    child: RiveAnimation.asset(
                      "images/login_animation.riv",
                      stateMachines: ["State Machine 1"],
                      onInit: (artboard) {
                        print("Rive Animation Initialized");
                        controller = StateMachineController.fromArtboard(
                          artboard,
                          "State Machine 1",
                        );

                        if (controller == null) {
                          print("Error: StateMachineController is null");
                          return;
                        }
                        artboard.addController(controller!);
                        isChecking = controller?.findInput("Check");
                        handsUp = controller?.findInput("hands_up");
                        trigSuccess = controller?.findInput("success");
                        trigFail = controller?.findInput("fail");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      if (handsUp != null) {
                        handsUp!.change(false);
                      }
                      if (isChecking == null) {
                        print("Error: isChecking is null");
                        return;
                      }
                      isChecking!.change(true);
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    focusNode: emailFocusNode,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      if (isChecking != null) {
                        isChecking!.change(false);
                      }
                      if (handsUp == null) {
                        print("Error: handsUp is null");
                        return;
                      }
                      handsUp!.change(true);
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscured,
                    focusNode: passwordFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: _toggleObscured,
                        child: Icon(
                          _obscured
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          size: 24,
                        ),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(reenterPasswordFocusNode);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      if (isChecking != null) {
                        isChecking!.change(false);
                      }
                      if (handsUp == null) {
                        print("Error: handsUp is null");
                        return;
                      }
                      handsUp!.change(true);
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscured,
                    focusNode: reenterPasswordFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Re-Enter Your Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: _toggleObscured,
                        child: Icon(
                          _obscured
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minWidth: size.width,
                    height: 50,
                    color: Colors.purple,
                    onPressed: () {
                      // todo Registration
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: Text('Login'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
