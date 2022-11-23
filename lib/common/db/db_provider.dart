import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'db_manger.dart';

abstract class DbProvider {
  bool tableExits = false;
  tableSqlString();
  tableName();

  tableBaseString(String name, String columnId) {
    return '''
      CREATE TABLE $name (
        $columnId INTEGER PRIMARY KEY autoincrement,
    ''';
  }

  Future<Database> getDatabase() async {
    return await open();
  }

  Future<bool> isTableExits() async {
    return await DBManger.isTableExits(tableName());
  }

  @mustCallSuper
  open() async {
    if (!tableExits) {
      await prepare(tableName(), tableSqlString());
    }
    return await DBManger.getCurrentDatabase();
  }

  @mustCallSuper
  prepare(String name, String createSql) async {
    tableExits = await isTableExits();
    // DBManger.isTableExits(name);
    if (!tableExits) {
      Database? db = await DBManger.getCurrentDatabase();
      return await db?.rawQuery(createSql);
    }
  }
}
