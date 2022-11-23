import 'package:get/get.dart';

class MineState {
  /// 权限控制
  final _authPages = [
    {
      'label': 'App启动',
      'page': '',
      'active': false.obs,
    },
    {
      'label': 'POS销售',
      'page': '',
      'active': false.obs,
    },
    {
      'label': '库存管理',
      'page': '',
      'active': false.obs,
    },
    {
      'label': '营销管理',
      'page': '',
      'active': false.obs,
    },
    {
      'label': '查看报表',
      'page': '',
      'active': false.obs,
    },
    {
      'label': '查看资金',
      'page': '',
      'active': false.obs,
    },
    {
      'label': '顾客管理',
      'page': '',
      'active': false.obs,
    },
    {
      'label': '编辑店铺',
      'page': '',
      'active': false.obs,
    },
  ];

  /// 权限控制
  List<Map<String, Object>> get authPages => _authPages;
}
