import 'package:expense_tracker/network/repo/repo.dart';
import 'package:expense_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:expense_tracker/network/fire_store.dart';
import 'package:expense_tracker/services/functions/account_manager.dart';
import 'package:expense_tracker/services/models/account.dart';
import 'package:expense_tracker/services/pages/others/accountItem.dart';
import 'package:expense_tracker/services/pages/others/newAccount.dart';
import 'package:expense_tracker/services/pages/others/editAccount.dart';
import 'package:get_storage/get_storage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  void addAcc(Account acc) {
    setState(() {
      AccountManager.accounts.add(acc);
      FireStore().addAccountToFireStore(acc);
    });
  }

  void editAccount(var acc, var newName, double newAmount) {
    setState(() {
      acc.name = newName;
      acc.amount = newAmount;
      FireStore().editAccountToFireStore(acc, newName, newAmount);
    });
  }

  void removeAcc(Account acc) {
    setState(() {
      AccountManager.accounts.remove(acc);
      FireStore().removeAccountToFireStore(acc);
    });
  }

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
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'Add') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewAccount(
                      addAcc: addAcc,
                    ),
                  ),
                );
              } else if (value == 'Edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditAccount(
                      editAcc: editAccount,
                      removeAcc: removeAcc,
                    ),
                  ),
                );
              }
            },
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem(child: Text('Add'), value: 'Add'),
              PopupMenuItem(child: Text('Edit'), value: 'Edit'),
            ],
          ),
        ],
        title: Text('Accounts'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Color.fromARGB(255, 6, 41, 154),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Assets',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${(AccountManager.getAssets() * currencyValues[toCurrency]).toStringAsFixed(2)} ${toCurrency}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Debt',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${(AccountManager.getDebt().abs() * currencyValues[toCurrency]).toStringAsFixed(2)} ${toCurrency}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${(AccountManager.getTotal() * currencyValues[toCurrency]).toStringAsFixed(2)} ${toCurrency}',
                              style: TextStyle(
                                fontSize: 15,
                                color: AccountManager.getTotal() >= 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            const Gap(50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Color.fromARGB(255, 6, 41, 154),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: AccountManager.accounts
                      .map((acc) => AccountItem(acc: acc))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
