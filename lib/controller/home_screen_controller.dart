import 'dart:developer';

import 'package:expense_tracker/model/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreenController {
  static late Database database;
  static List<Map<String, Object?>> data = [];
  static List<TransactionModel> transactionList = [];
  static int balanceAmount = 1000;
  static int totalIncome = 0;
  static int totalExpense = 0;

  //to initalise database
  static Future<void> initDb() async {
    // open the database
    database = await openDatabase('sample.db', version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Record (id INTEGER PRIMARY KEY, type TEXT, title TEXT, category TEXT, date TEXT, amount INTEGER)');
      log('table created');
    });
  }

  static Future addData(
      {required String type,
      required String title,
      required String category,
      required String date,
      required int amount}) async {
    await database.rawInsert(
        'INSERT INTO Record(type, title, category, date, amount) VALUES(?, ?, ?, ?, ?)',
        [type, title, category, date, amount]);

    calculate();
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
              amount: int.parse(e["amount"].toString()),
            ))
        .toList();
    log(data.toString());
    calculate();
  }

  static calculate() {
    balanceAmount = 1000;
    totalIncome = 0;
    totalExpense = 0;
    for (var i = 0; i < transactionList.length; i++) {
      if (transactionList[i].transactionType == "Income") {
        totalIncome = totalIncome + transactionList[i].amount;
      } else {
        totalExpense = totalExpense + transactionList[i].amount;
      }
    }
    balanceAmount = 1000 + totalIncome - totalExpense;
    log(balanceAmount.toString());
    log(balanceAmount.toString());
  }
}
