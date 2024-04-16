import 'dart:developer';

import 'package:expense_tracker/model/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreenController {
  static late Database database;
  static List<Map<String, Object?>> data = [];
  static List<TransactionModel> transactionList = [];
  static int balanceAmount = 0;
  static int totalIncome = 0;
  static int totalExpense = 0;

  //to initalise database
  static Future<void> initDb() async {
    // open the database
    database = await openDatabase('sample.db', version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Record (id INTEGER PRIMARY KEY, type TEXT, title TEXT, category TEXT, date TEXT, amount INTEGER, totalBalance INTEGER, totalIncome INTEGER, totalExpense INTEGER)');
      log('table created');
    });
  }

  static Future addData(
      {required String type,
      required String title,
      required String category,
      required String date,
      required int amount}) async {
    if (type == "Income") {
      totalIncome = totalIncome + amount;
    } else {
      totalExpense = totalExpense + amount;
    }

    balanceAmount = totalIncome - totalExpense;

    await database.rawInsert(
        'INSERT INTO Record(type, title, category, date, amount, totalBalance, totalIncome, totalExpense) VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
        [
          type,
          title,
          category,
          date,
          amount,
          balanceAmount,
          totalIncome,
          totalExpense
        ]);

    // if (type == "Income") {
    //   totalIncome = totalIncome + amount;
    //   await database.rawInsert(
    //       'INSERT INTO Record(totalIncome) VALUES(?)', [totalIncome]);
    // } else {
    //   totalIncome = totalIncome - amount;
    // }
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
            balanceAmount: int.parse(e['totalBalance'].toString()),
            totalIncome: int.parse(e['totalIncome'].toString()),
            totalExpense: int.parse(e['totalExpense'].toString())))
        .toList();
    log(data.toString());
  }

  static addIncome() {
    for (int i = 0; i < transactionList.length; i++) {
      totalIncome = totalIncome + transactionList[i].amount;
      log(totalIncome.toString());
    }
  }

  static addExpense() {
    for (int i = 0; i < transactionList.length; i++) {
      totalExpense = totalExpense + transactionList[i].amount;
      log(totalExpense.toString());
    }
  }
}
