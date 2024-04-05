import 'package:uuid/uuid.dart';

var uuid = const Uuid();

enum Type { Income, Expense, Transfer }

class Trans {
  Trans(
      {required this.note,
      required this.amount,
      required this.date,
      required this.category,
      required this.accId,
      required this.type})
      : id = uuid.v4();

  Trans.old({
    required this.note,
    required this.amount,
    required this.date,
    required this.category,
    required this.accId,
    required this.type,
    required this.id,
  });
   String note;
   double amount;
   DateTime date;
  final String id;
   String category;
   String accId;
   Type type;
  String acc2Id = '';
}
