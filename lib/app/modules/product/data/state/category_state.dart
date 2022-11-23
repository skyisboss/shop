import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/product/controllers/product_controller.dart';
import 'package:shopkeeper/app/modules/product/data/export.dart';
import 'package:shopkeeper/common/state/base_state.dart';
import 'package:shopkeeper/widgets/index.dart';

class CategoryState extends StateBase {
  final dao = CategoryDao();
  final RxList<CategoryEntity> _categoryList = <CategoryEntity>[].obs;
  RxList<CategoryEntity> get categoryList => _categoryList;

  // 当前选中的栏目
  final _activeCategoryId = 0.obs;
  int get activeCategoryId => _activeCategoryId.value;
  set activeCategoryId(val) => _activeCategoryId.value = val;

  String getCategoryNameById(int categoryId) {
    var index = categoryList.indexWhere((e) => e.id == categoryId);
    return categoryList[index].name;
  }

  /// 设置选中栏目
  void setActiveCategory(int id) async {
    // 监听选中的栏目以便查询对应栏目下的产品
    activeCategoryId = id;
    List<int> _cids = [];
    if (id == 1) {
      for (var item in categoryList) {
        _cids.add(item.id as int);
      }
    } else {
      _cids.add(id);
    }
    print('cids = $_cids');

    /// 设置选中的栏目id，即：根据栏目id查询对应所属的产品列表
    Get.find<ProductController>().productState.getData(cids: _cids);
  }

  /// 新增/编辑栏目
  handleUpdate(CategoryEntity? data) async {
    final _textController = TextEditingController(text: data?.name ?? '');

    final inputContent = Material(
      color: Colors.transparent,
      child: Container(
        height: 55,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          controller: _textController,
          maxLength: 30,
          decoration: InputDecoration(
            hintText: '输入分类名称',
            hintStyle: TextStyle(fontSize: 13),
            filled: true,
            fillColor: Colors.grey.shade300,
            contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
      ),
    );

    void onConfirm() async {
      int result;
      String msg;
      CategoryEntity _newData = CategoryEntity(name: _textController.text);
      if (data == null) {
        result = await dao.insert(_newData);
        msg = '添加成功';
      } else {
        result = await dao.update(data.id!, _newData);
        msg = '编辑成功';
      }
      if (result > 0) {
        initData();
        EasyLoading.showSuccess(msg);
      }
    }

    cupertinoDialog(
      Get.context as BuildContext,
      title: Text(data == null ? '新增分类' : '编辑分类'),
      content: inputContent,
      onConfirm: () => _textController.text.isEmpty ? null : onConfirm(),
    );
  }

  /// 删除栏目
  handleDelete(int id) {
    final isCheck = false.obs;
    void onConfirm() async {
      if (id == 1) return;
      var result = await dao.remove(id);
      if (result > 0) {
        EasyLoading.showSuccess('删除成功');
        initData();
      }
    }

    cupertinoDialog(
      Get.context as BuildContext,
      title: Text('确定删除此分类吗?'),
      content: Obx(
        () => CheckboxListTile(
          activeColor: Colors.red,
          value: isCheck.value,
          onChanged: (value) => isCheck.value = value!,
          title: Text(
            '同时删除分类产品?',
            style: TextStyle(
              color: isCheck.value ? Colors.red : Colors.grey,
            ),
          ),
        ),
      ),
      onConfirm: () => onConfirm(),
    );
  }

  // TODO:: 删除栏目时判断是否勾选同时删除内容，该栏目下存在内容，需先将内容转移至默认分类（id=1）.如果勾选
  delete(int id, bool deleteContent) async {
    if (id == 1) return;
    var result = await dao.remove(id);
    if (result > 0) {
      EasyLoading.showSuccess('删除成功');
      initData();
    }
  }

  add(String categoryName) async {
    var result = await dao.insert(CategoryEntity(name: categoryName));
    if (result > 0) {
      EasyLoading.showSuccess('编辑成功');
      var res = await dao.find(result);
      if (res.isNotEmpty) {
        categoryList.add(res[0]);
        categoryList.refresh();
      }
    }
  }

  edit(int id, String name) async {
    var result = await dao.update(id, CategoryEntity(name: name));
    if (result > 0) {
      EasyLoading.showSuccess('编辑成功');
      // 更新列表
      for (var item in categoryList) {
        if (item.id == id) {
          item.name = name;
          categoryList.refresh();
          break;
        }
      }
    }
  }

  @override
  initData() async {
    // 如果表不存在则插入默认数据
    if (false == await dao.isTableExits()) {
      await dao.insert(CategoryEntity(name: 'all', sort: 0));
    }

    var result = await dao.findAll();
    categoryList.assignAll(result);
    categoryList.refresh();
  }
}
