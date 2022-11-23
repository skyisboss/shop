import 'package:shopkeeper/common/db/index.dart';
import 'package:sqflite/sqflite.dart';

// 欠款记录表
class ArrearDao extends DbProvider {
  /// 表名
  final String _tableName = 'arrears';

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
      amount REAL not null default 0, -- 欠款金额
      remark text, -- 欠款说明
      is_repaid INTEGER not null default 0, -- 是否已还款 0-否 1-是
      repaid_at INTEGER, -- 还款时间
      create_at INTEGER -- 添加时间
      )
    ''';
  }
}
