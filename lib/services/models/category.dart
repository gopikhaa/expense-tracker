import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Category {
  Category({required this.name}) : id = uuid.v4();

  Category.old({required this.name, required this.id});
  Category.empty()
      : name = '',
        id = '';
  String name;
  final String id;
}
