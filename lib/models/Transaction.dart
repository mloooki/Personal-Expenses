import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Transaction {
  String id;
  //int idDatabase;
  String title;
  double amount;
  DateTime date;
  Icon icon;

  Transaction(
    @required this.id,
    //@required this.idDatabase,
    @required this.title,
    @required this.amount,
    @required this.date,
    @required this.icon,
  );

  Map<String, dynamic> toMap() {
    //var map = <String, dynamic>{
    //'id': id,
    //'title': title,
    //'amount': amount,
    // 'date': date,
    // };
    return {
      'id': id,
      //'idDatabase': idDatabase,
      'title': title,
      'amount': amount,
      'date': date
    };
  }

  Transaction.fromMap(Map<String, dynamic> map) {
    //return Transaction object from map.
    id = map['id'];
    title = map['title'];
    amount = map['amount'];
    date = map['date'];
  }
}
