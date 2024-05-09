import 'package:expense_tracker/network/repo/repo.dart';
import 'package:expense_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class InformationStat extends StatefulWidget {
  const InformationStat({Key? key, required this.dataMap, required this.colors})
      : super(key: key);

  final Map<String, double> dataMap;
  final List<Color> colors;

  @override
  State<InformationStat> createState() => _InformationStatState();
}

class _InformationStatState extends State<InformationStat> {
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
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: widget.dataMap.entries.toList().asMap().entries.map((entry) {
          final int index = entry.key;
          final MapEntry<String, double> dataEntry = entry.value;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dataEntry.key,
                  style: TextStyle(
                    color: widget.colors[index],
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${(dataEntry.value * currencyValues[toCurrency]).toStringAsFixed(2)} ${toCurrency}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: widget.colors[index],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
