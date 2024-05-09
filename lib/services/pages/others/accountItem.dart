import 'package:expense_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/services/models/account.dart';
import 'package:get_storage/get_storage.dart';

class AccountItem extends StatefulWidget {
  AccountItem({
    Key? key,
    required this.acc,
  }) : super(key: key);

  final Account acc;

  @override
  State<AccountItem> createState() => _AccountItemState();
}

class _AccountItemState extends State<AccountItem> {
  var box = GetStorage();
  var fromCurrency = "";
  var toCurrency = "";
  double fromCurrencyVal = 0.0;
  @override
  void initState() {
    box = GetStorage();
    fromCurrency = box.read("currency") ?? "INR";
    toCurrency = box.read("to_currency") ?? "INR";

    fromCurrencyVal = currencyValues[fromCurrency];

    print('fromCurrencyVal:${fromCurrencyVal}');
    print('toCurrency:${toCurrency}');
    print('fromCurrency:${fromCurrency}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            widget.acc.name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '${(widget.acc.amount.abs() * currencyValues[toCurrency]).toStringAsFixed(2)} ${toCurrency}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: widget.acc.amount >= 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
