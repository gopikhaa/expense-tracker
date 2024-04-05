import 'package:flutter/material.dart';

class IconButtonText extends StatelessWidget {
  const IconButtonText(
      {required this.fun, required this.label, required this.icon, Key? key})
      : super(key: key);
  final icon;
  final label;
  final Function() fun;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: fun,
          icon: icon,
          iconSize: 48,
        ),
        Text(label),
      ],
    );
  }
}
