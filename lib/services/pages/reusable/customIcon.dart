import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String imagePath;
  final double iconSize;

  CustomIcon({required this.imagePath, this.iconSize = 48.0});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: iconSize,
      height: iconSize,
    );
  }
}
