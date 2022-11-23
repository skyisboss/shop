import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../export.dart';

class ListState {
  // 查询分页
  final _page = 1.obs;

  /// 下拉刷新控制器
  final refreshController = RefreshController();

  // 客户统计
  final _customerTotal = ''.obs;
  String get customerTotal => _customerTotal.value;

  // 最新客户
  final _customerLast = ''.obs;
  String get customerLast => _customerLast.value;

  // 客户数据列表
  final _customerList = <CustomerListEntity>[].obs;
  RxList<CustomerListEntity> get customerList => _customerList;

  onRefresh() async {
    await initData();
    refreshController.refreshCompleted();
    refreshController.resetNoData();
  }

  onLoading() async {
    var result = await initData(page: _page.value + 1);
    _page.value += 1;
    if (result.isEmpty) {
      refreshController.loadNoData();
    } else {
      refreshController.loadComplete();
    }
  }

  Future<List> initData({page = 1}) async {
    CustomerDao dao = CustomerDao();
    // 获取客户统计
    var info = await dao.findOverviewInfo();
    _customerTotal.value = info['customer_total'].toString();
    _customerLast.value = info['customer_last'] ?? '';

    // 获取客户列表
    var _list = await dao.findAll(page: page);
    if (page == 1) {
      _customerList.clear();
      _customerList.addAll(_list);
    } else {
      for (var item in _list) {
        _customerList.add(item);
      }
      _customerList.refresh();
    }

    return _list;
  }
}
