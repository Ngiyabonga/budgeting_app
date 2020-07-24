import 'package:flutter/foundation.dart';

class BudgetTransaction{
  String id;
  String title;
  double amount;
  DateTime date;

  BudgetTransaction({@required this.id, @required this.title, @required this.amount, @required this.date});

}