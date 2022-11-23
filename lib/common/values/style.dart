import 'package:flutter/material.dart';

class MyColor {
  /// 主背景 白色
  static const Color primaryBackground = Colors.white;

  /// 主灰色
  static const Color greyColor = Color(0xffbbbbbb);

  /// 主紫色
  static const Color primaryColor = Color(0xFF2851e4); //Color(0xFF6643E2);

  /// 浅紫色
  static const Color secondColor = Color(0xFF2851e4); //Color(0xFF8080FF);

  /// 首页顶部卡颜色
  static const Color recBackground = secondColor;

  /// 导航条选中
  static const Color selectedColor = primaryColor;

  /// 导航条未选中
  static const Color unselectedColor = Color(0xffbfbfbf);
}

class MyStyle {
  /// 蓝色渐变描边
  static BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    boxShadow: [
      BoxShadow(
          color: Color(0x805793FA), offset: Offset(0.0, 2.0), blurRadius: 8.0),
    ],
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF5758FA), Color(0xFF5793FA)],
    ),
  );

  /// 未选购商品灰色描边
  static BoxDecoration defaultGoodsBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    border: Border.all(
      color: Colors.grey.shade200,
      width: 1,
    ),
  );

  /// 未选购商品灰色描边
  static BoxDecoration selectedGoodsBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    border: Border.all(
      color: MyColor.primaryColor,
      width: 1,
    ),
  );
}
