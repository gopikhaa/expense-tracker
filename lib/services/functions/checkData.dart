import 'package:expense_tracker/services/models/account.dart';
import 'package:expense_tracker/network/repo/repo.dart';

class CheckData {
  CheckData(
      {required this.amount, required this.account, required this.category});
  final String amount;
  final Account account;
  final String category;
  bool checkDataTrans() {
    final enteredAmount = double.tryParse(amount);
    final bool checkAmount = enteredAmount == null || enteredAmount <= 0;
    if (checkAmount || account.id == '' || category == '') {
      return false;
    }
    return true;
  }

  bool checkDataTransfer(Account acc2) {
    if (checkDataTrans == false || acc2.id == '') {
      return false;
    }
    return true;
  }
}
