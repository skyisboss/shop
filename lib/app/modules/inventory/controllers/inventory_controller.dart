import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/inventory/data/index.dart';

class InventoryController extends GetxController {
  final categoryState = CategoryState();
  final productState = ProductState();

  /// 是否展开左侧栏目
  final _siderExpand = false.obs;
  bool get siderExpand => _siderExpand.value;
  set siderExpand(val) => _siderExpand.value = val;

  // 搜索相关
  TextEditingController searchInputController = TextEditingController();
  final keywords = ''.obs;
  final isFoucs = false.obs;
  final isSearch = false.obs;
  handleSearch() async {
    if (searchInputController.text == '') {
      handleCancelSearch();
    } else {
      await productState.search(searchInputController.text);
      isSearch.value = true;
    }
  }

  handleFoucs(val) => isFoucs.value = val;
  handleCancelSearch() {
    isSearch.value = false;
    keywords.value = '';
    searchInputController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void onInit() async {
    // 初始化数据库
    await categoryState.initData();
    await productState.initData();
    // 设置默认选中的栏目id=1
    categoryState.setActiveCategoryId(1);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    print('close');
  }
}
