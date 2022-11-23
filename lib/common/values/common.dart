import 'package:flutter/material.dart';
// import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/routes/app_pages.dart';
// import 'package:myshop/common/router/values.dart';

class CommonStore extends GetxService {
  static CommonStore get to => Get.find();

  // 底部导航
  var navIndex = 0.obs;
  static List navItems = [
    {
      "label": "nav_home".tr,
      "icon": const Icon(Icons.home),
      "page": Routes.HOME
    },
    {
      "label": "nav_shop".tr,
      "icon": const Icon(Icons.store),
      "page": Routes.SHOP
    },
    {
      "label": "nav_mine".tr,
      "icon": const Icon(Icons.person),
      "page": Routes.MINE
    },
  ];

  // 蓝牙设备
  List deviceList = [].obs;
  // 连接列表
  List connectionList = [].obs;
  // 服务列表
  List serviceList = [].obs;

  Locale locale = const Locale('zh', 'CN');
  List<Locale> languages = const [
    Locale('zh', 'CN'),
    Locale('zh', 'HK'),
    Locale('en', 'US'),
  ];

  Future<CommonStore> init() async {
    return this;
  }
}
