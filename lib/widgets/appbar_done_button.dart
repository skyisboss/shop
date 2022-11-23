import 'package:flutter/material.dart';
import 'package:shopkeeper/common/style/colors.dart';

Widget appBarDoneButton(title, {Function()? onTap}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
    child: TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: MyColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );
}
