import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';

typedef void LoginCallback();

void login(
  TextEditingController emailController,
  TextEditingController passwordController,
  BuildContext context,
  LoginCallback callback,
) async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  if (email == "" || password == "") {
    showSnackBar("Please fill all the details", context);
  } else {
    try {
      // Show loading indicator here if needed
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      showSnackBar("Login Successful", context);
      log(userCredential.user.toString());
      // Call the callback function to handle UI changes
      callback();
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message.toString(), context);
      // Call the callback function to handle UI changes
      callback();
    }
  }
}
