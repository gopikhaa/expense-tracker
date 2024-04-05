import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LineOfAddTrans extends StatelessWidget {
  const LineOfAddTrans(
      {required this.text, required this.content, required this.fun, Key? key})
      : super(key: key);
  final text;
  final content;
  final fun;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
              const Gap(100),
              Text(
                content,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
