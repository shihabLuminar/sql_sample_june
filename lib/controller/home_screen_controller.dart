import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class HomeScreenController {
  static late Database myDatabase;
  static List<Map> employeeDataList = [];

  //----------------------------------------------------------

  static Future initDb() async {
    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
    }

    // open the database
    myDatabase = await openDatabase("emplyeeData.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Employees (id INTEGER PRIMARY KEY, name TEXT, designation TEXT)');
    });
  }
  //----------------------------------------------------------

  static Future addEmployee(
      {required String name, required String designation}) async {
    await myDatabase.rawInsert(
        'INSERT INTO Employees(name, designation) VALUES(?, ?)',
        [name, designation]);

    getAllEmployees();
  }
  //----------------------------------------------------------

  static Future getAllEmployees() async {
    // Get the records
    employeeDataList = await myDatabase.rawQuery('SELECT * FROM Employees');
    print(employeeDataList);
  }

  static Future removeEmployee(int id) async {
    await myDatabase.rawDelete('DELETE FROM Employees WHERE id = ?', [id]);
    getAllEmployees();
  }

  updateEmployee() {}
}
