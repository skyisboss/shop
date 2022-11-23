import 'package:shopkeeper/common/db/index.dart';
import 'package:sqflite/sqflite.dart';

import '../../export.dart';

// 欠款记录表
class WalletDao extends DbProvider {
  /// 表名
  final String _tableName = 'wallets';

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
      name text not null, -- 钱包名称
      logo text -- 钱包图标
      )
    ''';
  }

  // 插入
  Future<int> insert(WalletEntity data) async {
    Database db = await getDatabase();
    return await db.insert(_tableName, data.toJson());
  }

  // 编辑
  Future<int> update(int id, WalletEntity data) async {
    Database db = await getDatabase();
    return await db
        .update(_tableName, data.toJson(), where: "id = ?", whereArgs: [id]);
  }

  // 删除
  Future<int> remove(int id) async {
    Database db = await getDatabase();
    return await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<List<WalletEntity>> findAll() async {
    Database db = await getDatabase();
    List<Map<String, Object?>> maps = await db.query(_tableName);
    List<WalletEntity> msgs =
        maps.map((item) => WalletEntity.fromJson(item)).toList();
    return msgs;
  }

  // 查找钱包对应的资金记录
  Future<List<WalletFundsEntity>> findFunds() async {
    Database db = await getDatabase();
    String sqlStr = '''
      select 
      w.id,
      w.name,
      w.logo,
      (SELECT COUNT(id) FROM funds WHERE funds.wallet_id=w.id) AS times_count,
      (SELECT SUM(amount) FROM funds WHERE funds.id=w.id) AS amount_count
      FROM wallets AS w;
    ''';
    var maps = await db.rawQuery(sqlStr);
    return maps.map((x) => WalletFundsEntity.fromJson(x)).toList();
  }
}
