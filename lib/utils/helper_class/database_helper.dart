import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();

  Database? db;

  // Initialize the database
  initDatabase() async {
    String rootPath = await getDatabasesPath();
    String path = join(rootPath, "calculator.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String query =
            "CREATE TABLE IF NOT EXISTS calculator (id INTEGER PRIMARY KEY AUTOINCREMENT,num1 INTEGER,num2 INTEGER,operation TEXT,result INTEGER);";
        await db.execute(query);
        log("Table created successfully.");
      },
    );
  }

  Future<int> insertIntoDatabase({
    required int num1,
    required int num2,
    required String operation,
    required int result,
  }) async {
    if (db == null) {
      await initDatabase();
    }

    // Insert the calculation into the database
    String query =
        "INSERT INTO calculator (num1, num2, operation, result ) VALUES (?, ?, ?, ?);";

    List args = [num1, num2, operation, result];
    int res = await db!.rawInsert(query, args);

    log("Inserted: num1=$num1, num2=$num2, operation=$operation, result=$result");

    return res;
  }

  // Delete a calculation from the history by id
  Future<int> deleteHistory({required int id}) async {
    if (db == null) {
      await initDatabase();
    }

    String query = "DELETE FROM calculator WHERE id = ?;";

    List args = [id];
    int res = await db!.rawDelete(query, args);

    log("Deleted record with id: $id");

    return res;
  }

  // Fetch all calculation history
  Future<List<Map<String, dynamic>>> fetchAllHistory() async {
    if (db == null) {
      await initDatabase();
    }

    String query = "SELECT * FROM calculator;";

    List<Map<String, dynamic>> allHistory = await db!.rawQuery(query);

    return allHistory;
  }
}
