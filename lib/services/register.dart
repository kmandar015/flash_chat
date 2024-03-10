import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/models/UIHelper.dart';
import 'package:flash_chat/models/UserModel.dart';
import 'package:flash_chat/screens/CompleteProfile.dart';
import 'package:flash_chat/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';

void createAccount(
  TextEditingController emailController,
  TextEditingController passwordController,
  TextEditingController cPasswordController,
  BuildContext context,
) async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();
  String cpassword = cPasswordController.text.trim();

  if (email == "" || password == "" || cpassword == "") {
    showSnackBar("All fields are required", context);
  } else if (cpassword != password) {
    showSnackBar("Password doesn't match", context);
  } else {
    UserCredential? credential;

    UIHelper.showLoadingDialog(context, "Creating new account..");

    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);

      UIHelper.showAlertDialog(
          context, "An error occured", ex.message.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;
      UserModel newUser =
          UserModel(uid: uid, email: email, fullname: "", profilepic: "");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(newUser.toMap())
          .then((value) {
        print("New User Created!");
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return CompleteProfile(
                userModel: newUser, firebaseUser: credential!.user!);
          }),
        );
      });
    }
  }
}
