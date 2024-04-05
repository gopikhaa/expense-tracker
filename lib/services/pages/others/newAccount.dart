import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:expense_tracker/services/models/account.dart';
import 'package:expense_tracker/services/pages/reusable/addTextField.dart';
import 'package:expense_tracker/services/pages/reusable/auth/authButton.dart';
import 'package:expense_tracker/services/pages/reusable/auth/errorDialog.dart';

class NewAccount extends StatefulWidget {
  NewAccount({Key? key, required this.addAcc}) : super(key: key);
  final Function addAcc;
  @override
  _NewAccountState createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  void submitData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final bool checkAmount = enteredAmount == null;
    if (checkAmount) {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          errorMessage: 'Failed to save account, try again',
        ),
      );
    } else {
      Account acc = Account(name: _nameController.text, amount: enteredAmount);
      widget.addAcc(acc);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            AddTextField(
              label: 'Name',
              controller: _nameController,
              keyNumber: false,
              icon: Icon(Icons.account_balance_wallet),
            ),
            AddTextField(
              label: 'Amount',
              controller: _amountController,
              keyNumber: true,
              icon: Icon(Icons.money),
            ),
            const Gap(50),
            AuthButton(buttonText: 'Save', fun: submitData),
          ],
        ),
      ),
    );
  }
}
