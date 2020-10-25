import 'dart:async';

import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  static final String QUESTION_TABLE = 'Question';

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Database database = await openDatabase("stackoverflow_flutter.db",
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  // This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $QUESTION_TABLE ("
        "id INTEGER PRIMARY KEY, "
        "title TEXT, "
        "score INTEGER, "
        "body TEXT, "
        "owner_name TEXT "
        ")");
  }
}

