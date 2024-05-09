import 'package:flutter/material.dart';
import 'package:expense_tracker/services/models/category.dart';
import 'package:expense_tracker/services/pages/reusable/lineOfAddTrans.dart';
import 'package:expense_tracker/services/pages/reusable/addTextField.dart';
import 'package:expense_tracker/services/pages/reusable/auth/errorDialog.dart';
import 'package:line_icons/line_icons.dart';
import 'package:gap/gap.dart';
import 'package:expense_tracker/services/pages/reusable/auth/authButton.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/services/functions/account_manager.dart';
import 'package:expense_tracker/services/functions/transaction_category_manager.dart';
import 'package:expense_tracker/services/models/account.dart';
import 'package:expense_tracker/services/models/trans.dart';
import 'package:expense_tracker/services/functions/checkData.dart';

class EditExpensePage extends StatefulWidget {
  EditExpensePage({required this.editTrans, required this.tran, Key? key})
      : super(key: key);

  final Function editTrans;
  final Trans tran;
  @override
  _EditExpensePageState createState() => _EditExpensePageState();
}

class _EditExpensePageState extends State<EditExpensePage> {
  late Account selectedAccount;
  late String showAccount;
  late String showCategory;
  late Category selectedCategory;

  var format = DateFormat('d/M/yyyy (E)');
  late var _selectedDate;
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  @override
  void initState() {
    selectedAccount = AccountManager.findAccById(widget.tran.accId);
    showAccount = AccountManager.accounts.isNotEmpty
        ? selectedAccount.name
        : 'No accounts available';
    showCategory = TransactionCategoryManager.expenseCategories.isNotEmpty
        ? TransactionCategoryManager.getCategoryFromId(widget.tran.category)
            .name
        : 'No category available';
    _selectedDate = widget.tran.date;
    _amountController.text = widget.tran.amount.toString();
    _noteController.text = widget.tran.note;
    selectedCategory =
        TransactionCategoryManager.getCategoryFromId(widget.tran.category);
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 3, now.month, now.day);
    final last = DateTime(now.year + 2, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: first, lastDate: last, initialDate: now);
    setState(() {
      _selectedDate = pickedDate!;
    });
  }

  void _showAccountPicker(BuildContext context) async {
    final selected = await showDialog<Account>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Select Account',
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
                          tileColor: selectedAccount.name == account.name
                              ? Colors.deepPurple.withOpacity(0.2)
                              : null,
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
        selectedAccount = selected;
        showAccount = selected.name;
      });
    }
  }

  void submitData() {
    if (CheckData(
            amount: _amountController.text,
            account: selectedAccount,
            category: selectedCategory.id)
        .checkDataTrans()) {
      widget.editTrans(
          widget.tran,
          selectedAccount.id,
          "",
          double.parse(_amountController.text),
          selectedCategory.id,
          _noteController.text,
          _selectedDate);
    } else {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          errorMessage: 'Failed to save income, try again',
        ),
      );
    }
  }

  void _showCategoryPicker(BuildContext context) async {
    final selected = await showDialog<Category>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Select Category',
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
              children: TransactionCategoryManager.expenseCategories
                  .map<Widget>((category) => Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text(
                            category.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          leading: Icon(
                            Icons.food_bank,
                            color: Colors.deepPurple,
                          ),
                          tileColor: selectedCategory == category
                              ? Colors.deepPurple.withOpacity(0.2)
                              : null,
                          onTap: () {
                            Navigator.pop(context, category);
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
        selectedCategory = selected;
        showCategory = selected.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            LineOfAddTrans(
              fun: () => _pickDate(),
              text: 'Date       ',
              content: format.format(_selectedDate),
            ),
            const Gap(13),
            LineOfAddTrans(
              fun: () => _showAccountPicker(context),
              text: 'Account ',
              content: showAccount,
            ),
            const Gap(13),
            LineOfAddTrans(
              fun: () => _showCategoryPicker(context),
              text: 'Category',
              content: showCategory,
            ),
            const Gap(15),
            AddTextField(
                icon: Icon(LineIcons.coins),
                label: 'Amount',
                controller: _amountController,
                keyNumber: true),
            const Gap(15),
            AddTextField(
                icon: Icon(LineIcons.stickyNote),
                label: 'Note',
                controller: _noteController,
                keyNumber: false),
            const Gap(30),
            AuthButton(buttonText: 'Save', fun: submitData)
          ],
        ),
      ),
    );
  }
}
