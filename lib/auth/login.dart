import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:expense_tracker/services/pages/reusable/auth/textfieldOfauth.dart';
import 'package:expense_tracker/services/pages/reusable/auth/squareTileofAuth.dart';
import 'package:expense_tracker/services/pages/reusable/auth/authButton.dart';
import 'package:expense_tracker/services/pages/reusable/auth/errorDialog.dart';
import 'package:expense_tracker/services/functions/auth/google_auth_service.dart';
import 'package:expense_tracker/auth/resetPwPage.dart';

class Login extends StatefulWidget {
  Login({required this.onTap, Key? key}) : super(key: key);
  final Function() onTap;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  void signUserIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: usernameController.text, password: passwordController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(errorMessage: "Failed to sign in, please try again");
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              const Gap(20),
              AuthButton(buttonText: 'Sign In', fun: signUserIn),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPwPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
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
                    onTap: () => GoogleAuthService().signInWithGoogle(),
                    imagePath: 'assets/images/google.png',
                  ),
                  const Gap(25),
                  AuthSquareTile(
                    onTap: widget.onTap,
                    imagePath: 'assets/images/signUp.png',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
