import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/routes/app_pages.dart';

class HomeController extends GetxController {
  // 信息概览
  final List overviewList = [
    {
      "title": '今日订单',
      "image": 'xdd',
      'content': '88',
    },
    {
      "title": '今日成交',
      "image": 'jrjye',
      'content': '88',
    },
    {
      "title": '待付订单',
      "image": '781720',
      'content': '88',
    },
  ];

  // 教程提示
  final String tutorialText = '欢迎使用店管家销售系统';

  // 功能导航
  final List<Map> actionList = [
    {
      "label": "home.shopping".tr,
      "icon": Icons.local_mall_rounded,
      'link': Routes.POS
    },
    {
      "label": "home.inventory".tr,
      "icon": Icons.auto_awesome_motion_rounded,
      'link': Routes.PRODUCT
    },
    // {
    //   "label": "home.inventory".tr,
    //   "icon": Icons.auto_awesome_motion_rounded,
    //   'link': Routes.INVENTORY
    // },
    {
      "label": "home.marketing".tr,
      "icon": Icons.style_rounded,
      'link': Routes.MARKETING
    },
    {
      "label": "home.report".tr,
      "icon": Icons.pie_chart_rounded,
      'link': Routes.REPORT
    },
    {
      "label": "home.finance".tr,
      "icon": Icons.savings_rounded,
      'link': Routes.FINANCE
    },
    {
      "label": "home.customer".tr,
      "icon": Icons.person_pin_rounded,
      'link': Routes.CUSTOMER
    },
    // {"label": "产品", "icon": Icons.person_pin_rounded, 'link': Routes.PRODUCT},
    // {"label": "home.tutorial".tr, "icon": Icons.info},
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
