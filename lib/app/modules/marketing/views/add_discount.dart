import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/app/modules/marketing/controllers/marketing_controller.dart';
import 'package:shopkeeper/widgets/index.dart';

class AddDiscount extends GetView<MarketingController> {
  AddDiscount({
    Key? key,
    this.id,
    required this.type,
  }) : super(key: key);

  final int? id;
  final int type;

  @override
  Widget build(BuildContext context) {
    String actionType = id == null ? '新增' : '编辑';
    String pageType = controller.listState.tabs[type];

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MyAppBar(
          title: actionType + pageType,
          actions: [
            MyAppBar.useActionButton(
              onTap: () => controller.addState.onDone(id),
            ),
          ],
        ),
        body: GetX<MarketingController>(
          init: MarketingController(),
          initState: (_) {
            controller.addState.initData(id, type);
          },
          builder: (_) {
            return SingleChildScrollView(
              // padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildBaseInfo(),
                  SizedBox(height: 24),
                  buildConditionUse(),
                  SizedBox(height: 32),
                  id == null
                      ? SizedBox()
                      : Container(
                          margin: const EdgeInsets.all(50),
                          child: MyButton(
                            text: '删除',
                            backgroundColor: Colors.red.shade300,
                            onPressed: () => controller.addState.onDelete(id!),
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  buildBaseInfo() {
    var addState = controller.addState;
    String pageType = controller.listState.tabs[type];
    // 折扣金额的类型
    return ListTileGroup(
      customerTitle: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          '基本信息',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      children: [
        TextFieldItem(
          title: '$pageType名称',
          controller: addState.titleController,
          focusNode: addState.titleFocusNode,
          onChanged: (e) => addState.title = e,
        ),
        Row(
          children: [
            Expanded(
              child: TextFieldItem(
                title: '$pageType金额',
                keyboardType: TextInputType.number,
                controller: addState.discountAmountController,
                focusNode: addState.discountAmountFocusNode,
                onChanged: (e) => addState.discountAmount = e,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: DropdownButton(
                onChanged: (value) {
                  addState.addDataUpdate.update((state) {
                    for (var i = 0; i < addState.discountTextList.length; i++) {
                      if (addState.discountTextList[i] == value) {
                        state!.amountType = i;
                        break;
                      }
                    }
                  });
                },
                underline: SizedBox(),
                value: addState.amountTypeText,
                items: addState.discountTextList.map((e) {
                  final _active = addState.amountTypeText == e;
                  return DropdownMenuItem(
                    value: e,
                    child: Row(
                      children: [
                        Text(e),
                        _active
                            ? Padding(
                                padding: const EdgeInsets.only(left: 5, top: 3),
                                child: CircleAvatar(
                                  radius: 3,
                                  backgroundColor: Colors.red,
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        ClickTileItem(
          title: '过期时间',
          content: controller.addState.expiredDateFormat,
          onTap: () => controller.addState.datePicker(),
        ),
      ],
    );
  }

  buildConditionUse() {
    var addState = controller.addState;
    return ListTileGroup(
      customerTitle: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          '使用条件',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      children: [
        Row(
          children: [
            Expanded(
              child: TextFieldItem(
                title: '最小金额',
                hintText: '最小金额',
                keyboardType: TextInputType.number,
                controller: addState.minAmountController,
                focusNode: addState.minAmountFocusNode,
                onChanged: (e) => addState.minAmount = e,
              ),
            ),
            Expanded(
              child: TextFieldItem(
                title: '最大金额',
                hintText: '最大金额',
                keyboardType: TextInputType.number,
                controller: addState.maxAmountController,
                focusNode: addState.maxAmountFocusNode,
                onChanged: (e) => addState.maxAmount = e,
              ),
            ),
          ],
        ),
        TextFieldItem(
          title: '发行数量',
          keyboardType: TextInputType.number,
          controller: addState.totalNumController,
          focusNode: addState.totalNumFocusNode,
          onChanged: (e) => addState.totalNum = e,
        ),
      ],
    );
  }
}
