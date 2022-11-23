import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/product/controllers/product_controller.dart';
import 'package:shopkeeper/app/modules/product/data/export.dart';
import 'package:shopkeeper/common/state/base_state.dart';
import 'package:shopkeeper/widgets/index.dart';
import 'package:sqflite/sqflite.dart';

class ProductState extends StateBase {
  final dao = ProductDao();
  //产品列表
  final _productList = <ProductListEntity>[].obs;
  RxList<ProductListEntity> get productList => _productList;

  // 数据加载状态
  final _loadState = 'loading'.obs;
  set loadState(val) => _loadState.value = val;
  bool get loadDataWait => _loadState.value == 'loading';
  bool get loadDataEmpty => _loadState.value == 'empty';
  bool get loadDataDone => _loadState.value == 'done';

  /// 搜索结果
  final _searchList = <ProductListEntity>[].obs;
  RxList<ProductListEntity> get searchList => _searchList;

  @override
  initData() async {
    if (false == await dao.isTableExits()) {
      // 初始化数据库
      await dao.getDatabase();
      print('初始化数据库 ProductDao');
      // 插入模拟数据
      // var categorys = Get.find<ProductController>().categoryState.categoryList;
      // for (var item in categorys) {
      //   print(item.id);
      //   for (var i = 0; i < 20; i++) {
      //     var title = '测试产品No.$i CID=${item.id}';
      //     var result = await dao
      //         .insert(ProductEntity(categoryId: item.id as int, title: title));

      //     print('插入数据 $result CID=${item.id}');
      //   }
      // }
    }
  }

  /// 获取数据
  void getData({required List<int> cids}) async {
    loadState = 'loading';
    var _cid = cids.join(','); // => [1,2,3]
    var sql =
        'SELECT * FROM products WHERE category_id IN ($_cid) ORDER BY `id` DESC;';
    Database db = await dao.getDatabase();
    var res = await db.rawQuery(sql);
    var _maps = res.map((item) => ProductEntity.fromJson(item));

    /**
    转换成此种形式
    <ProductList>[
      {
        categoryId: 1,
        productList: <ProductEntity>[],
      },
      ...
    ]
     */
    var _tmp = <ProductListEntity>[];
    for (var cid in cids) {
      var productMap = ProductListEntity(
        categoryId: cid,
        productList: [],
      );
      for (var product in _maps) {
        if (product.categoryId == cid) {
          productMap.productList.add(product);
        }
      }
      _tmp.add(productMap);
    }
    _productList.assignAll(_tmp);
    _productList.refresh();
    loadState = _productList[0].productList.isEmpty ? 'empty' : 'done';
  }

  /// 询问是否删除
  handleDelete(int productId) {
    onConfirm() async {
      var result = await dao.remove(productId);
      if (result > 0) {
        // 从数据库删除成功后更新列表数据
        var categoryState = Get.find<ProductController>().categoryState;
        categoryState.setActiveCategory(categoryState.activeCategoryId);
        EasyLoading.showSuccess('删除成功');
        Get.back();
      }
    }

    cupertinoDialog(
      Get.context as BuildContext,
      title: Text('确定删除该产品吗?'),
      onConfirm: () => onConfirm(),
    );
  }

  /// 搜索
  void searchData(String keywords) async {
    loadState = 'loading';
    var res = await dao.search(keywords);
    var searchMap = ProductListEntity(
      categoryId: 0,
      productList: res,
    );
    _searchList.clear();
    _searchList.add(searchMap);
    // searchList.refresh();
    print(res);
    _productList.assignAll(_searchList);
    _productList.refresh();

    loadState = _productList[0].productList.isEmpty ? 'empty' : 'done';
  }
}
