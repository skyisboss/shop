import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/inventory/controllers/inventory_controller.dart';
import 'package:shopkeeper/widgets/index.dart';

Widget buildAppBarTitle() {
  var controller = Get.find<InventoryController>();
  final cancelButton = IconButton(
    onPressed: () => controller.handleCancelSearch(),
    icon: Icon(
      Icons.cancel,
      size: 18,
      color: Colors.red.shade400,
    ),
  );
  final scanButton = IconButton(
    onPressed: () async {
      var result = await Get.to(() => QrScanView());

      EasyLoading.show(
        status: '扫描成功',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
        indicator: Icon(
          Icons.check_circle,
          size: 36,
          color: Colors.white,
        ),
      );
      Timer.periodic(Duration(seconds: 1), (t) {
        EasyLoading.dismiss();
        t.cancel();
      });
    },
    icon: Image.asset('assets/images/common/qr-scan-2-line.png'),
  );

  return SizedBox(
    height: 32,
    child: Obx(
      () => Focus(
        onFocusChange: (e) => controller.handleFoucs(e),
        child: TextField(
          controller: controller.searchInputController,
          textInputAction: TextInputAction.search,
          onChanged: (value) => controller.keywords.value = value,
          onSubmitted: (_) => controller.handleSearch(), // 点击搜索按钮
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade300,
            contentPadding: EdgeInsets.fromLTRB(14, 10, 32, 0),
            hintText: '搜索内容',
            hintStyle: TextStyle(fontSize: 13),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            suffixIcon:
                controller.keywords.value.isNotEmpty || controller.isFoucs.value
                    ? cancelButton
                    : scanButton,
          ),
        ),
      ),
    ),
  );
}
