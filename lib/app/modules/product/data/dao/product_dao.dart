import 'package:shopkeeper/app/modules/product/data/export.dart';
import 'package:shopkeeper/common/db/index.dart';
import 'package:sqflite/sqflite.dart';

class ProductDao extends DbProvider {
  /// 表名
  final String _tableName = 'products';

  /// 表主键
  final String _columnId = 'id';

  @override
  tableName() {
    return _tableName;
  }

  @override
  tableSqlString() {
    return tableBaseString(_tableName, _columnId) +
        '''
      title text not null, -- 产品名称
      image text, -- 产品图片
      color text, -- 颜色描述
      barcode text, -- 产品条码
      description text, -- 产品描述
      cost_price REAL, -- 成本价格
      sale_price REAL not null, -- 出售价格
      total_stock INTEGER not null, -- 库存数量
      is_infinity INTEGER not null, -- 是否无限库存 1-是 0-否 默认0
      category_id INTEGER not null, -- 所属分类
      sale_online INTEGER not null, -- 是否线上销售 1-是 0-否 默认0
      attribute text, -- 产品属性 json字符串形式
      criterion text, -- 产品规格 json字符串形式
      create_at INTEGER not null)
    ''';
  }

  // 搜索
  Future<List<ProductEntity>> search(String keywords) async {
    Database db = await getDatabase();
    List? maps = await db.query(
      _tableName,
      where: "title LIKE ? OR barcode Like?",
      whereArgs: ['%$keywords%'],
    );
    if (maps.isNotEmpty) {
      return maps.map((item) => ProductEntity.fromJson(item)).toList();
    }
    return <ProductEntity>[];
  }

  // 插入
  Future<int> insert(ProductEntity data) async {
    Database db = await getDatabase();
    return await db.insert(_tableName, data.toJson());
  }

  // 编辑
  Future<int> update(int id, ProductEntity data) async {
    Database db = await getDatabase();
    return await db
        .update(_tableName, data.toJson(), where: "id = ?", whereArgs: [id]);
  }

  // 删除
  Future<int> remove(int id) async {
    Database db = await getDatabase();
    return await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }

  // 查询
  Future<List<ProductEntity>> find(String where, List whereArgs) async {
    Database db = await getDatabase();

    List? maps = await db.query(_tableName, where: where, whereArgs: whereArgs);
    if (maps.isNotEmpty) {
      return maps.map((item) => ProductEntity.fromJson(item)).toList();
    }
    return <ProductEntity>[];
  }

  // 获取数据 page = 1,limit = 50 表示第1页： 从第0个开始，获取50条数据
  // selete * from testtable limit 0, 50;
  // selete * from testtable limit 50 offset 0;
  Future<List<ProductEntity>> findAll(
    int categoryId, {
    page = 1,
    limit = 50,
  }) async {
    Database db = await getDatabase();
    List<Map<String, Object?>> maps = await db.query(
      _tableName,
      where: 'category_id = ?',
      whereArgs: [categoryId],
      limit: limit,
      offset: limit == null ? null : (page - 1) * limit,
    );
    List<ProductEntity> msgs =
        maps.map((item) => ProductEntity.fromJson(item)).toList();
    return msgs;
  }
}
