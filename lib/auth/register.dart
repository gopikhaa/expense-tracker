import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:expense_tracker/services/pages/reusable/auth/textfieldOfauth.dart';
import 'package:expense_tracker/services/pages/reusable/auth/squareTileofAuth.dart';
import 'package:expense_tracker/services/pages/reusable/auth/authButton.dart';
import 'package:expense_tracker/services/pages/reusable/auth/errorDialog.dart';
import 'package:expense_tracker/services/functions/auth/google_auth_service.dart';

class Register extends StatefulWidget {
  Register({required this.onTap, Key? key}) : super(key: key);
  final Function() onTap;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  void signUserUp() async {
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: usernameController.text, password: passwordController.text);
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(errorMessage: "Password not match");
            });
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(errorMessage: "Failed to sign up, please try again");
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/launcher_icon-removebg.png',
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
                const Gap(12),
                AuthTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  secure: true,
                ),
                const Gap(20),
                AuthButton(buttonText: 'Sign Up', fun: signUserUp),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                ),
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      Text('Or continue with',
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthSquareTile(
                      imagePath: 'assets/images/google.png',
                      onTap: () {
                        GoogleAuthService().signInWithGoogle();
                      },
                    ),
                    const Gap(25),
                    AuthSquareTile(
                      imagePath: 'assets/images/login.png',
                      onTap: widget.onTap,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
