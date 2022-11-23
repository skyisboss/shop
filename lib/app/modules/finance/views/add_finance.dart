import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/finance/controllers/finance_controller.dart';
import 'package:shopkeeper/common/style/colors.dart';
import 'package:shopkeeper/widgets/index.dart';

class AddFinance extends GetView<FinanceController> {
  const AddFinance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        appBar: MyAppBar(
          title: '新增记录',
          actions: [
            MyAppBar.useActionButton(onTap: () {
              controller.fundsState.onDone();
            }),
          ],
        ),
        body: GetX<FinanceController>(
          init: controller,
          initState: (_) async {
            // 初始化钱包列表
            await controller.fundsState.initData();
          },
          builder: (_) {
            return SingleChildScrollView(
              // padding: const EdgeInsets.only(top: 16),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    buildList(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  buildSelectWalletsPopup() {
    var fundsState = controller.fundsState;
    buildGetxBottomSheet(
      title: Text('钱包账户'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: ListTile.divideTiles(
            context: Get.context!,
            tiles: fundsState.getWalletList().map((element) {
              bool isActive = fundsState.walletId == element.id;
              return ListTile(
                onTap: () {
                  fundsState.walletId = element.id;
                  fundsState.addData.refresh();
                  Get.back();
                },
                title: Row(
                  children: [
                    Text(
                      element.name!,
                      style: isActive
                          ? TextStyle(color: Colors.blue)
                          : TextStyle(),
                    ),
                    SizedBox(width: 8),
                    isActive
                        ? Icon(
                            Icons.check,
                            color: Colors.blue,
                          )
                        : SizedBox()
                  ],
                ),
              );
            }),
          ).toList(),
        ),
      ),
    );
  }

  buildRadio(String title, {int? value}) {
    var fundsState = controller.fundsState;
    handleType(value) {
      fundsState.type = value;
      fundsState.addData.refresh();
    }

    return InkWell(
      onTap: () => handleType(value),
      child: Row(children: [
        Transform.scale(
          scale: 0.9,
          child: Radio(
            value: value ?? 0,
            groupValue: fundsState.type,
            onChanged: (value) => handleType(value),
            activeColor: MyColors.primaryColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Text(title),
        ),
        SizedBox(width: 6)
      ]),
    );
  }

  Widget buildList() {
    var fundsState = controller.fundsState;

    return Column(
      children: [
        ListTileGroup(
            // customerTitle: SizedBox(),
            showBorder: false,
            children: [
              TextFieldItem(
                title: '记录金额',
                controller: TextEditingController(
                  text:
                      fundsState.amount > 0 ? fundsState.amount.toString() : '',
                ),
                keyboardType: TextInputType.number,
                onChanged: (e) => fundsState.amount = e.isEmpty ? '0' : e,
              ),
              ClickTileItem(
                title: '记录类型',
                customer: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    buildRadio('收入', value: 0),
                    SizedBox(width: 16),
                    buildRadio('支出', value: 1),
                    SizedBox(width: 16),
                    buildRadio('欠款', value: 2),
                    SizedBox(width: 16)
                  ],
                ),
              ),
              ClickTileItem(
                title: '钱包账户',
                content: fundsState.getWalletTitle(),
                onTap: buildSelectWalletsPopup,
              ),
              TextFieldItem(
                title: '备注',
                maxLines: 3,
                controller: TextEditingController(text: fundsState.remark),
                onChanged: (e) => fundsState.remark = e,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyImagePicker(
                      siveDirName: 'funds',
                      url: fundsState.file,
                      onPicker: (e) => fundsState.file = e,
                      onRemove: (e) =>
                          fundsState.addData.update((val) => val!.file = ''),
                    ),
                  ],
                ),
              ),
            ]),
      ],
    );
  }
}
