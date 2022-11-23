import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/common/style/colors.dart';
import 'package:shopkeeper/common/values/index.dart';

List<BottomNavigationBarItem> buildBottomNavigationBarItem() {
  const _tabs = [
    {
      'label': '首页',
      'icon2': 'assets/images/home/shopping-bag-3-fill.png',
      'icon': 'assets/images/home/shopping-bag-3-line.png',
    },
    {
      'label': '店铺',
      'icon2': 'assets/images/home/store-3-fill.png',
      'icon': 'assets/images/home/store-3-line.png',
    },
    {
      'label': '我的',
      'icon2': 'assets/images/home/chat-smile-3-fill.png',
      'icon': 'assets/images/home/chat-smile-3-line.png',
    },
  ];

  return List.generate(_tabs.length, (index) {
    var item = _tabs[index];
    return BottomNavigationBarItem(
      icon: Image.asset(item['icon2'] as String,
          width: 25, color: Colors.grey.shade400),
      activeIcon: Image.asset(item['icon2'] as String,
          width: 25, color: MyColors.primaryColor),
      label: item['label'] as String,
    );
  });
}

/// 底部导航条
Widget buildBottomNavigationBar() {
  return BottomNavigationBar(
    onTap: (index) {
      if (index != CommonStore.to.navIndex.value) {
        CommonStore.to.navIndex.value = index;
        Get.offAllNamed(CommonStore.navItems[index]["page"]);
      }
    },
    currentIndex: CommonStore.to.navIndex.value,
    elevation: 3,
    selectedFontSize: 12.0,
    selectedItemColor: MyColors.primaryColor,
    unselectedItemColor: Colors.grey.shade400,
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    items: buildBottomNavigationBarItem(),
  );
}
