import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopkeeper/widgets/index.dart';

import '../../export.dart';

buildGroupSetting() {
  var addState = Get.find<CustomerController>().addState;
  buildGetxBottomSheet(
    showClose: false,
    isDismissible: false,
    isScrollControlled: true,
    height: MediaQuery.of(Get.context!).size.height / 1.5,
    title: Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '用户组管理',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          InkWell(
            child: Text(
              '完成',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              addState.groupList.refresh();
              Get.back();
            },
          )
          // OutlinedButton(onPressed: () {}, child: Text('保存修改'))
        ],
      ),
    ),
    body: Column(
      children: [
        Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: GroupSetting(),
        ),
      ],
    ),
  );
}

class GroupSetting extends GetView<CustomerController> {
  GroupSetting({Key? key}) : super(key: key);

  final groupCardItemList = [].obs;

  @override
  Widget build(BuildContext context) {
    // groupCardItemList.add(buildCardItem(groupCardItemList.length));

    return GetX<CustomerController>(
      init: CustomerController(),
      initState: (value) {
        // 初始化数据
        value.controller!.addState.initGroupData();
      },
      builder: (value) {
        var addState = value.addState;
        return Column(
          children: [
            ...addState.groupList.map(
              (e) => Column(
                children: [
                  buildCardItem(e),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 20),
              child: MyButton(
                  onPressed: () {
                    var t = DateTime.now().millisecondsSinceEpoch;
                    addState.groupList.add(
                      GroupEntity(id: t, groupName: '', groupDiscount: 0),
                    );
                    // addState.groupList.refresh();
                  },
                  text: '添加一项'),
            )
          ],
        );
      },
    );
  }

  Widget buildCardItem(GroupEntity item) {
    var addState = controller.addState;
    bool isActive = item.id == addState.groupId;

    final seleceButton = Positioned(
      top: 33,
      left: 5,
      child: InkWell(
        onTap: () {
          addState.addData.update((val) {
            val!.groupId = item.id;
          });
          // addState.initGroupData();
        },
        child: Container(
          decoration: isActive
              ? BoxDecoration(
                  border: Border.all(color: Colors.blue.shade400, width: 1.5),
                  borderRadius: BorderRadius.circular(50),
                )
              : BoxDecoration(),
          child: CircleAvatar(
            backgroundColor:
                isActive ? Colors.blue.shade50 : Colors.grey.shade300,
            foregroundColor: isActive ? Colors.blue.shade400 : Colors.black45,
            child: Icon(
                isActive ? Icons.check_box : Icons.check_box_outline_blank),
          ),
        ),
      ),
    );
    final deleteButton = Positioned(
      top: 33,
      right: 5,
      child: InkWell(
        onTap: () {
          cupertinoDialog(
            Get.context!,
            title: Text('确定删除吗'),
            onConfirm: () {
              var _groupList = controller.addState.groupList;
              var i = _groupList.indexWhere((e) => e.id == item.id);
              if (i >= 0) {
                controller.addState.groupList.removeAt(i);
              }
            },
          );
        },
        child: CircleAvatar(
          backgroundColor: Colors.red.shade50,
          foregroundColor: Colors.red.shade400,
          child: Icon(Icons.delete_forever),
        ),
      ),
    );
    return Stack(
      children: [
        Card(
          elevation: 1,
          color: Colors.grey.shade50,
          margin: EdgeInsets.symmetric(horizontal: 22),
          child: Container(
            width: double.infinity,
            decoration: isActive
                ? BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                  )
                : BoxDecoration(),
            child: Column(
              children: [
                TextFieldItem(
                  title: '用户组名称',
                  controller: TextEditingController(text: item.groupName),
                  onChanged: (e) {
                    for (var _item in addState.groupList) {
                      if (_item.id == item.id) {
                        _item.groupName = e;
                        break;
                      }
                    }
                  },
                ),
                Divider(height: 1),
                TextFieldItem(
                  title: '付款折扣%',
                  controller: TextEditingController(
                      text: item.groupDiscount.toString()),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
        seleceButton,
        item.id == 1 ? SizedBox() : deleteButton,
      ],
    );
  }
}
