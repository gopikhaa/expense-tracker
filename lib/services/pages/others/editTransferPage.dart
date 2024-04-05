import 'package:flutter/material.dart';
import 'package:expense_tracker/services/pages/reusable/lineOfAddTrans.dart';
import 'package:expense_tracker/services/pages/reusable/addTextField.dart';
import 'package:line_icons/line_icons.dart';
import 'package:gap/gap.dart';
import 'package:expense_tracker/services/pages/reusable/auth/authButton.dart';
import 'package:expense_tracker/services/pages/reusable/auth/errorDialog.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/services/functions/account_manager.dart';
import 'package:expense_tracker/services/models/account.dart';
import 'package:expense_tracker/services/models/trans.dart';
import 'package:expense_tracker/services/functions/checkData.dart';

class EditTransferPage extends StatefulWidget {
  EditTransferPage({required this.editTransfer, Key? key, required this.transfer}) : super(key: key);
  final Function editTransfer;
  final Trans transfer;

  @override
  _EditTransferPageState createState() => _EditTransferPageState();
}

class _EditTransferPageState extends State<EditTransferPage> {
  late String showAccount1;
  late String showAccount2;
  late Account _selectedAcc1;
  late Account _selectedAcc2;
  var format = DateFormat('d/M/yyyy (E)');
  late var _selectedDate;
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    _selectedAcc1 = AccountManager.findAccById(widget.transfer.accId);
    _selectedAcc2 = AccountManager.findAccById(widget.transfer.acc2Id);
    _amountController.text = widget.transfer.amount.toString();
    _noteController.text = widget.transfer.note;
    showAccount1 = AccountManager.accounts.isNotEmpty ? _selectedAcc1.name : 'No accounts available';
    showAccount2 = AccountManager.accounts.isNotEmpty ? _selectedAcc2.name : 'No accounts available';
    _selectedDate = widget.transfer.date;
    super.initState();
  }

  void _pickDate() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 3, now.month, now.day);
    final last = DateTime(now.year + 2, now.month, now.day);
    final pickedDate = await showDatePicker(context: context, firstDate: first, lastDate: last, initialDate: now);
    setState(() {
      _selectedDate = pickedDate!;
    });
  }

  void _showAccountPicker(BuildContext context, bool check) async {
    final selectedAccount = check ? _selectedAcc1 : _selectedAcc2;
    final selected = await showDialog<Account>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              check ? 'Select Account 1' : 'Select Account 2',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: AccountManager.accounts
                  .map<Widget>((account) => Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text(
                            account.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          leading: Icon(
                            Icons.account_circle,
                            color: Colors.deepPurple,
                          ),
                          tileColor: selectedAccount.name == account.name ? Colors.deepPurple.withOpacity(0.2) : null,
                          onTap: () {
                            Navigator.pop(context, account);
                          },
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
    if (selected != null) {
      setState(() {
        check
            ? (
                _selectedAcc1 = selected,
                showAccount1 = selected.name,
              )
            : (
                _selectedAcc2 = selected,
                showAccount2 = selected.name,
              );
      });
    }
  }

  void submitData() {
    if (CheckData(amount: _amountController.text, account: _selectedAcc1, category: _selectedAcc2.name)
        .checkDataTransfer(_selectedAcc2)) {
      widget.editTransfer(widget.transfer, _selectedAcc1.id, _selectedAcc2.id, double.parse(_amountController.text),
          _selectedAcc2.name, _noteController.text, _selectedDate);
    } else {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          errorMessage: 'Failed to save transfer, try again',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Transfer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LineOfAddTrans(
              fun: () => _pickDate(),
              text: 'Date       ',
              content: format.format(_selectedDate),
            ),
            const Gap(15),
            LineOfAddTrans(
              fun: () => _showAccountPicker(context, true),
              text: 'Account 1',
              content: showAccount1,
            ),
            const Gap(15),
            LineOfAddTrans(
              fun: () => _showAccountPicker(context, false),
              text: 'Account 2',
              content: showAccount2,
            ),
            const Gap(15),
            AddTextField(icon: Icon(LineIcons.coins), label: 'Amount', controller: _amountController, keyNumber: true),
            const Gap(15),
            AddTextField(icon: Icon(LineIcons.camera), label: 'Note', controller: _noteController, keyNumber: false),
            const Gap(30),
            AuthButton(buttonText: 'Save', fun: submitData)
          ],
        ),
      ),
    );
  }
}
