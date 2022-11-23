import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './colors.dart';

class MyTheme {
  static const horizontalMargin = 16.0;
  static const radius = 10.0;

  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: MyColors.primaryBackground,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: MyColors.primaryColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,

      /// 背景色
      backgroundColor: MyColors.primaryColor,

      /// 前景色
      foregroundColor: Colors.white,

      /// 透明状态栏
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: Colors.transparent,
      // ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,

      iconTheme: IconThemeData(
        color: MyColors.primaryText,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      toolbarTextStyle: TextStyle(
        color: MyColors.primaryText,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
