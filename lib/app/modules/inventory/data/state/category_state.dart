import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/inventory/controllers/inventory_controller.dart';
import 'package:shopkeeper/app/modules/inventory/data/index.dart';

class CategoryState {
  /// 当前选中的栏目id
  final _activeCategoryId = 0.obs;

  /// 获取当前选中的栏目id
  int get activeCategoryId => _activeCategoryId.value;
  set activeCategoryId(val) => _activeCategoryId.value = val;

  /// 设置选中的栏目id高亮
  void setActiveCategoryId(int categoryId) async {
    /// 避免重复选中
    // if (categoryId == activeCategoryId) {
    //   return;
    // }

    activeCategoryId = categoryId;

    /// 设置选中的栏目id，即：根据栏目id查询对应所属的产品列表
    await Get.find<InventoryController>().productState.findAll(categoryId);
  }

  /// 栏目数据
  final RxList<CategoryEntity> _category = <CategoryEntity>[].obs;

  /// 获取栏目
  RxList<CategoryEntity> get category => _category;
  // set category(val) => {_category.assignAll(val), category.refresh()};

  /// 新增栏目
  void add(categoryName) async {
    CategoryDao dao = CategoryDao();
    var result = await dao.insert(CategoryEntity(name: categoryName));
    if (result > 0) {
      EasyLoading.showSuccess('编辑成功');
      var res = await dao.find(result);
      category.add(res[0]);
      category.refresh();
    }
  }

  /// 编辑栏目
  void edit({required int id, required String name}) async {
    // print('id=$id, name=$name');
    CategoryDao dao = CategoryDao();
    var result = await dao.update(id, CategoryEntity(name: name));
    if (result > 0) {
      EasyLoading.showSuccess('编辑成功');
      // 更新列表
      for (var item in category) {
        if (item.id == id) {
          item.name = name;
          category.refresh();
          break;
        }
      }
    }
  }

  /// 删除栏目
  void delete(int id) async {
    if (id == 1) return;
    CategoryDao dao = CategoryDao();
    var result = await dao.remove(id);
    if (result > 0) {
      EasyLoading.showSuccess('删除成功');
      // 更新列表
      for (var i = 0; i < category.length; i++) {
        if (category[i].id == id) {
          category.removeAt(i);
          category.refresh();
          break;
        }
      }
    }
  }

  /// 获取栏目
  Future<List<CategoryEntity>> find({int? id}) async {
    CategoryDao dao = CategoryDao();
    if (id == null) {
      return await dao.findAll();
    }
    return await dao.find(id);
  }

  /// 初始化数据
  initData() async {
    //获取数据
    CategoryDao dao = CategoryDao();
    // 如果表不存在则插入默认数据
    if (false == await dao.isTableExits()) {
      await dao.insert(CategoryEntity(name: 'all', sort: 0));
    }
    var result = await find();
    category.assignAll(result);
    category.refresh();
  }
}
