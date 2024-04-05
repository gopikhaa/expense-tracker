import 'package:flutter/material.dart';
import 'package:expense_tracker/services/pages/others/editAccountPage.dart';

class AccountItemRm extends StatelessWidget {
  const AccountItemRm({
    Key? key,
    required this.account,
    required this.removeAcc,
    required this.editAcc,
  }) : super(key: key);

  final Function removeAcc;
  final Function editAcc;

  final account;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(account.name),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditAccountPage(editAcc: editAcc, acc: account),
                    ),
                  );
                },
                icon: Icon(
                  Icons.edit,
                ),
              ),
              IconButton(
                onPressed: () => removeAcc(account),
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
