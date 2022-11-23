import 'package:shopkeeper/common/db/index.dart';
import 'package:sqflite/sqflite.dart';

// 消费记录表
class SpendDao extends DbProvider {
  /// 表名
  final String _tableName = 'spends';

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
      uid text not null, -- 会员id
      amount REAL not null default 0, -- 消费金额
      order_id text, -- 消费订单
      create_at INTEGER -- 添加时间
      )
    ''';
  }
}
