import 'package:flutter/material.dart';
import 'package:expense_tracker/services/models/account.dart';

class AccountItem extends StatelessWidget {
  const AccountItem({
    Key? key,
    required this.acc,
  }) : super(key: key);

  final Account acc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(acc.name),
          Text(
            acc.amount.abs().toString() + '\$',
            style: TextStyle(
              color: acc.amount >= 0 ? Colors.blue : Colors.red,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
