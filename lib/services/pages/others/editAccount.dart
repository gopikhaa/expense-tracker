import 'package:flutter/material.dart';
import 'package:expense_tracker/services/functions/account_manager.dart';
import 'package:expense_tracker/services/pages/others/accountItemRm.dart';

class EditAccount extends StatefulWidget {
  EditAccount({Key? key, required this.removeAcc, required this.editAcc}) : super(key: key);
  final Function removeAcc;
  final Function editAcc;

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  void removeAccount(var acc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: Text('Confirm Remove')),
        content: Text('Are you sure want to remove account?'),
        actions: [
          ElevatedButton(
            onPressed: () => setState(() {
              widget.removeAcc(acc);
              Navigator.pop(context);
            }),
            child: Text('OK'),
          ),
          ElevatedButton(
            onPressed: () => setState(() {
              Navigator.pop(context);
            }),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Column(
            children: AccountManager.accounts
                .map(
                  (e) => AccountItemRm(
                    editAcc: widget.editAcc,
                    account: e,
                    removeAcc: removeAccount,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
