import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/product/data/export.dart';

import 'product_controller.dart';

class EditProductController extends GetxController {
  final productController = Get.find<ProductController>();
  final titleController = TextEditingController();
  final barcodeController = TextEditingController();
  final priceController = TextEditingController();
  final costController = TextEditingController();
  final stockController = TextEditingController();
  final isInfinityController = TextEditingController();

  /// 编辑/新增 产品
  final Rx<ProductEntity> _productInfo = ProductEntity(title: '').obs;
  ProductEntity get productInfo => _productInfo.value;

  /// 所属分类的名称
  final _currCategoryName = ''.obs;
  get currCategoryName => _currCategoryName.value;

  /// 获取所属分类
  setCategoryName(int id) {
    _productInfo.value.categoryId = id;
    var categoryList = productController.categoryState.categoryList;
    for (var item in categoryList) {
      if (item.id == id) {
        _currCategoryName.value = item.name;
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();
    setCategoryName(1);
  }

  @override
  void onClose() {}
}
