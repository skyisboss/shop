import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './button_sheet.dart';

/// 收款金额
Widget buildReceiptAmount({required Widget title, required Widget amount}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Text(title, style: TextStyle(fontSize: 26)),
      title,
      SizedBox(height: 10),
      // Text(amount, style: TextStyle(fontSize: 26)),
      amount,
      SizedBox(height: 10),
    ],
  );
}

/// 功能按钮
Widget buildButtonItems() {
  /// 单个按钮
  _buildButton(
      {required Widget title, Function()? onTap, double? height = 44}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        child: title,
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      _buildButton(
        title: Text('现金支付'),
        onTap: () =>
            // buildCategoryList(),
            Get.bottomSheet(buildReceiptBottomSheet(),
                isScrollControlled: true),
      ),
      _buildButton(title: Text('电子支付'), onTap: () {}),
      _buildButton(title: Text('信用卡'), onTap: () {}),
      _buildButton(
        title: Text('组合支付'),
        onTap: () => Get.bottomSheet(buildMultipleBottomSheet(),
            isScrollControlled: true),
      ),
    ],
  );
}

Widget buildTextItems() {
  _buildTextButton({required Widget title, Function()? onTap}) => TextButton(
        onPressed: onTap,
        child: title,
      );
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildTextButton(
        onTap: () => Get.back(),
        title: Text('本单作废', style: TextStyle(color: Colors.red)),
      ),
      _buildTextButton(onTap: () => Get.back(), title: Text('稍后支付')),
    ],
  );
}
