import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future buildGetxBottomSheet({
  Widget? title,
  required Widget body,
  bool showTitle = true,
  bool showClose = true,
  bool titleCenter = false,
  double height = 500,
  double radius = 10,
  bool isDismissible = true,
  bool isScrollControlled = false,
}) {
  return Get.bottomSheet(
    GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showTitle
                ? __buildBottomSheetHeader(
                    title: title ?? SizedBox(),
                    showClose: showClose,
                    titleCenter: titleCenter,
                  )
                : SizedBox(),
            __buildBottomSheetBody(body),
          ],
        ),
      ),
    ),
    isDismissible: isDismissible,
    isScrollControlled: isScrollControlled,
  );
}

/// 弹窗标题
Widget __buildBottomSheetHeader({
  required Widget title,
  bool showClose = true,
  bool titleCenter = false,
}) {
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.all(16),
        child: DefaultTextStyle(
          style: TextStyle(
              fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold),
          child: Row(
            mainAxisAlignment: titleCenter
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              title,
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            showClose
                ? InkWell(
                    onTap: () => Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(Icons.close),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    ],
  );
}

/// 弹窗主体
Widget __buildBottomSheetBody(Widget body) {
  return Expanded(
    child: SingleChildScrollView(
      child: body,
    ),
  );
}
