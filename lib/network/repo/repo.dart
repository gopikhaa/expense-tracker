import 'dart:convert';
import 'package:expense_tracker/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchExchangeRates() async {
  var box = GetStorage();
  var selectedCurrency = box.read("currency");
  if (selectedCurrency.toString() == "null") {
    selectedCurrency = "INR";
  }
  final response = await http.get(Uri.parse(
      "https://v6.exchangerate-api.com/v6/d6ea76fecbd99ddbbcecb351/latest/${selectedCurrency}"));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    print('exchangerate Rate: ${data["conversion_rates"]}');
    print('currencyValues: ${currencyValues}');

    currencyValues = {};
    currencyValues.clear();
    currencyValues = data["conversion_rates"];

    print('currencyValues: ${currencyValues}');
    
    currencyValues.forEach((key, value) {

      if (key.contains(selectedCurrency)) {
        currencyValues[selectedCurrency] = double.parse(value.toString());
        print('${selectedCurrency} value:${currencyValues[selectedCurrency]}');
      }
      
    });

    return json.decode(response.body);
  } else {
    throw Exception('Failed to load exchange rates');
  }
}
