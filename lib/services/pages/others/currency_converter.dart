import 'package:expense_tracker/services/functions/account_manager.dart';
import 'package:expense_tracker/network/repo/repo.dart';
import 'package:expense_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String currentCurrency = '';
  double _inputValue = 0.0;
  String _fromCurrency = '';
  String _toCurrency = '';

  var box = GetStorage();

  @override
  void initState() {
    box = GetStorage();
    currentCurrency = box.read("currency") ?? "INR";
    _fromCurrency = box.read("currency") ?? "INR";
    _toCurrency = box.read("to_currency") ?? "INR";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Icon(
                  Icons.currency_exchange_sharp,
                  color: Color.fromARGB(255, 6, 41, 154),
                  size: 60,
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Color.fromARGB(255, 6, 41, 154),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(currentCurrency,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    )),
                                Text("Default Currency",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Text('Convert To :',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                          DropdownButton<String>(
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white,
                            ),
                            iconSize: 40,
                            dropdownColor: Colors.indigoAccent,
                            value: _toCurrency,
                            onChanged: (String? newValue) {
                              fetchExchangeRates();
                              setState(() {
                                _toCurrency = newValue!;
                                box.write("to_currency", _toCurrency);
                              });
                            },
                            items: currencyValues.keys
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
