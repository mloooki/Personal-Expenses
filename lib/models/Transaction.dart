import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

/* class DBTransactionManager {
  Database _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), 'transaction.db'),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE transaction (id Text,idDatabase, INTERGER PRIMAREYKEY autoincrement, title TEXT, amount INTEGER, date DATE');
      });
    }
  }

  Future<List<Transaction>> getTrnsactionList() async {
    await openDb();
    final List<Map<String, dynamic>> maps =
        await _database.query('transaction');
    return List.generate(maps.length, (i) {
      return Transaction(
          id: maps[i]['id'],
          idDatabase: maps[i]['idDatabase'],
          title: maps[i]['title'],
          amount: maps[i]['amount'],
          date: maps[i]['date'],
          icon: _getCorrectIcon(maps[i]['title']));
    });
  }

  Future<int> updateTransaction(Transaction tx) async {
    await openDb();
    return await _database.update('transaction', tx.toMap(),
        where: "idDatabase = ?", whereArgs: [tx.idDatabase]);
  }

  Future<void> delteTransaction(int idDatabase) async {
    await openDb();
    return await _database.delete('transaction',
        where: "idDatabase = ?", whereArgs: [idDatabase]);
  }

  Icon _getCorrectIcon(String title) {
    switch (title) {
      case 'Groceries':
        return Icon(Icons.local_grocery_store);
      case 'Bills':
        return Icon(Icons.data_usage);
      case 'Cloting':
        return Icon(Icons.accessibility_new);
      case 'Transporation':
        return Icon(Icons.directions_car);
      case 'Other':
        return Icon(Icons.monetization_on);
    }
  }

  Future<int> insertTransaction(Transaction tx) async {
    await openDb();
    return await _database.insert('transaction', tx.toMap());
  }

  void test() {
    int d = 9;
  }
} */

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
