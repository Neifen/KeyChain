import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      // Set the path to the database.
      join(await getDatabasesPath(), 'key_chain_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE keys(id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, receptionDateTime TEXT)',
        );
      },
      // Set the version.
      version: 1,
    );
  }
}
