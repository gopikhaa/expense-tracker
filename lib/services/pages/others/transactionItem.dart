import 'package:expense_tracker/network/repo/repo.dart';
import 'package:expense_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/services/functions/account_manager.dart';
import 'package:expense_tracker/services/functions/transaction_category_manager.dart';
import 'package:expense_tracker/services/models/trans.dart';
import 'package:expense_tracker/services/pages/others/editExpensePage.dart';
import 'package:expense_tracker/services/pages/others/editIncomePage.dart';
import 'package:expense_tracker/services/pages/others/editTransferPage.dart';

class TransactionItem extends StatefulWidget {
  TransactionItem(
      {required this.transaction, required this.editTransaction, Key? key})
      : super(key: key);
  final Trans transaction;
  final Function editTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  final format = DateFormat('d/M/yy');
  var box = GetStorage();
  var fromCurrency = "";
  var toCurrency = "";
  double fromCurrencyVal = 0.0;
  @override
  void initState() {
    box = GetStorage();
    fromCurrency = box.read("currency") ?? "INR";
    toCurrency = box.read("to_currency") ?? "INR";

    print('fromCurrencyVal:${fromCurrencyVal}');
    print('toCurrency:${toCurrency}');
    print('fromCurrency:${fromCurrency}');

    fromCurrencyVal = currencyValues[fromCurrency];
    print('fromCurrencyVal:${fromCurrencyVal}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fromCurrencyVal = currencyValues[fromCurrency];
    print('fromCurrencyVal:${fromCurrencyVal}');
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.transaction.type == Type.Transfer
                ? EditTransferPage(
                    editTransfer: widget.editTransaction,
                    transfer: widget.transaction)
                : widget.transaction.type == Type.Income
                    ? EditIncomePage(
                        editTrans: widget.editTransaction,
                        tran: widget.transaction)
                    : EditExpensePage(
                        editTrans: widget.editTransaction,
                        tran: widget.transaction),
          ),
        );
      },
      child: Card(
        color: Color.fromARGB(255, 6, 41, 154),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(children: [
            Container(
              width: MediaQuery.of(context).size.width / 4,
              child: Column(
                children: [
                  Text(
                    format.format(
                      widget.transaction.date,
                    ),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    widget.transaction.type == Type.Transfer
                        ? AccountManager.findAccById(widget.transaction.acc2Id)
                            .name
                        : TransactionCategoryManager.getCategoryFromId(
                                widget.transaction.category)
                            .name,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            const Gap(70),
            Column(
              children: [
                Text(
                  AccountManager.findAccById(widget.transaction.accId).name,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  widget.transaction.note,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
            const Spacer(),
            Text(
              '${(widget.transaction.amount * currencyValues[toCurrency]).toStringAsFixed(2)} $toCurrency',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: (widget.transaction.type == Type.Income)
                      ? Colors.lightGreen
                      : (widget.transaction.type == Type.Expense)
                          ? Colors.red
                          : Colors.black54),
            ),
          ]),
        ),
      ),
    );
  }
}
