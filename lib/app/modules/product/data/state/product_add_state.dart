import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/product/controllers/product_controller.dart';
import 'package:shopkeeper/app/modules/product/data/export.dart';

class ProductAddState {
  final dao = ProductDao();

  /// 编辑/新增 产品
  final Rx<ProductEntity> product = ProductEntity(title: '').obs;
  ProductEntity get productInfo => product.value;
  String get title => productInfo.title;
  String get color => productInfo.color ?? '';
  int get categoryId => productInfo.categoryId;
  String get image => productInfo.image ?? '';
  String get barcode => productInfo.barcode ?? '';
  String get description => productInfo.description ?? '';
  double get costPrice => productInfo.costPrice ?? 0;
  double get salePrice => productInfo.salePrice ?? 0;
  int get totalStock => productInfo.totalStock ?? 0;
  bool get isInfinity => productInfo.isInfinity == 1;
  bool get saleOnline => productInfo.saleOnline == 1;
  String get attribute => productInfo.attribute ?? '';

  final titleController = TextEditingController();
  final barcodeController = TextEditingController();
  final totalStockController = TextEditingController();
  final costPriceController = TextEditingController();
  final salePriceController = TextEditingController();
  final titleFocusNode = FocusNode();

  /// 获取栏目id对应的栏目名称
  final _categoryName = ''.obs;
  get categoryName => _categoryName.value;

  final loadData = false.obs;

  /// 选择栏目
  void setCategory(int id) {
    var categoryState = Get.find<ProductController>().categoryState;
    for (var item in categoryState.categoryList) {
      if (item.id == id) {
        _categoryName.value = item.name;
        product.value.categoryId = id;
        product.refresh();
        break;
      }
    }
  }

  /// 初始化数据
  void initData(int? productId) async {
    loadData.value = false;
    product.value = ProductEntity(title: '');
    if (productId == null) {
      productId = 1;
    } else {
      var result = await dao.find('id = ?', [productId]);
      for (var item in result) {
        product.value = item;
      }
    }
    setCategory(productId);
    titleController.text = product.value.title;
    barcodeController.text = product.value.barcode ?? '';
    if (product.value.totalStock! > 0) {
      totalStockController.text = product.value.totalStock.toString();
    }
    if (product.value.costPrice! > 0) {
      costPriceController.text = product.value.costPrice.toString();
    }
    if (product.value.salePrice! > 0) {
      salePriceController.text = product.value.salePrice.toString();
    }

    product.refresh();
    loadData.value = true;
  }

  handleAdd(int? productId) async {
    if (product.value.title.isEmpty) {
      titleFocusNode.requestFocus();
      EasyLoading.showError('请输入名称');
      return;
    }
    if (productId == null) {
      // 新增
      var result = await dao.insert(product.value);
      if (result > 0) {
        EasyLoading.showSuccess('添加成功');
        // Get.back();
        // return;
      }
    } else {
      print(product.value.image);
      //编辑
      var result = await dao.update(productId, product.value);
      if (result > 0) {
        EasyLoading.showSuccess('编辑成功');
        // Get.back();
        // return;
      }
    }
    // 从数据库删除成功后更新列表数据
    var categoryState = Get.find<ProductController>().categoryState;
    categoryState.setActiveCategory(categoryState.activeCategoryId);
    Get.back();
  }

  handleDelete(int productId) async {
    var result = await dao.remove(productId);
    if (result > 0) {
      EasyLoading.showSuccess('删除成功');
      return;
    }
  }
}
