import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/network/fire_store.dart';
import 'package:expense_tracker/services/functions/account_manager.dart';
import 'package:expense_tracker/services/models/trans.dart';
import 'package:expense_tracker/services/pages/others/newTransaction.dart';
import 'package:expense_tracker/services/pages/others/transactionList.dart';
import 'package:expense_tracker/services/functions/transaction_manager.dart';

class TransPage extends StatefulWidget {
  TransPage({Key? key}) : super(key: key);

  @override
  State<TransPage> createState() => _TransPageState();
}

class _TransPageState extends State<TransPage> {
  var _selectedPage = 0;
  final _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPageChange(int page) {
    setState(() {
      _selectedPage = page;
    });
  }

  void _editTransaction(Trans tran, var newAccId, var newAcc2Id, var newAmount,
      var newCategory, var newNote, var newDate) {
    if (tran.type == Type.Transfer) {
      setState(() {
        AccountManager.findAccById(tran.accId).amount +=
            (tran.amount - newAmount);
        AccountManager.findAccById(tran.acc2Id).amount -=
            (tran.amount - newAmount);
        tran.accId = newAccId;
        tran.acc2Id = newAcc2Id;
        tran.amount = newAmount;
        tran.category = newCategory;
        tran.note = newNote;
        tran.date = newDate;

        FireStore().editTransactionToFireStore(tran, newAccId, newAcc2Id,
            newAmount, newCategory, newNote, newDate);
      });
      FireStore().editAccountToFireStore(
          AccountManager.findAccById(tran.accId),
          AccountManager.findAccById(tran.accId).name,
          AccountManager.findAccById(tran.accId).amount);
      FireStore().editAccountToFireStore(
          AccountManager.findAccById(tran.acc2Id),
          AccountManager.findAccById(tran.acc2Id).name,
          AccountManager.findAccById(tran.acc2Id).amount);
      Navigator.pop(context);
    } else {
      setState(() {
        tran.type == Type.Income
            ? AccountManager.findAccById(tran.accId).amount -=
                (tran.amount - newAmount)
            : AccountManager.findAccById(tran.accId).amount +=
                (tran.amount - newAmount);
        tran.accId = newAccId;
        tran.acc2Id = newAcc2Id;
        tran.amount = newAmount;
        tran.category = newCategory;
        tran.note = newNote;
        tran.date = newDate;
      });
      FireStore().editTransactionToFireStore(
          tran, newAccId, newAcc2Id, newAmount, newCategory, newNote, newDate);
      FireStore().editAccountToFireStore(
          AccountManager.findAccById(tran.accId),
          AccountManager.findAccById(tran.accId).name,
          AccountManager.findAccById(tran.accId).amount);
    }
    Navigator.pop(context);
  }

  var _selectedDate = DateTime.now();

  @override
  void initState() {
    var userId = FireStore().getUserId();
    FireStore().fetchAllTransactionsFromFireStore(userId).then((value) {
      TransactionManager().getTransactionsWeekly(_selectedDate);
      TransactionManager().getTransactionsMonthly(_selectedDate);
      TransactionManager().getTransactionsYearly(_selectedDate);
      setState(() {});
    });
    super.initState();
  }

  int getIsoWeekNumber(DateTime date) {
    DateTime monday = date.subtract(Duration(days: date.weekday - 1));
    DateTime thursday = monday.add(Duration(days: 3));
    DateTime yearStart = DateTime.utc(date.year, 1, 1);
    int weekNumber = ((thursday.difference(yearStart).inDays) / 7).ceil();
    return weekNumber;
  }

  bool isSameWeek(DateTime date1, DateTime date2) {
    int weekNumber1 = getIsoWeekNumber(date1);
    int weekNumber2 = getIsoWeekNumber(date2);
    return date1.year == date2.year && weekNumber1 == weekNumber2;
  }

  void _deleteTransaction(Trans tran) {
    final transactionIndex = TransactionManager.trans.indexOf(tran);
    final weeklyTransactionIndex = TransactionManager.weeklyTrans.indexOf(tran);
    final monthTransactionIndex = TransactionManager.monthlyTrans.indexOf(tran);
    final yearlyTransactionIndex = TransactionManager.yearlyTrans.indexOf(tran);
    setState(() {
      if (tran.type == Type.Income) {
        AccountManager.findAccById(tran.accId).amount -= tran.amount;
        FireStore().editAccountToFireStore(
            AccountManager.findAccById(tran.accId),
            AccountManager.findAccById(tran.accId).name,
            AccountManager.findAccById(tran.accId).amount);
      } else if (tran.type == Type.Expense) {
        AccountManager.findAccById(tran.accId).amount += tran.amount;
        FireStore().editAccountToFireStore(
            AccountManager.findAccById(tran.accId),
            AccountManager.findAccById(tran.accId).name,
            AccountManager.findAccById(tran.accId).amount);
      } else {
        AccountManager.findAccById(tran.accId).amount += tran.amount;
        AccountManager.findAccById(tran.acc2Id).amount -= tran.amount;
        FireStore().editAccountToFireStore(
            AccountManager.findAccById(tran.accId),
            AccountManager.findAccById(tran.accId).name,
            AccountManager.findAccById(tran.accId).amount);
        FireStore().editAccountToFireStore(
            AccountManager.findAccById(tran.acc2Id),
            AccountManager.findAccById(tran.acc2Id).name,
            AccountManager.findAccById(tran.acc2Id).amount);
      }
      TransactionManager.trans.remove(tran);
      FireStore().removeTransactionToFireStore(tran);
      if (isSameWeek(tran.date, _selectedDate)) {
        TransactionManager.weeklyTrans.remove(tran);
        TransactionManager.monthlyTrans.remove(tran);
        TransactionManager.yearlyTrans.remove(tran);
      } else if (tran.date.month == _selectedDate.month &&
          tran.date.year == _selectedDate.year) {
        TransactionManager.monthlyTrans.remove(tran);
        TransactionManager.yearlyTrans.remove(tran);
      } else if (tran.date.year == _selectedDate.year) {
        TransactionManager.yearlyTrans.remove(tran);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Transaction Deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                if (tran.type == Type.Income) {
                  AccountManager.findAccById(tran.accId).amount += tran.amount;
                  FireStore().editAccountToFireStore(
                      AccountManager.findAccById(tran.accId),
                      AccountManager.findAccById(tran.accId).name,
                      AccountManager.findAccById(tran.accId).amount);
                } else if (tran.type == Type.Expense) {
                  AccountManager.findAccById(tran.accId).amount -= tran.amount;
                  FireStore().editAccountToFireStore(
                      AccountManager.findAccById(tran.accId),
                      AccountManager.findAccById(tran.accId).name,
                      AccountManager.findAccById(tran.accId).amount);
                } else {
                  AccountManager.findAccById(tran.accId).amount -= tran.amount;
                  AccountManager.findAccById(tran.acc2Id).amount += tran.amount;
                  FireStore().editAccountToFireStore(
                      AccountManager.findAccById(tran.accId),
                      AccountManager.findAccById(tran.accId).name,
                      AccountManager.findAccById(tran.accId).amount);
                  FireStore().editAccountToFireStore(
                      AccountManager.findAccById(tran.acc2Id),
                      AccountManager.findAccById(tran.acc2Id).name,
                      AccountManager.findAccById(tran.acc2Id).amount);
                }
                FireStore().addTransactionToFireStore(tran);
                TransactionManager.trans.insert(transactionIndex, tran);
                if (isSameWeek(tran.date, _selectedDate)) {
                  TransactionManager.weeklyTrans
                      .insert(weeklyTransactionIndex, tran);
                  TransactionManager.monthlyTrans
                      .insert(monthTransactionIndex, tran);
                  TransactionManager.yearlyTrans
                      .insert(yearlyTransactionIndex, tran);
                } else if (tran.date.month == _selectedDate.month &&
                    tran.date.year == _selectedDate.year) {
                  TransactionManager.monthlyTrans
                      .insert(monthTransactionIndex, tran);
                  TransactionManager.yearlyTrans
                      .insert(yearlyTransactionIndex, tran);
                } else if (tran.date.year == _selectedDate.year) {
                  TransactionManager.yearlyTrans
                      .insert(yearlyTransactionIndex, tran);
                }
              });
            }),
      ),
    );
  }

  void addTrans(Trans tran) {
    setState(() {
      if (tran.type == Type.Income) {
        AccountManager.findAccById(tran.accId).amount += tran.amount;
        FireStore().editAccountToFireStore(
            AccountManager.findAccById(tran.accId),
            AccountManager.findAccById(tran.accId).name,
            AccountManager.findAccById(tran.accId).amount);
      } else if (tran.type == Type.Expense) {
        AccountManager.findAccById(tran.accId).amount -= tran.amount;
        FireStore().editAccountToFireStore(
            AccountManager.findAccById(tran.accId),
            AccountManager.findAccById(tran.accId).name,
            AccountManager.findAccById(tran.accId).amount);
      } else if (tran.type == Type.Transfer) {
        AccountManager.findAccById(tran.accId).amount -= tran.amount;
        AccountManager.findAccById(tran.acc2Id).amount += tran.amount;
        FireStore().editAccountToFireStore(
            AccountManager.findAccById(tran.accId),
            AccountManager.findAccById(tran.accId).name,
            AccountManager.findAccById(tran.accId).amount);
        FireStore().editAccountToFireStore(
            AccountManager.findAccById(tran.acc2Id),
            AccountManager.findAccById(tran.acc2Id).name,
            AccountManager.findAccById(tran.acc2Id).amount);
      }
      TransactionManager.trans.add(tran);
      FireStore().addTransactionToFireStore(tran);
      TransactionManager().getTransactionsWeekly(_selectedDate);
      TransactionManager().getTransactionsMonthly(_selectedDate);
      TransactionManager().getTransactionsYearly(_selectedDate);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var format = DateFormat('d/M/yyyy');
    void _pickDate() async {
      final now = DateTime.now();
      final first = DateTime(now.year - 3, now.month, now.day);
      final last = DateTime(now.year + 2, now.month, now.day);
      final pickedDate = await showDatePicker(
          context: context, firstDate: first, lastDate: last, initialDate: now);
      setState(() {
        _selectedDate = pickedDate!;
        TransactionManager().getTransactionsWeekly(_selectedDate);
        TransactionManager().getTransactionsMonthly(_selectedDate);
        TransactionManager().getTransactionsYearly(_selectedDate);
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: TextButton(
              onPressed: () => _pickDate(),
              child: Text(
                format.format(_selectedDate),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _controller.animateToPage(
                0,
                duration: Duration(
                  milliseconds: 500,
                ),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
              'Weekly',
              style: TextStyle(
                color: _selectedPage == 0 ? Colors.black : Colors.deepPurple,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _controller.animateToPage(
                1,
                duration: Duration(
                  milliseconds: 500,
                ),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
              'Monthly',
              style: TextStyle(
                color: _selectedPage == 1 ? Colors.black : Colors.deepPurple,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _controller.animateToPage(
                2,
                duration: Duration(
                  milliseconds: 500,
                ),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
              'Yearly',
              style: TextStyle(
                color: _selectedPage == 2 ? Colors.black : Colors.deepPurple,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _controller.animateToPage(
                3,
                duration: Duration(
                  milliseconds: 500,
                ),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
              'Total',
              style: TextStyle(
                color: _selectedPage == 3 ? Colors.black : Colors.deepPurple,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 6, 41, 154),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewTransaction(
                        addTrans: addTrans,
                      )));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: PageView(
        onPageChanged: _onPageChange,
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: [
          TransactionManager.weeklyTrans.length == 0
              ? Center(
                  child: Text(
                  'No transaction found!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ))
              : TransactionList(
                  editTransaction: _editTransaction,
                  transList: TransactionManager.weeklyTrans,
                  deleteTransaction: _deleteTransaction,
                ),
          TransactionManager.monthlyTrans.length == 0
              ? Center(
                  child: Text(
                  'No transaction found!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ))
              : TransactionList(
                  editTransaction: _editTransaction,
                  transList: TransactionManager.monthlyTrans,
                  deleteTransaction: _deleteTransaction,
                ),
          TransactionManager.yearlyTrans.length == 0
              ? Center(
                  child: Text(
                    'No transaction found!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : TransactionList(
                  editTransaction: _editTransaction,
                  transList: TransactionManager.yearlyTrans,
                  deleteTransaction: _deleteTransaction,
                ),
          TransactionManager.trans.length == 0
              ? Center(
                  child: Text(
                    'No transaction found!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : TransactionList(
                  editTransaction: _editTransaction,
                  transList: TransactionManager.trans,
                  deleteTransaction: _deleteTransaction,
                ),
        ],
      ),
    );
  }
}
