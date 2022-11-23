import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../export.dart';

class ListPageState {
  /// tab标签
  final tabs = ['折扣', '优惠券'];

  /// 下拉刷新控制器
  final List<RefreshController> refreshController = [
    /// 折扣
    RefreshController(),

    /// 优惠劵
    RefreshController(),
  ];

  /// 数据列表
  final _listPageData = <List<DiscountEntity>>[
    /// 折扣
    <DiscountEntity>[],

    /// 优惠劵
    <DiscountEntity>[],
  ].obs;
  RxList<List<DiscountEntity>> get listPageData => _listPageData;

  /// 查询参数 分页
  List<int> queryPage = [1, 1];

  /// 下拉刷新
  void onRefresh(pageType) async {
    await loadListData(type: pageType, page: queryPage[pageType]);
    refreshController[pageType].refreshCompleted();
  }

  /// 上拉加载
  void onLoading(pageType) async {
    queryPage[pageType]++;
    var result = await loadListData(type: pageType, page: queryPage[pageType]);
    if (result.isEmpty) {
      refreshController[pageType].loadNoData();
    } else {
      refreshController[pageType].loadComplete();
    }
  }

  /// 加载数据
  /// `type 页面类型`
  /// `page 分页`
  Future<List> loadListData({int? type, int? page}) async {
    type = type ?? 0;
    page = page ?? 1;
    DiscountDao dao = DiscountDao();
    // 查询数据
    var result = await dao.findAll(
        where: 'type = ?', whereArgs: [type], page: page, limit: 10);
    // page=1 默认第一页，将结果全部赋值给_listPageData，否则追加数据列表数据
    if (page == 1) {
      _listPageData[type].clear();
      _listPageData[type].addAll(result);
    } else {
      for (var item in result) {
        _listPageData[type].add(item);
      }
    }
    _listPageData.refresh();
    return result;
  }
}
