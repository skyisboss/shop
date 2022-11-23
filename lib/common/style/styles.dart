import 'package:flutter/material.dart';
import './colors.dart';

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
      color: MyColors.primaryColor,
      width: 1,
    ),
  );
}
