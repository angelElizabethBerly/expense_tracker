import 'dart:developer';

import 'package:expense_tracker/model/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreenController {
  static late Database database;
  static List<Map<String, Object?>> data = [];
  static List<TransactionModel> transactionList = [];

  //to initalise database
  static Future<void> initDb() async {
    // open the database
    database = await openDatabase('sample.db', version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Record (id INTEGER PRIMARY KEY, type TEXT, title TEXT, category TEXT, date TEXT, amount INTEGER)');
      // 'CREATE TABLE Transaction (id INTEGER PRIMARY KEY, type TEXT, title TEXT, category TEXT, date TEXT, amount INTEGER)');
      log('message');
    });
  }

  static Future addData() async {
    await database.rawInsert(
        'INSERT INTO Record(type, title, category, date, amount) VALUES(?, ?, ?, ?, ?)',
        ['Income', 'A1 food', 'food', 'tuesday', 1234]);
  }

  //get all data from database
  static Future getAllData() async {
    data = await database.rawQuery('SELECT * FROM Record');
    transactionList = data
        .map((e) => TransactionModel(
            id: int.parse(e["id"].toString()),
            transactionType: e['type'].toString(),
            title: e['title'].toString(),
            category: e['category'].toString(),
            date: e['date'].toString(),
            amount: int.parse(e["amount"].toString())))
        .toList();
    log(data.toString());
  }
}
