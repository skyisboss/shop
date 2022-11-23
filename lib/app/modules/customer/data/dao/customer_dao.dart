import 'package:shopkeeper/app/modules/customer/export.dart';
import 'package:shopkeeper/common/db/index.dart';
import 'package:sqflite/sqflite.dart';

class CustomerDao extends DbProvider {
  /// 表名
  final String _tableName = 'customers';

  /// 表主键
  final String _columnId = 'id';

  @override
  tableName() {
    return _tableName;
  }

  @override
  tableSqlString() {
    // spend_count REAL, -- 消费金额
    // arrear_count REAL, -- 欠款金额
    // times_count INTEGER, -- 消费次数
    // point_count INTEGER, -- 积分总数
    return tableBaseString(_tableName, _columnId) +
        '''
      username text not null, -- 会员名
      avatar text, -- 头像
      telephone text, -- 电话
      group_id INTEGER not null default 1, -- 用户组
      point_count INTEGER default 0, -- 积分总数
      gender INTEGER default 0, -- 性别 0-保密 1-男 2-女
      address text, -- 地址
      birthday text, -- 生日
      remark text, -- 备注
      recent_spend text, -- 最近消费
      create_at INTEGER -- 添加时间
      )
    ''';
  }

  // 插入
  Future<int> insert(CustomerEntity data) async {
    Database db = await getDatabase();
    return await db.insert(_tableName, data.toJson());
  }

  // 编辑
  Future<int> update(int id, CustomerEntity data) async {
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
  Future<List<CustomerEntity>> findOne(String where, List whereArgs) async {
    Database db = await getDatabase();

    List? maps = await db.query(_tableName, where: where, whereArgs: whereArgs);
    if (maps.isNotEmpty) {
      return maps.map((item) => CustomerEntity.fromJson(item)).toList();
    }
    return <CustomerEntity>[];
  }

  Future<List<CustomerListEntity>> findAll({page = 1, limit = 50}) async {
    Database db = await getDatabase();
    String sqlStr = '''
      SELECT 
      customers.id,
      customers.username,
      customers.group_id,
      customers.avatar,
      (SELECT COUNT(uid) FROM spends WHERE spends.uid=customers.id) AS times_count, 
      (SELECT SUM(amount) FROM spends WHERE spends.uid=customers.id) AS spend_count,
      (SELECT group_name FROM groups WHERE groups.id=customers.group_id) AS group_name
      FROM customers
      ORDER BY id desc 
      limit ${(page - 1) * limit}, $limit;
  ''';
    var maps = await db.rawQuery(sqlStr);
    return maps.map((item) => CustomerListEntity.fromJson(item)).toList();
  }

  Future findOverviewInfo() async {
    Database db = await getDatabase();
    var total =
        await db.rawQuery('SELECT COUNT(id) AS customer_total FROM customers;');
    var last = await db.rawQuery(
        'SELECT username AS customer_last , create_at FROM customers ORDER BY id desc LIMIT 1;');
    if (total.isEmpty) {
      total = [
        {'customer_total': 0}
      ];
    }
    if (last.isEmpty) {
      last = [
        {'customer_last': '', 'create_at': ''}
      ];
    }
    return {...total[0], ...last[0]};
  }
}
