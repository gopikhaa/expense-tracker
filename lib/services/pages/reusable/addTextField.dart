import 'package:flutter/material.dart';

class AddTextField extends StatefulWidget {
  AddTextField(
      {required this.label,
      required this.controller,
      required this.keyNumber,
      required this.icon,
      Key? key})
      : super(key: key);
  final label;
  final bool keyNumber;
  final controller;
  final icon;

  @override
  _AddTextFieldState createState() => _AddTextFieldState();
}

class _AddTextFieldState extends State<AddTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        label: Text(widget.label),
        suffixIcon: widget.icon,
      ),
      keyboardType:
          widget.keyNumber ? TextInputType.number : TextInputType.text,
    );
  }
}
