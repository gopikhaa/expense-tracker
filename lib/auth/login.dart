import 'package:expense_tracker/network/fire_store.dart';
import 'package:expense_tracker/utils/image_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:expense_tracker/services/pages/reusable/auth/textfieldOfauth.dart';
import 'package:expense_tracker/services/pages/reusable/auth/authButton.dart';
import 'package:expense_tracker/services/pages/reusable/auth/errorDialog.dart';
import 'package:get_storage/get_storage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var box = GetStorage();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  void signUserIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
      FireStore().addCustomCategoryToDB();
      box.write("emailId", usernameController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return const ErrorDialog(
                errorMessage: "Failed to sign in, please try again");
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageUtils().ic_logo,
                height: 250,
                width: 250,
              ),
              const Gap(10),
              AuthTextField(
                controller: usernameController,
                hintText: 'Email',
                secure: false,
              ),
              const Gap(12),
              AuthTextField(
                controller: passwordController,
                hintText: 'Password',
                secure: true,
              ),
              const Gap(20),
              AuthButton(buttonText: 'Sign In', fun: signUserIn),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
