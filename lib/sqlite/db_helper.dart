import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:/path_provider/path_provider.dart';
import '../models/Transaction.dart' as tx;
import 'package:path/path.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String TITLE = 'title';
  static const String AMOUNT = 'amount';
  static const String DATE = 'date';
  static const String TABLE = 'Transaction';
  static const String DB_NAME = 'transaction.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<tx.Transaction> save(tx.Transaction tran) async {
    var dbClient = await db;
    //tran.idDatabase = await dbClient.insert(TABLE, tran.toMap());
    return tran;
  }

  Future<List<tx.Transaction>> getTransactions() async {
    var dbClient = await db;
    List<Map> maps =
        await dbClient.query(TABLE, columns: [ID, TITLE, AMOUNT, DATE]);
    List<tx.Transaction> txs = [];
    if (txs.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        txs.add(tx.Transaction.fromMap(maps[i]));
      }
    }
    return txs;
  }

  Future<int> delete(String id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(tx.Transaction tx) async {
    var dbClient = await db;
    return await dbClient
        .update(TABLE, tx.toMap(), where: '$ID = ?', whereArgs: [tx.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID TEXT PRIMARY KEY , $TITLE TEXT, $AMOUNT REAL, $DATE DATE)");
  }
}
