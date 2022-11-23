import 'package:shopkeeper/common/db/index.dart';
import 'package:sqflite/sqflite.dart';

import '../models/shop_model.dart';

class ShopDao extends DbProvider {
  /// 表名
  final String name = 'shop';

  /// 表主键
  final String columnId = 'id';

  @override
  tableName() {
    return name;
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
      key text not null,
      value text)
    ''';
  }

  // 插入
  Future<int> insert(ShopModel data) async {
    Database db = await getDatabase();
    return await db.insert(name, data.toJson());
  }

  // 编辑
  Future<int> update(String key, data) async {
    Database db = await getDatabase();
    return await db
        .update(name, data.toJson(), where: "key = ?", whereArgs: [key]);
  }

  // 删除
  Future<int> remove(String key) async {
    Database db = await getDatabase();
    return await db.delete(name, where: "key = ?", whereArgs: [key]);
  }

  // 查询
  Future<List?> find(String key) async {
    Database db = await getDatabase();
    final List<Map<String, Object?>> maps =
        await db.query(name, where: 'key = ?', whereArgs: [key]);
    if (maps.isNotEmpty) {
      return maps.map((item) => ShopModel.fromJson(item)).toList();
    }
    return null;
  }

  // 获取数据
  Future<List<ShopModel>> findAll() async {
    Database db = await getDatabase();
    List<Map<String, Object?>> maps = await db.query(name);
    List<ShopModel> msgs =
        maps.map((item) => ShopModel.fromJson(item)).toList();
    return msgs;
  }
}
