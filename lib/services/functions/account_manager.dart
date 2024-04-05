import 'package:expense_tracker/services/models/account.dart';

class AccountManager {
  static List<Account> accounts = [];

  static void addAccount(Account acc) {
    accounts.add(acc);
  }

  static void removeAccount(Account acc) {
    accounts.remove(acc);
  }

  static double getAssets() {
    double assets = 0;
    for (var acc in accounts) {
      if (acc.amount >= 0) {
        assets += acc.amount;
      }
    }
    return assets;
  }

  static double getTotal() {
    double total = 0;
    for (var acc in accounts) {
      total += acc.amount;
    }

    return total;
  }

  static double getDebt() {
    double debt = 0;
    for (var acc in accounts) {
      if (acc.amount < 0) {
        debt += acc.amount;
      }
    }
    return debt;
  }

  static Account findAccById(String id) {
    for (var acc in accounts) {
      if (acc.id == id) {
        return acc;
      }
    }
    return Account.empty();
  }
}
