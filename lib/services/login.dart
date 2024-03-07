import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';

void createAccount(
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController cPasswordController,
    BuildContext context) async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();
  String cpassword = cPasswordController.text.trim();

  if (email == "" || password == "" || cpassword == "") {
    showSnackBar("All fields are required", context);
  } else if (cpassword != password) {
    showSnackBar("Password doesn't match", context);
  } else {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        // push to home page
        showSnackBar("Logged in successful", context);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar("${e.message}", context);
    } catch (e) {
      showSnackBar("$e", context);
    }
  }
}
