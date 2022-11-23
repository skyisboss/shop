import 'package:shopkeeper/common/db/index.dart';
import 'package:sqflite/sqflite.dart';

import '../../export.dart';

// 用户组
class GroupDao extends DbProvider {
  /// 表名
  final String _tableName = 'groups';

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
      group_name text not null, -- 组名称
      group_discount REAL not null -- 优惠比例
      )
    ''';
  }

  // 插入
  Future<int> insert(GroupEntity data) async {
    Database db = await getDatabase();
    return await db.insert(_tableName, data.toJson());
  }

  // 查询单个
  Future<List<GroupEntity>> findOne(String where, List whereArgs) async {
    Database db = await getDatabase();

    List? maps = await db.query(_tableName, where: where, whereArgs: whereArgs);
    if (maps.isNotEmpty) {
      return maps.map((item) => GroupEntity.fromJson(item)).toList();
    }
    return <GroupEntity>[];
  }

  Future<List<GroupEntity>> findAll() async {
    Database db = await getDatabase();
    var maps = await db.query(_tableName);
    List<GroupEntity> msgs =
        maps.map((item) => GroupEntity.fromJson(item)).toList();
    return msgs;
  }
}
