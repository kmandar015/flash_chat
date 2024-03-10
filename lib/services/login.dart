import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/models/UIHelper.dart';
import 'package:flash_chat/models/UserModel.dart';
import 'package:flash_chat/screens/HomePage.dart';
import 'package:flash_chat/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';

void login(
  TextEditingController emailController,
  TextEditingController passwordController,
  BuildContext context,
) async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  if (email == "" || password == "") {
    UIHelper.showAlertDialog(
        context, "Incomplete Data", "Please fill all the fields");
  } else {
    try {
      UserCredential? credential;

      UIHelper.showLoadingDialog(context, "Logging In..");

      try {
        credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (ex) {
        // Close the loading dialog
        Navigator.pop(context);

        // Show Alert Dialog
        UIHelper.showAlertDialog(
            context, "An error occured", ex.message.toString());
      }

      if (credential != null) {
        String uid = credential.user!.uid;

        DocumentSnapshot userData =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        UserModel userModel =
            UserModel.fromMap(userData.data() as Map<String, dynamic>);

        // Go to HomePage
        print("Log In Successful!");
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return HomePage(
                userModel: userModel, firebaseUser: credential!.user!);
          }),
        );
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message.toString(), context);
    }
  }
}
