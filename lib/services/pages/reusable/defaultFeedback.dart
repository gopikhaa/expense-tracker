import 'package:flutter/material.dart';

class DefaultFeedback extends StatelessWidget {
  const DefaultFeedback({required this.onTap, required this.feedback, Key? key})
      : super(key: key);

  final feedback;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(feedback),
        ),
      ),
    );
  }
}
