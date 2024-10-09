import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dbclass {
  Database? database;
  Future<bool> createdb() async {
    try {
      database =
          await openDatabase(join("${await getDatabasesPath()}exp_tracked.db"),
              onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE User (id TEXT PRIMARY KEY, expense INT, target INT)");
        await db.execute(
            "CREATE TABLE Categories (name TEXT, id INT AUTOINCREAMENT)");
        await db.execute(
            "CREATE TABLE Expense (date_time TEXT PRIMARY KEY, title TEXT,userId TEXT, category INT, amount INT, source TEXT, FOREIGN KEY (userId) REFERENCES User(id) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (category) REFERENCES Categories(id) ON DELETE CASCADE ON UPDATE CASCADE )");
        await db.execute(
            "CREATE TABLE Income (date_time TEXT PRIMARY KEY, title TEXT, userId TEXT, category INT, source TEXT, amount INT, FOREIGN KEY(userId) REFERENCES User(id), FOREIGN KEY(category) REFERENCES Categories(id))");
        // await db.execute(
        //     "CREATE TABLE Loan (date_time TEXT, title TEXT, borrower TEXT, due_date TEXT, amount INT, FOREIGN KEY(date_time) REFERENCES Income(date_time) ON DELETE CASCADE ON UPDATE CASCADE, PRIMARY KEY(date_time, borrower))");
        await db.execute(
            "CREATE TABLE Loan (date_time TEXT, title TEXT, borrower TEXT, due_date TEXT, amount INT, PRIMARY KEY(date_time, borrower))");
        // await db.execute(
        //     "CREATE TABLE Debt (date_time TEXT, title TEXT, lender TEXT, due_date TEXT, amount INT, FOREIGN KEY(date_time) REFERENCES Expense(date_time) ON DELETE CASCADE ON UPDATE CASCADE, PRIMARY KEY(date_time, lender))");
        await db.execute(
            "CREATE TABLE Debt (date_time TEXT, title TEXT, lender TEXT, due_date TEXT, amount INT, PRIMARY KEY(date_time, lender))");
        await db.execute(
            "INSERT INTO Categories(name, id) VALUES(\"Travel\",0), (\"Food\",1), (\"Stationary\",2), (\"Others\",3)");
        await db.insert("User", {"id": "007", "expense": 200, "target": 3000});
      }, version: 2);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}

Dbclass dbobj = Dbclass();
