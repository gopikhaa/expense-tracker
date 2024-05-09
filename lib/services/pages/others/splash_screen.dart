import 'package:expense_tracker/auth/authPage.dart';
import 'package:expense_tracker/network/fire_store.dart';
import 'package:expense_tracker/network/repo/repo.dart';
import 'package:expense_tracker/utils/image_utils.dart';
import 'package:expense_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String currentCurrency = 'Select Default Currency';

  var box = GetStorage();

  @override
  void initState() {
    box = GetStorage();

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (box.read("default").toString() != "true" ||
          box.read("default").toString() == null ||
          box.read("default").toString() == "null") {
        showLCurrencyPopup(context);
      } else {
        Get.offAll(const AuthPage());
      }
      print(box.read("default").toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImageUtils().ic_logo),
      ),
    );
  }

  showLCurrencyPopup(
    BuildContext context,
  ) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        height: 80,
        width: 300,
        child: Center(
          child: Column(
            children: [
              DropdownButton<String>(
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color.fromARGB(255, 6, 41, 154),
                ),
                iconSize: 40,
                dropdownColor: Colors.indigoAccent,
                hint: Text(currentCurrency),
                onChanged: (String? newValue) {
                  fetchExchangeRates();
                  setState(() {
                    currentCurrency = newValue!;
                    box.write("currency", currentCurrency);
                    box.write("to_currency", currentCurrency);
                    box.write("default", true);
                  });
                  Get.offAll(const AuthPage());
                },
                items: currencyValues.keys
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 6, 41, 154),
                        )),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
