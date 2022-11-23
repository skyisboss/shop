import 'package:shopkeeper/common/db/index.dart';
import 'package:sqflite/sqflite.dart';

import '../../export.dart';

// 资金记录表
class FundsDao extends DbProvider {
  /// 表名
  final String _tableName = 'funds';

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
      amount REAL not null default 0, -- 数额
      type INTEGER not null default 0, -- 类型 0-收入 1-支出 2-欠款
      wallet_id INTEGER not null, -- 钱包id 
      remark text, -- 备注 
      file text, -- 照片文件 
      create_at INTEGER not null -- 日期时间戳 
      )
    ''';
  }

  // 插入
  Future<int> insert(FundsEntity data) async {
    Database db = await getDatabase();
    return await db.insert(_tableName, data.toJson());
  }

  // 编辑
  Future<int> update(int id, FundsEntity data) async {
    Database db = await getDatabase();
    return await db
        .update(_tableName, data.toJson(), where: "id = ?", whereArgs: [id]);
  }

  // 删除
  Future<int> remove(int id) async {
    Database db = await getDatabase();
    return await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<List<FundsEntity>> findAll() async {
    Database db = await getDatabase();
    List<Map<String, Object?>> maps = await db.query(_tableName);
    List<FundsEntity> msgs =
        maps.map((item) => FundsEntity.fromJson(item)).toList();
    return msgs;
  }

  // 查询资金（收入、支出、欠款）统计预览信息
  Future<List> finalTotal({required int type}) async {
    Database db = await getDatabase();
    String sqlStr = '''
      select 
      COUNT(id)  AS total,
      SUM(amount) AS amount
      FROM funds
      WHERE type = $type
      ;
    ''';
    var maps = await db.rawQuery(sqlStr);
    return maps;
  }

  // 查询资金明细详情
  Future<List<FundsEntity>> findDetail({
    required int wid,
    int? type,
    List? time,
  }) async {
    Database db = await getDatabase();
    var _type = type == null ? '' : 'AND type = $type';
    var _time =
        time == null ? '' : 'AND create_at BETWEEN ${time[0]} AND ${time[1]}';
    String sqlStr = 'select * FROM funds WHERE wallet_id=$wid $_type $_time;';
    var maps = await db.rawQuery(sqlStr);
    return maps.map((item) => FundsEntity.fromJson(item)).toList();
  }
}
