import 'package:shopkeeper/app/modules/marketing/data/export.dart';
import 'package:shopkeeper/common/db/index.dart';
import 'package:sqflite/sqflite.dart';

class DiscountDao extends DbProvider {
  /// 表名
  final String _tableName = 'discounts';

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
      type INTEGER not null, -- 类型 0-折扣 1-优惠卷
      title text not null, -- 标题
      discount_amount REAL not null, -- 折扣金额
      amount_type INTEGER not null, -- 折扣类型 0-面值 1-百分比
      expired_date INTEGER not null, -- 有效期时间戳
      min_amount REAL not null, -- 最小金额
      max_amount REAL not null, -- 最大金额
      total_num INTEGER not null -- 发行数量
      )
    ''';
  }

  // 插入
  Future<int> insert(DiscountEntity data) async {
    Database db = await getDatabase();
    return await db.insert(_tableName, data.toJson());
  }

  // 编辑
  Future<int> update(int id, DiscountEntity data) async {
    Database db = await getDatabase();
    return await db
        .update(_tableName, data.toJson(), where: "id = ?", whereArgs: [id]);
  }

  // 删除
  Future<int> remove(int id) async {
    Database db = await getDatabase();
    return await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }

  // 查询单个
  Future<List<DiscountEntity>> findOne(String where, List whereArgs) async {
    Database db = await getDatabase();

    List? maps = await db.query(_tableName, where: where, whereArgs: whereArgs);
    if (maps.isNotEmpty) {
      return maps.map((item) => DiscountEntity.fromJson(item)).toList();
    }
    return <DiscountEntity>[];
  }

  // 获取数据 page = 1,limit = 50 表示第1页： 从第0个开始，获取50条数据
  // selete * from testtable limit 0, 50;
  // selete * from testtable limit 50 offset 0;
  Future<List<DiscountEntity>> findAll({
    String? where,
    List? whereArgs,
    page = 1,
    limit = 50,
  }) async {
    Database db = await getDatabase();
    var maps = await db.query(
      _tableName,
      where: where,
      whereArgs: whereArgs,
      limit: limit,
      offset: limit == null ? null : (page - 1) * limit,
      orderBy: 'id desc',
    );
    List<DiscountEntity> msgs =
        maps.map((item) => DiscountEntity.fromJson(item)).toList();
    return msgs;
  }
}
