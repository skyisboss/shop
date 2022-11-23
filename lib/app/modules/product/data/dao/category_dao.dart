import 'package:shopkeeper/app/modules/product/data/export.dart';
import 'package:shopkeeper/common/db/index.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDao extends DbProvider {
  /// 表名
  final String name = 'categories';

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
      name text not null, -- 栏目名称
      sort INTEGER not null)
    ''';
  }

  // 插入
  Future<int> insert(CategoryEntity data) async {
    Database db = await getDatabase();
    return await db.insert(name, data.toJson());
  }

  // 编辑
  Future<int> update(int id, CategoryEntity data) async {
    Database db = await getDatabase();
    return await db
        .update(name, data.toJson(), where: "id = ?", whereArgs: [id]);
  }

  // 删除
  Future<int> remove(int id) async {
    Database db = await getDatabase();
    return await db.delete(name, where: "id = ?", whereArgs: [id]);
  }

  // 查询
  Future<List<CategoryEntity>> find(int id) async {
    Database db = await getDatabase();
    List? maps = await db.query(name, where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return maps.map((item) => CategoryEntity.fromJson(item)).toList();
    }
    return <CategoryEntity>[];
  }

  // 获取数据
  Future<List<CategoryEntity>> findAll() async {
    Database db = await getDatabase();
    List<Map<String, Object?>> maps = await db.query(name);
    List<CategoryEntity> msgs =
        maps.map((item) => CategoryEntity.fromJson(item)).toList();
    return msgs;
  }
}
