import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  AuthTextField(
      {required this.controller,
      required this.secure,
      required this.hintText,
      super.key});
  final String hintText;
  final bool secure;
  final controller;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: TextField(
            controller: widget.controller,
            obscureText: (widget.hintText == "Email") ? false : showPassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              icon: Icon(
                (widget.hintText == "Email") ? Icons.email : Icons.lock,
                color: Colors.black,
                size: 24.0,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                child: Icon(
                  (widget.hintText == "Email") ? null : Icons.remove_red_eye,
                  color: Colors.black,
                  size: 24.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
