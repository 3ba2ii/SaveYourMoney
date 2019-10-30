import 'package:flutter/foundation.dart';
class Transaction {
  String id;
  String title;
  double price;
  DateTime date;

  Transaction({
    @required this.date,
    @required this.id,
    @required this.price,
    @required this.title,
  });
}
