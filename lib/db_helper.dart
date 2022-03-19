// @dart=2.9
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/dept_model.dart';
import 'models/due_model.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database _db;

  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db;
    }
    //define the path to the database
    String path = join(await getDatabasesPath(), 'wallet.db');
    _db = await openDatabase(path, version: 2, onCreate: (Database db, int v) {
      //create all tables
      db.execute(
          "create table debts(id integer primary key autoincrement, name varchar(50), reason varchar(255), value integer ,date varchar(50))");

      db.execute(
          "create table dues(id integer primary key autoincrement, name varchar(50), reason varchar(255), value integer ,date varchar(50))");
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      if (oldVersion < newVersion) {
        await db.execute('alter table dues add column day varchar(50)');
      }
    });

    return _db;
  }

  Future<int> addDebt(Debt debt) async {
    Database db = await createDatabase();
    //db.rawInsert('insert into courses')
    return db.insert('debts', debt.toMap());
  }

  Future<int> addDue(Due due) async {
    Database db = await createDatabase();
    //db.rawInsert('insert into courses')
    return db.insert('dues', due.toMap());
  }

  Future<List> allDebts() async {
    Database db = await createDatabase();
    //db.rawQuery("select * from courses")
    return db.query('debts');
  }

  Future<List> allDues() async {
    Database db = await createDatabase();
    //db.rawQuery("select * from courses")
    return db.query('dues');
  }

  Future<int> deleteDebt(int id) async {
    Database db = await createDatabase();
    return await db.delete('debts', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteDue(int id) async {
    Database db = await createDatabase();
    return await db.delete('dues', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateDue(Due due) async {
    Database db = await createDatabase();
    return await db
        .update('dues', due.toMap(), where: 'id = ?', whereArgs: [due.id]);
  }

  Future<int> updateDebt(Debt debt) async {
    Database db = await createDatabase();
    return await db
        .update('debts', debt.toMap(), where: 'id = ?', whereArgs: [debt.id]);
  }

  calculateTotalDebts() async {
    Database db = await createDatabase();
    var totalDebt = await db.rawQuery("SELECT SUM(value) as total FROM debts");
    if (totalDebt == null)
      return 0;
    else
      return totalDebt;
  }

  calculateTotalDues() async {
    Database db = await createDatabase();
    var totalDues = await db.rawQuery("SELECT SUM(value) as total FROM dues");
    if (totalDues == null)
      return 0;
    else
      return totalDues;
  }

  calTotal() async {
    Database db = await createDatabase();
    int dues = (await await calculateTotalDues())[0]["total"] ?? 0;
    int debts = (await calculateTotalDebts())[0]["total"] ?? 0;

    int total = dues - debts;
    if (total == null)
      return 0;
    else
      return total;
  }
}
