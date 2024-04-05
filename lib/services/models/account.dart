import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Account {
  Account({required this.name, required this.amount}) : id = uuid.v4();
  Account.old({required this.name, required this.amount, required this.id});
  Account.empty()
      : name = '',
        amount = 0,
        id = '';
  String name;
  double amount;
  final String id;
}
