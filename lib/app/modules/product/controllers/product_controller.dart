import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/product/data/export.dart';

class ProductController extends GetxController {
  final categoryState = CategoryState();
  final productState = ProductState();
  late final addProductState = ProductAddState();

  // 侧边栏
  final _siderExpand = false.obs;
  bool get siderExpand => _siderExpand.value;
  set siderExpand(val) => _siderExpand.value = val;

  handleSideToggle() {
    _siderExpand.value = !_siderExpand.value;
  }

  /// 显示搜索结果
  final _showSearchView = false.obs;
  bool get showSearchView => _showSearchView.value;
  set showSearchView(val) => _showSearchView.value = val;

  @override
  void onInit() async {
    super.onInit();
    await categoryState.initData();
    await productState.initData();
    categoryState.setActiveCategory(1);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
