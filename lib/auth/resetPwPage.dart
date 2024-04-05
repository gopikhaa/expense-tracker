import 'package:flutter/material.dart';
import 'package:expense_tracker/services/pages/reusable/auth/textfieldOfauth.dart';
import 'package:expense_tracker/services/pages/reusable/auth/authButton.dart';
import 'package:expense_tracker/services/pages/reusable/auth/errorDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gap/gap.dart';

class ResetPwPage extends StatefulWidget {
  ResetPwPage({Key? key}) : super(key: key);

  @override
  _ResetPwPageState createState() => _ResetPwPageState();
}

class _ResetPwPageState extends State<ResetPwPage> {
  Future resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Thank You'),
          content: Text('Please check your email.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          errorMessage: e.message.toString(),
        ),
      );
    }
  }

  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/launcher_icon-removebg.png',
              height: 250,
              width: 250,
            ),
            AuthTextField(
              controller: _emailController,
              secure: false,
              hintText: "Enter your email",
            ),
            const Gap(20),
            AuthButton(
              buttonText: "Reset Password",
              fun: resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}
