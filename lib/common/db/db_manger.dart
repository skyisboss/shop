import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManger {
  /// 数据库版本
  static const _version = 1;

  /// 数据库名称
  static const _dbName = 'shopkeeper.db';

  /// 数据库实例
  static Database? _database;

  static init() async {
    _database = await openDatabase(
      // 使用join是最佳实践，确保在任意平台都能正确找到数据库路径
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) {
        // 数据库创建时是否建立表
        // return db.execute(
        //   'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        // );
      },
      version: _version,
    );
  }

  /// 获取实例
  static Future<Database?> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  /// 关闭数据库
  static close() {
    _database?.close();
    _database = null;
  }

  /// 判断表是否存在
  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    String sql =
        'SELECT name FROM sqlite_master WHERE type="table" AND name="$tableName"';
    var res = await _database?.rawQuery(sql);
    return res != null && res.isNotEmpty;
  }
}
