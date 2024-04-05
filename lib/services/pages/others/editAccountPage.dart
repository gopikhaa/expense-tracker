import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:expense_tracker/services/models/account.dart';
import 'package:expense_tracker/services/pages/reusable/addTextField.dart';
import 'package:expense_tracker/services/pages/reusable/auth/authButton.dart';
import 'package:expense_tracker/services/pages/reusable/auth/errorDialog.dart';

class EditAccountPage extends StatefulWidget {
  EditAccountPage({Key? key, required this.editAcc, required this.acc})
      : super(key: key);
  final Function editAcc;
  final Account acc;
  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  late final oldName;
  late final oldAmount;
  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    oldName = widget.acc.name;
    oldAmount = widget.acc.amount;
    _nameController.text = oldName;
    _amountController.text = oldAmount.toString();
    super.initState();
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
      widget.editAcc(widget.acc, _nameController.text, enteredAmount);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Account'),
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
