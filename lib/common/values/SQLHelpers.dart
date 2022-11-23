import 'package:sqflite/sqflite.dart';

final String tableNew = 'news';
final String columnId = '_Id';
final String columnTitle = 'title';
final String columnDet = 'detailed';

class News {
  late int id;
  late String title;
  late String detailed;

  // 将数据转换为键值对
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title.toString(),
      columnDet: detailed.toString(),
    };
    map[columnId] = id;
    return map;
  }

  News();

  //将数据转换为类
  News.fromMap(Map<dynamic, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    detailed = map[detailed];
  }
}

class NewsProvider {
  late Database? db;

  Future<Database?> get database async {
    if (db != null) {
      return db;
    }
    db = await open('person.db');
    return db;
  }

  /***
   * 打开数据库并创建表格
   */
  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table $tableNew(
        $columnId integer primary key autoincrement,
        $columnTitle text not null,
        $columnDet text not null)
      ''');
    });
  }

  /***
   * 插入数据
   */
  Future<News> insert(News news) async {
    news.id = await db!.insert(tableNew, news.toMap());
    return news;
  }

  /***
   * 根据ID获取数据
   */
  Future<News?> getNews(int id) async {
    List<Map> maps = await db!.query(
      tableNew,
      columns: [columnId, columnTitle, columnDet],
      where: '$columnId=?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return News.fromMap(maps.first);
    }
    return null;
  }

  /***
   * 根据ID删除数据
   */
  Future<int> delete(int id) async {
    return await db!.delete(tableNew, where: '$columnId=?', whereArgs: [id]);
  }

  /***
   * 根据ID更新数据
   */
  Future<int> update(News news) async {
    return await db!.update(tableNew, news.toMap(),
        where: '$columnId=?', whereArgs: [news.id]);
  }

  Future close() async => db!.close(); //关闭数据库
}
