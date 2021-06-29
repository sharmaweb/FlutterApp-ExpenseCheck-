import 'package:flutter/material.dart';

class Transaction {
  final String id;
  //the final keyword means tha it can be assigned to a value only once during runtime
  final String name;
  final double amount;
  final DateTime date;
  Transaction({@required this.amount,
  @required this.date,
  @required this.id, 
  @required this.name});
}
