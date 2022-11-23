import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/product/data/export.dart';
import 'package:sqflite/sqflite.dart';

class PosState {
  // 分类列表
  final _categoryList = <CategoryEntity>[].obs;
  RxList<CategoryEntity> get categoryList => _categoryList;

  final _currCategoryId = 1.obs;
  set currCategoryId(val) => _currCategoryId.value = val;
  int get currCategoryId => _currCategoryId.value;
  String Function() get currCategoryText => () {
        String text = '';
        for (var item in categoryList) {
          if (item.id == currCategoryId) {
            text = item.name;
            break;
          }
        }
        return text;
      };

  // 产品列表
  final _productList = <ProductEntity>[].obs;
  RxList<ProductEntity> get productList => _productList;

  initData() {
    // 初始化栏目
    initCategory();
    // 初始化产品
    initGoods();
  }

  // 初始化产品
  initGoods() async {
    ProductDao dao = ProductDao();
    Database db = await dao.getDatabase();
    String sqlStr;
    if (currCategoryId == 1) {
      sqlStr = 'SELECT * FROM products ORDER BY `id` DESC;';
    } else {
      sqlStr =
          'SELECT * FROM products WHERE category_id IN ($currCategoryId) ORDER BY `id` DESC;';
    }
    var res = await db.rawQuery(sqlStr);
    var maps = res.map((item) => ProductEntity.fromJson(item));
    productList.clear();
    productList.addAll(maps);
    productList.refresh();
    print(maps.length);
  }

  // 初始化栏目
  initCategory() async {
    CategoryDao dao = CategoryDao();
    var result = await dao.findAll();
    categoryList.clear();
    categoryList.assignAll(result);
    categoryList.refresh();
  }
}
