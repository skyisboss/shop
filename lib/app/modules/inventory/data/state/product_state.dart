import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/inventory/controllers/inventory_controller.dart';
import 'package:shopkeeper/app/modules/inventory/data/index.dart';

class ProductState {
  /// 数据库
  final dao = ProductDao();

  /// 产品数据
  final RxList<ProductEntity> _product = <ProductEntity>[].obs;

  /// 获取产品
  RxList<ProductEntity> get product => _product;

  /// 搜索结果数据
  final RxList<ProductEntity> _searchResult = <ProductEntity>[].obs;
  RxList<ProductEntity> get searchResult => _searchResult;

  search(String keywords) async {
    var res = await dao.search(keywords);
    searchResult.assignAll(res);
    searchResult.refresh();
  }

  /// 初始化数据
  initData() async {
    // for (var i = 0; i < 50; i++) {
    //   await dao.insert(ProductEntity(title: '测试产品 $i'));
    // }
    if (false == await dao.isTableExits()) {
      // 初始化数据库
      await dao.getDatabase();
      print('初始化数据库 ProductDao');
    }
  }

  findOne(String where, List whereArgs) async {
    return await dao.find(where, whereArgs);
  }

  findAll(int categoryId) async {
    var result = await dao.findAll(categoryId, limit: null);
    product.assignAll(result);
    product.refresh();
  }
}
