import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/services/functions/account_manager.dart';
import 'package:expense_tracker/services/functions/transaction_category_manager.dart';
import 'package:expense_tracker/services/models/trans.dart';
import 'package:expense_tracker/services/pages/others/editExpensePage.dart';
import 'package:expense_tracker/services/pages/others/editIncomePage.dart';
import 'package:expense_tracker/services/pages/others/editTransferPage.dart';

class TransactionItem extends StatelessWidget {
  TransactionItem({required this.transaction, required this.editTransaction, Key? key}) : super(key: key);
  final Trans transaction;
  final format = DateFormat('d/M/yy');
  final Function editTransaction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => transaction.type == Type.Transfer
                ? EditTransferPage(editTransfer: editTransaction, transfer: transaction)
                : transaction.type == Type.Income
                    ? EditIncomePage(editTrans: editTransaction, tran: transaction)
                    : EditExpensePage(editTrans: editTransaction, tran: transaction),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(children: [
            Container(
              width: MediaQuery.of(context).size.width / 4,
              child: Column(
                children: [
                  Text(
                    format.format(transaction.date),
                  ),
                  Text(
                    transaction.type == Type.Transfer
                        ? AccountManager.findAccById(transaction.acc2Id).name
                        : TransactionCategoryManager.getCategoryFromId(transaction.category).name,
                    style: TextStyle(color: Colors.black38),
                  ),
                ],
              ),
            ),
            const Gap(70),
            Column(
              children: [
                Text(
                  AccountManager.findAccById(transaction.accId).name,
                  style: TextStyle(color: Colors.black38),
                ),
                Text(transaction.note),
              ],
            ),
            const Spacer(),
            Text(
              transaction.amount.toString() + '\$',
              style: TextStyle(
                  color: (transaction.type == Type.Income)
                      ? Colors.blue
                      : (transaction.type == Type.Expense)
                          ? Colors.red
                          : Colors.black54),
            ),
          ]),
        ),
      ),
    );
  }
}
